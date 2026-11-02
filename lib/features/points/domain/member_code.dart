/// Rotating payload for the member QR code.
///
/// The code changes every [period], so a screenshot of someone else's code
/// stops working quickly. In production the token would be a TOTP derived
/// from a secret issued by the backend; here it is a deterministic hash.
class MemberCode {
  const MemberCode({
    required this.payload,
    required this.secondsRemaining,
  });

  static const period = Duration(seconds: 60);

  final String payload;
  final int secondsRemaining;

  factory MemberCode.at(String memberNumber, DateTime now) {
    final seconds = now.millisecondsSinceEpoch ~/ 1000;
    final window = seconds ~/ period.inSeconds;
    final token = _fnv1a('$memberNumber:$window') % 1000000;
    return MemberCode(
      payload: 'KMB1:$memberNumber:${token.toString().padLeft(6, '0')}',
      secondsRemaining: period.inSeconds - seconds % period.inSeconds,
    );
  }

  /// 32-bit FNV-1a hash.
  static int _fnv1a(String input) {
    var hash = 0x811c9dc5;
    for (final unit in input.codeUnits) {
      hash ^= unit;
      hash = (hash * 0x01000193) & 0xffffffff;
    }
    return hash;
  }
}

/// "8100123456789012" -> "8100 1234 5678 9012"
String formatMemberNumber(String number) => [
      for (var i = 0; i < number.length; i += 4)
        number.substring(i, (i + 4).clamp(0, number.length)),
    ].join(' ');
