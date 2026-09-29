import 'package:flutter_test/flutter_test.dart';

import 'package:ebb/models/day_log.dart';
import 'package:ebb/ui/face_picker.dart';

void main() {
  test('every extra face can be stored, and none repeats another', () {
    final faces = moreFaces.map((f) => f.$1).toList();
    for (final f in faces) {
      expect(DayFeeling.face(f), isNotNull, reason: f);
    }
    expect(faces.toSet(), hasLength(faces.length));
    // A face already offered as a named feeling would be two answers that
    // look the same.
    final shown = {...Feeling.values.map((f) => f.emoji)};
    expect(faces.where(shown.contains), isEmpty);
  });

  test('a feeling name is never mistaken for a face', () {
    for (final f in Feeling.values) {
      expect(DayFeeling.isFace(f.name), isFalse);
      expect(DayFeeling.parse(f.name)?.named, f);
    }
  });
}
