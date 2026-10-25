import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:ebb/data/cycle_repository.dart';
import 'package:ebb/domain/cycle_rules.dart';
import 'package:ebb/domain/dates.dart';
import 'package:ebb/models/cycle.dart';
import 'package:ebb/ui/confirm.dart';
import 'package:ebb/ui/language.dart';
import 'package:ebb/ui/wording.dart';

/// Plain-language wording for each [CycleProblem].
String describeCycleProblem(CycleProblem problem) => switch (problem) {
  CycleProblem.startInFuture => strings.homeProblemStartInFuture,
  CycleProblem.endInFuture => strings.homeProblemEndInFuture,
  CycleProblem.endBeforeStart => strings.homeProblemEndBeforeStart,
  CycleProblem.duplicateStart => strings.homeProblemDuplicateStart,
  CycleProblem.overlapsPrevious => strings.homeProblemOverlapsPrevious,
  CycleProblem.overlapsNext => strings.homeProblemOverlapsNext,
};

/// Opens the editor for [cycle], or for a new past period when [cycle] is
/// null. Returns the edited cycle, or null if she backed out.
///
/// [all] is every recorded cycle, used to catch overlaps before saving.
Future<Cycle?> showCycleEditor(
  BuildContext context, {
  Cycle? cycle,
  required List<Cycle> all,
  VoidCallback? onDelete,
}) {
  return showModalBottomSheet<Cycle>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (_) => _CycleEditor(initial: cycle, all: all, onDelete: onDelete),
  );
}

/// Opens the editor for an existing [cycle] and saves the result to
/// [repository], or deletes the cycle once she confirms. [onChanged] runs
/// after either.
Future<void> editCycle(
  BuildContext context, {
  required CycleRepository repository,
  required Cycle cycle,
  required List<Cycle> all,
  required Future<void> Function() onChanged,
}) async {
  Future<void> delete() async {
    final confirmed = await confirm(
      context,
      title: context.l.homeDeleteCycleTitle,
      body: context.l.homeDeleteCycleBody(
        DateFormat.yMMMd().format(cycle.start),
      ),
      action: context.l.delete,
    );
    if (!confirmed || cycle.id == null) return;
    await repository.deleteCycle(cycle.id!);
    await onChanged();
  }

  final edited = await showCycleEditor(
    context,
    cycle: cycle,
    all: all,
    onDelete: delete,
  );
  if (edited == null) return;
  await repository.updateCycle(edited);
  await onChanged();
}

class _CycleEditor extends StatefulWidget {
  const _CycleEditor({required this.initial, required this.all, this.onDelete});

  final Cycle? initial;
  final List<Cycle> all;

  /// Offered for an existing period. The sheet closes first; the caller
  /// asks for confirmation.
  final VoidCallback? onDelete;

  @override
  State<_CycleEditor> createState() => _CycleEditorState();
}

class _CycleEditorState extends State<_CycleEditor> {
  static DateFormat get _fmt => DateFormat.yMMMEd();

  late DateTime _start;
  DateTime? _end;
  late bool _excluded;
  late final _notes = TextEditingController(text: widget.initial?.notes);

  bool get _isNew => widget.initial == null;

  @override
  void initState() {
    super.initState();
    final c = widget.initial;
    _start = c?.start ?? today();
    _end = c?.end;
    _excluded = c?.excluded ?? false;
  }

  @override
  void dispose() {
    _notes.dispose();
    super.dispose();
  }

  Cycle get _candidate {
    final notes = _notes.text.trim();
    return Cycle(
      id: widget.initial?.id,
      start: _start,
      end: _end,
      notes: notes.isEmpty ? null : notes,
      excluded: _excluded,
    );
  }

  /// A missing end on the most recent, recent-enough cycle means it's still
  /// going; otherwise it just wasn't recorded.
  bool get _stillGoing =>
      Cycle(start: _start).inProgressOn(today()) &&
      widget.all
          .where((c) => c.id != widget.initial?.id)
          .every((c) => c.start.isBefore(_start));

  Future<void> _pickStart() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _start,
      firstDate: DateTime(2000),
      lastDate: today(),
      helpText: context.l.homeFirstDayOfPeriod,
    );
    if (picked != null) setState(() => _start = dateOnly(picked));
  }

  Future<void> _pickEnd() async {
    // The picker asserts if its initial date falls before firstDate, which
    // happens when the start has just been moved past the old end.
    final end = _end;
    final picked = await showDatePicker(
      context: context,
      initialDate: end != null && !end.isBefore(_start) ? end : _start,
      firstDate: _start,
      lastDate: today(),
      helpText: context.l.homeLastDayOfPeriod,
    );
    if (picked != null) setState(() => _end = dateOnly(picked));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final problem = checkCycle(_candidate, widget.all);
    final end = _end;

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
                child: Text(
                  _isNew
                      ? context.l.homeAddPastPeriodTitle
                      : context.l.homeEditPeriod,
                  style: theme.textTheme.titleLarge,
                ),
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                leading: const Icon(Icons.water_drop_outlined),
                title: Text(context.l.homeStarted),
                subtitle: Text(_fmt.format(_start)),
                onTap: _pickStart,
              ),
              ListTile(
                contentPadding: const EdgeInsets.fromLTRB(24, 0, 12, 0),
                leading: const Icon(Icons.check),
                title: Text(context.l.homeEnded),
                subtitle: Text(
                  end != null
                      ? _fmt.format(end)
                      : _stillGoing
                      ? context.l.homeStillGoing
                      : context.l.homeNotRecorded,
                ),
                onTap: _pickEnd,
                trailing: end == null
                    ? null
                    : IconButton(
                        icon: const Icon(Icons.close),
                        tooltip: context.l.homeClearEnd,
                        onPressed: () => setState(() => _end = null),
                      ),
              ),
              SwitchListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                title: Text(context.l.homeCountInPredictions),
                subtitle: Text(context.l.homeCountInPredictionsHint),
                value: !_excluded,
                onChanged: (v) => setState(() => _excluded = !v),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
                child: TextField(
                  controller: _notes,
                  minLines: 1,
                  maxLines: 4,
                  maxLength: 500,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    labelText: context.l.homeNote,
                    helperText: _excluded
                        ? context.l.homeNoteExcludedHint
                        : context.l.homeNoteHint,
                    helperMaxLines: 2,
                  ),
                ),
              ),
              if (problem != null)
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
                  child: Text(
                    describeCycleProblem(problem),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.error,
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                // The theme makes filled buttons full-width, so each one needs a
                // bounded slot here.
                child: Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(context.l.cancel),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton(
                        onPressed: problem == null
                            ? () => Navigator.of(context).pop(_candidate)
                            : null,
                        child: Text(context.l.save),
                      ),
                    ),
                  ],
                ),
              ),
              if (!_isNew && widget.onDelete != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Center(
                    child: TextButton.icon(
                      style: TextButton.styleFrom(
                        foregroundColor: theme.colorScheme.error,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        widget.onDelete!();
                      },
                      icon: const Icon(Icons.delete_outline),
                      label: Text(context.l.homeDeletePeriod),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
