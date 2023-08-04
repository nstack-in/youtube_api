import 'package:youtube_api/src/enum/data_part.dart';
import 'package:youtube_api/src/enum/query_parameter.dart';

export 'package:youtube_api/src/enum/query_parameter.dart';
export 'package:youtube_api/src/enum/chart.dart';
export 'package:youtube_api/src/enum/data_part.dart';
export 'package:youtube_api/src/enum/my_rating.dart';
export 'package:youtube_api/src/enum/channel_type.dart';
export 'package:youtube_api/src/enum/event_type.dart';
export 'package:youtube_api/src/enum/oder.dart';
export 'package:youtube_api/src/enum/result_type.dart';
export 'package:youtube_api/src/enum/safe_search.dart';
export 'package:youtube_api/src/enum/video_caption.dart';
export 'package:youtube_api/src/enum/video_definition.dart';
export 'package:youtube_api/src/enum/video_dimension.dart';
export 'package:youtube_api/src/enum/video_duration.dart';
export 'package:youtube_api/src/enum/video_embeddable.dart';
export 'package:youtube_api/src/enum/video_license.dart';
export 'package:youtube_api/src/enum/video_syndicated.dart';
export 'package:youtube_api/src/enum/video_type.dart';
export 'package:youtube_api/src/enum/category.dart';
export 'package:youtube_api/src/enum/topic.dart';

abstract class Options {
  const Options({
    required this.part,
    this.maxResults,
    this.onBehalfOfContentOwner,
    this.pageToken,
    this.regionCode,
  });

  /// The `part` parameter specifies a comma-separated list of one or more
  /// `search` resource properties that the API response will include. Set the
  /// parameter value to `snippet`.
  ///
  ///`string`
  final DataPart part;

  /// The `maxResults` parameter specifies the maximum number of items that
  /// should be returned in the result set. Acceptable values are `0` to `50`,
  /// inclusive. The default value is `5`.
  ///
  /// `unsigned integer`
  final int? maxResults;

  /// This parameter can only be used in a properly authorized
  /// request. **Note:** This parameter is
  /// intended exclusively for YouTube content partners.
  ///
  /// `string`
  ///
  /// The `onBehalfOfContentOwner` parameter indicates that the request's
  /// authorization credentials identify a YouTube CMS user who is acting on
  /// behalf of the content owner specified in the parameter value. This
  /// parameter is intended for YouTube content partners that own and manage
  /// many different YouTube channels. It allows content owners to authenticate
  /// once and get access to all their video and channel data, without having to
  /// provide authentication credentials for each individual channel. The CMS
  /// account that the user authenticates with must be linked to the specified
  /// YouTube content owner.
  final String? onBehalfOfContentOwner;

  /// The `pageToken` parameter identifies a specific page in the result set
  /// that should be returned. In an API response, the `nextPageToken` and
  /// `prevPageToken` properties identify other pages that could be retrieved.
  ///
  /// `string`
  final String? pageToken;

  /// The `regionCode` parameter instructs the API to return search results for
  /// videos that can be viewed in the specified country. The parameter value is
  /// an ISO 3166-1 alpha-2 country code.
  ///
  /// `string`
  final String? regionCode;

  Map<String, String> getMap(String key) => {
        "key": key,
        QueryParameter.part.name: part.name,
        if (maxResults != null) QueryParameter.maxResults.name: "$maxResults",
        if (onBehalfOfContentOwner != null)
          QueryParameter.onBehalfOfContentOwner.name: onBehalfOfContentOwner!,
        if (pageToken != null) QueryParameter.pageToken.name: pageToken!,
        if (regionCode != null) QueryParameter.regionCode.name: regionCode!,
      };
}
