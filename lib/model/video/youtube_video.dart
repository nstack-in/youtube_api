import 'package:youtube_api_client/enum/result_type.dart';
import 'package:youtube_api_client/model/video/video_content_details.dart';
import 'package:youtube_api_client/model/video/video_snippet.dart';
import 'package:youtube_api_client/model/youtube_api_result.dart';

class YoutubeVideo extends ApiResult {
  YoutubeVideo(data, {bool isSingleResult = false})
      : super(data, isSingleResult: isSingleResult) {
    final snippet_ = data["snippet"];
    if (snippet_ != null) snippet = VideoSnippet.fromJsonData(snippet_);
    final contentDetails_ = data["contentDetails"];
    if (contentDetails_ != null)
      contentDetails = VideoContentDetails.fromJsonData(contentDetails_);
  }
  late final VideoContentDetails? contentDetails;
  covariant late final VideoSnippet? snippet;

  @override
  ResultType get type => ResultType.video;

  String getURL() => ApiResult.getURL(ResultType.video, id);
}
