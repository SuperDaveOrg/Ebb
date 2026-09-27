import 'package:flutter/services.dart';

/// Android's own Save and Open pickers, via MainActivity.
///
/// She picks the location every time. Ebb never writes a file on its own and
/// never learns where the file went beyond the one document she chose.
class DocumentService {
  static const _channel = MethodChannel('ebb/documents');

  /// Offers to save [bytes] as [suggestedName]. False if she backed out.
  Future<bool> save(String suggestedName, Uint8List bytes) async {
    final saved = await _channel.invokeMethod<bool>(
        'save', {'name': suggestedName, 'bytes': bytes});
    return saved ?? false;
  }

  /// The chosen file's contents, or null if she backed out.
  Future<Uint8List?> open() => _channel.invokeMethod<Uint8List>('open');
}
