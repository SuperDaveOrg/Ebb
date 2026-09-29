import 'dart:convert';
import 'dart:io' show gzip;
import 'dart:math';
import 'dart:typed_data';

/// Moving a backup between phones as a series of QR codes.
///
/// The payload is exactly a backup file (docs/backup-format.md), gzipped and
/// split into frames. Each frame is plain text in the QR alphanumeric
/// character set, so the code stays as small as the data allows:
///
///     EBB1:K7Q2:3/6:<base45 chunk>
///
/// `EBB1` is the frame format, `K7Q2` identifies this particular send so
/// frames from two different sends never get mixed, and `3/6` is the frame's
/// position. Frames can be scanned in any order. Integrity comes from gzip's
/// own CRC, and the result is then validated like any backup file.
///
/// No network is involved at any point: one screen, one camera.

const _magic = 'EBB1';

/// Raw bytes per frame. With the Base45 and header overhead this lands at
/// QR version 20-ish at medium error correction — dense enough to keep the
/// frame count down, sparse enough for a phone camera to read off a screen.
const qrChunkBytes = 600;

/// Splits [backupJson] into frame texts, ready to render as QR codes.
List<String> encodeTransfer(String backupJson, {Random? random}) {
  final packed = gzip.encode(utf8.encode(backupJson));
  final id = _transferId(random ?? Random.secure());
  final total = (packed.length / qrChunkBytes).ceil();
  return [
    for (var i = 0; i < total; i++)
      '$_magic:$id:${i + 1}/$total:${base45Encode(packed.sublist(i * qrChunkBytes, min((i + 1) * qrChunkBytes, packed.length)))}',
  ];
}

String _transferId(Random random) {
  const chars = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  return String.fromCharCodes(
    List.generate(4, (_) => chars.codeUnitAt(random.nextInt(chars.length))),
  );
}

/// What happened to one scanned code.
enum FrameResult {
  /// A new frame of the current send.
  added,

  /// Already had it — the sender is cycling through codes.
  duplicate,

  /// A frame from a different send (the sender started over). Progress was
  /// reset to follow the new one.
  restarted,

  /// Some other QR code — a URL, a Wi-Fi code.
  notEbb,

  /// An Ebb frame from a newer version of the app.
  newerVersion,
}

/// Collects frames, in any order, until a whole transfer has arrived.
class TransferReceiver {
  String? _id;
  int _total = 0;
  final Map<int, Uint8List> _chunks = {};

  int get received => _chunks.length;

  /// Frames in the transfer, or 0 before the first one is scanned.
  int get total => _total;

  bool get isComplete => _total > 0 && _chunks.length == _total;

  /// Which frames (1-based) are still needed.
  List<int> get missing => [
    for (var i = 1; i <= _total; i++)
      if (!_chunks.containsKey(i)) i,
  ];

  FrameResult add(String text) {
    final frame = _Frame.parse(text);
    if (frame == null) {
      return text.startsWith('EBB') && !text.startsWith('$_magic:')
          ? FrameResult.newerVersion
          : FrameResult.notEbb;
    }

    // A send is its ID *and* its length. Frames that agree on one but not
    // the other can only come from a misread, and mixing them would let a
    // frame numbered past the end count toward completion. Following the
    // newer one costs some progress, but can't get stuck on a bad first read.
    var result = FrameResult.added;
    if (_id != frame.id || _total != frame.total) {
      if (_id != null) result = FrameResult.restarted;
      _id = frame.id;
      _total = frame.total;
      _chunks.clear();
    }
    if (_chunks.containsKey(frame.index)) return FrameResult.duplicate;
    _chunks[frame.index] = frame.data;
    return result;
  }

  /// The reassembled backup JSON. Throws [FormatException] if the pieces
  /// don't form an intact archive — a misread that slipped past the QR
  /// checksums would be caught here by gzip's CRC.
  String assemble() {
    if (!isComplete) throw StateError('Transfer incomplete');
    final packed = BytesBuilder(copy: false);
    for (var i = 1; i <= _total; i++) {
      packed.add(_chunks[i]!);
    }
    try {
      return utf8.decode(gzip.decode(packed.takeBytes()));
    } on Exception catch (e) {
      throw FormatException('Transfer damaged: $e');
    }
  }
}

class _Frame {
  const _Frame(this.id, this.index, this.total, this.data);

  final String id;
  final int index;
  final int total;
  final Uint8List data;

  static final _header = RegExp(r'^EBB1:([0-9A-Z]{4}):(\d{1,4})/(\d{1,4}):');

  static _Frame? parse(String text) {
    final m = _header.firstMatch(text);
    if (m == null) return null;
    final index = int.parse(m[2]!);
    final total = int.parse(m[3]!);
    if (total < 1 || index < 1 || index > total) return null;
    final data = base45Decode(text.substring(m.end));
    if (data == null || data.isEmpty) return null;
    return _Frame(m[1]!, index, total, data);
  }
}

// Base45, RFC 9285. Two bytes become three characters from the QR
// alphanumeric set, which QR stores in 5.5 bits each — about 30% denser than
// Base64 in byte mode.

const _b45 = r'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ $%*+-./:';

String base45Encode(List<int> bytes) {
  final out = StringBuffer();
  for (var i = 0; i < bytes.length; i += 2) {
    if (i + 1 < bytes.length) {
      var n = bytes[i] * 256 + bytes[i + 1];
      for (var k = 0; k < 3; k++) {
        out.write(_b45[n % 45]);
        n ~/= 45;
      }
    } else {
      final n = bytes[i];
      out
        ..write(_b45[n % 45])
        ..write(_b45[n ~/ 45]);
    }
  }
  return out.toString();
}

/// Null if [text] isn't valid Base45.
Uint8List? base45Decode(String text) {
  if (text.length % 3 == 1) return null;
  final out = BytesBuilder(copy: false);
  for (var i = 0; i < text.length; i += 3) {
    final digits = <int>[];
    for (var k = i; k < min(i + 3, text.length); k++) {
      final d = _b45.indexOf(text[k]);
      if (d < 0) return null;
      digits.add(d);
    }
    if (digits.length == 3) {
      final n = digits[0] + digits[1] * 45 + digits[2] * 45 * 45;
      if (n > 0xFFFF) return null;
      out.add([n >> 8, n & 0xFF]);
    } else {
      final n = digits[0] + digits[1] * 45;
      if (n > 0xFF) return null;
      out.addByte(n);
    }
  }
  return out.takeBytes();
}
