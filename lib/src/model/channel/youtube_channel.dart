import 'package:youtube_api/src/enum/result_type.dart';
import 'package:youtube_api/src/model/channel/channel_snippet.dart';
import 'package:youtube_api/src/model/youtube_api_result.dart';

class YoutubeChannel extends ApiResult {
  YoutubeChannel(data, {bool isSingleResult = false})
      : super(data, isSingleResult: isSingleResult) {
    final snippet_ = data["snippet"];
    if (snippet_ != null) snippet = ChannelSnippet.fromJsonData(snippet_);
  }
  covariant late final ChannelSnippet? snippet;
  @override
  ResultType get type => ResultType.channel;
}
