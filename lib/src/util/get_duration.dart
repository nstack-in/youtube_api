import 'package:iso8601_duration/iso8601_duration.dart';

extension DurationExtension on Duration {
  static Duration fromIsoDurationString(String duration) {
    final ISODuration isoDuration =
        ISODurationConverter().parseString(isoDurationString: duration);
    return Duration(
      days: isoDuration.day?.toInt() ?? 0,
      hours: isoDuration.hour?.toInt() ?? 0,
      minutes: isoDuration.minute?.toInt() ?? 0,
      seconds: isoDuration.seconds?.toInt() ?? 0,
    );
  }
}
