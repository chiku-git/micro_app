
import 'package:micro_memo/importer.dart';
import 'package:crypto/crypto.dart';

@immutable
class Passcode {
  final String value;
  late final Digest digest;

  Passcode(this.value) {
    _createDigest();
  }

  _createDigest() {
    final byte = utf8.encode(value);
    digest = sha1.convert(byte);
  }

  String get digestHex {
    return digest.toString();
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    if (other is Passcode && runtimeType == other.runtimeType) {
      return digest == other.digest;
    } else {
      return false;
    }
  }

  @override
  int get hashCode => digest.hashCode;

  @override
  String toString() => "passcode: $value, digest(hex): $digestHex";
}