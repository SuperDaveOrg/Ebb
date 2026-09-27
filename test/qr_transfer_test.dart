import 'dart:convert';
import 'dart:math';

import 'package:ebb/data/backup.dart';
import 'package:ebb/data/qr_transfer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qr/qr.dart';

import '../tool/sample_history.dart';

void main() {
  group('Base45 (RFC 9285 test vectors)', () {
    const vectors = {
      'AB': 'BB8',
      'Hello!!': '%69 VD92EX0',
      'base-45': 'UJCLQE7W581',
      'ietf!': 'QED8WEX0',
    };
    vectors.forEach((plain, encoded) {
      test(plain, () {
        expect(base45Encode(utf8.encode(plain)), encoded);
        expect(utf8.decode(base45Decode(encoded)!), plain);
      });
    });

    test('rejects invalid input', () {
      expect(base45Decode('GGW'), isNull); // 65535 < value: out of range
      expect(base45Decode('a'), isNull);
      expect(base45Decode('ab!'), isNull);
    });

    test('round-trips every byte value', () {
      final all = List.generate(256, (i) => i);
      expect(base45Decode(base45Encode(all)), all);
      expect(base45Decode(base45Encode(all.sublist(1))), all.sublist(1));
    });
  });

  final json = encodeBackup(sampleHistory(), pretty: false);

  group('frames', () {
    final frames = encodeTransfer(json, random: Random(1));

    test('stay in the QR alphanumeric set', () {
      final alnum = RegExp(r'^[0-9A-Z $%*+\-./:]+$');
      expect(frames.every(alnum.hasMatch), isTrue);
    });

    test('stay small enough for a phone camera to read off a screen', () {
      for (final f in frames) {
        final code = QrCode(
          payload: QrPayload.fromString(f),
          errorCorrectLevel: QrErrorCorrectLevel.medium,
        );
        expect(code.typeNumber, lessThanOrEqualTo(22));
      }
    });

    test('two years of daily notes fit in a handful of codes', () {
      expect(frames.length, lessThanOrEqualTo(8));
    });
  });

  group('receiving', () {
    test('reassembles in any order, ignoring repeats', () {
      final frames = encodeTransfer(json);
      final r = TransferReceiver();
      final order = [...frames, ...frames]..shuffle(Random(7));
      for (final f in order) {
        r.add(f);
      }
      expect(r.isComplete, isTrue);
      expect(r.assemble(), json);
    });

    test('reports progress and what is missing', () {
      final frames = encodeTransfer(json);
      final r = TransferReceiver();
      expect(r.add(frames.last), FrameResult.added);
      expect(r.add(frames.last), FrameResult.duplicate);
      expect(r.received, 1);
      expect(r.total, frames.length);
      expect(r.missing, [for (var i = 1; i < frames.length; i++) i]);
    });

    test('a new send replaces a half-finished one', () {
      final first = encodeTransfer(json, random: Random(1));
      final second = encodeTransfer(json, random: Random(2));
      final r = TransferReceiver()..add(first[0]);
      expect(r.add(second[1]), FrameResult.restarted);
      expect(r.received, 1);
    });

    test('a frame that disagrees on the length never completes a send', () {
      final frames = encodeTransfer(json, random: Random(1));
      final r = TransferReceiver();
      frames.take(frames.length - 1).forEach(r.add);
      // Same send ID, but numbered past the end: only a misread does that.
      final id = frames.first.split(':')[1];
      final n = frames.length + 1;
      expect(r.add('EBB1:$id:$n/$n:BB8'), FrameResult.restarted);
      expect(r.isComplete, isFalse);
      expect(r.received, 1);
    });

    test('other QR codes are ignored', () {
      final r = TransferReceiver();
      expect(r.add('https://example.com'), FrameResult.notEbb);
      expect(r.add('WIFI:S:home;T:WPA;P:secret;;'), FrameResult.notEbb);
      expect(r.add('EBB9:ABCD:1/1:BB8'), FrameResult.newerVersion);
      expect(r.add('EBB1:ABCD:2/1:BB8'), FrameResult.notEbb);
      expect(r.received, 0);
    });

    test('a corrupted frame is caught on assembly', () {
      final frames = encodeTransfer(json);
      final r = TransferReceiver();
      for (final f in frames) {
        // Flip one data character in the middle of the first frame.
        final i = f.length ~/ 2;
        final bad = f == frames.first
            ? f.replaceRange(i, i + 1, f[i] == '0' ? '1' : '0')
            : f;
        r.add(bad);
      }
      expect(r.assemble, throwsFormatException);
    });

    test('the result is the original backup', () {
      final frames = encodeTransfer(json);
      final r = TransferReceiver();
      frames.forEach(r.add);
      final back = decodeBackup(r.assemble());
      expect(back.cycleCount, sampleHistory().cycleCount);
      expect(back.people.map((p) => p.profile.name), [null, 'Sam']);
    });
  });
}
