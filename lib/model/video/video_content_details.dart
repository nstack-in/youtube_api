import 'package:youtube_api_client/util/duration_extension.dart';
import 'package:youtube_api_client/video.dart';

/// The contentDetails object contains information about the video content,
/// including the length of the video and an indication of whether captions are
/// available for the video.
class VideoContentDetails {
  VideoContentDetails({
    this.duration,
    this.dimension,
    this.definition,
    this.caption,
    this.licensedContent,
    this.projection,
  });
  factory VideoContentDetails.fromJsonData(Map<String, dynamic> data) {
    final duration =
        DurationExtension.fromIsoDurationString(data["duration"] ?? '');
    final dimension = VideoDimension.fromString(data["dimension"] ?? '');
    final definition = VideoDefinition.fromString(data["definition"] ?? '');
    final caption = VideoCaption.fromString(data["caption"] ?? '');
    final licensedContent = data["licensedContent"];
    final projection = VideoProjection.fromString(data["projection"] ?? '');

    return VideoContentDetails(
      duration: duration,
      dimension: dimension,
      definition: definition,
      caption: caption,
      licensedContent: licensedContent,
      projection: projection,
    );
  }

  /// The length of the video. The property value is an ISO 8601 duration. For
  /// example, for a video that is at least one minute long and less than one
  /// hour long, the duration is in the format `PT#M#S`, in which the letters
  /// `PT` indicate that the value specifies a period of time, and the letters
  /// `M` and `S` refer to length in minutes and seconds, respectively. The `#`
  /// characters preceding the `M` and `S` letters are both integers that
  /// specify the number of minutes (or seconds) of the video. For example, a
  /// value of `PT15M33S` indicates that the video is 15 minutes and 33 seconds
  /// long.
  ///
  /// If the video is at least one hour long, the duration is in the format
  /// `PT#H#M#S`, in which the `#` preceding the letter `H` specifies the length
  /// of the video in hours and all of the other details are the same as
  /// described above. If the video is at least one day long, the letters `P`
  /// and `T` are separated, and the value's format is `P#DT#H#M#S`. Please
  /// refer to the ISO 8601 specification for complete details.
  final Duration? duration;

  /// Indicates whether the video is available in 3D or in 2D.
  final VideoDimension? dimension;

  /// Indicates whether the video is available in high definition (HD) or only
  /// in standard definition.
  final VideoDefinition? definition;

  /// Indicates whether captions are available for the video.
  final VideoCaption? caption;

  /// Indicates whether the video represents licensed content, which means that
  /// the content was uploaded to a channel linked to a YouTube content partner
  /// and then claimed by that partner.
  final bool? licensedContent;

  /// Specifies the projection format of the video.
  final VideoProjection? projection;

  // TODO(hyungtaecf): Implement regionRestriction
  //   "regionRestriction": {
  //     "allowed": [
  //       string
  //     ],
  //     "blocked": [
  //       string
  //     ]
  //   }

  // TODO(hyungtaecf): Implement contentRating
  // TODO(hyungtaecf): Implement hasCustomThumbnail
}
