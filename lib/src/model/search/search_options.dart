import 'package:youtube_api/src/enum/category.dart';
import 'package:youtube_api/src/enum/result_type.dart';
import 'package:youtube_api/src/enum/search/channel_type.dart';
import 'package:youtube_api/src/enum/search/event_type.dart';
import 'package:youtube_api/src/enum/search/order.dart';
import 'package:youtube_api/src/enum/search/safe_search.dart';
import 'package:youtube_api/src/enum/search/search_part.dart';
import 'package:youtube_api/src/enum/search/topic.dart';
import 'package:youtube_api/src/enum/video_caption.dart';
import 'package:youtube_api/src/enum/video_definition.dart';
import 'package:youtube_api/src/enum/video_dimension.dart';
import 'package:youtube_api/src/enum/video_duration.dart';
import 'package:youtube_api/src/enum/video_embeddable.dart';
import 'package:youtube_api/src/enum/video_license.dart';
import 'package:youtube_api/src/enum/video_syndicated.dart';
import 'package:youtube_api/src/enum/video_type.dart';
import 'package:youtube_api/src/model/options.dart';

class SearchOptions extends Options {
  const SearchOptions({
    this.parts = const {SearchPart.snippet},
    this.forContentOwner,
    this.forDeveloper,
    this.forMine,
    this.channelId,
    this.channelType,
    this.eventType,
    this.location,
    this.locationRadius,
    super.maxResults,
    super.onBehalfOfContentOwner,
    this.order,
    super.pageToken,
    this.publishedAfter,
    this.publishedBefore,
    this.query,
    super.regionCode,
    this.relevanceLanguage,
    this.safeSearch,
    this.topic,
    this.type,
    this.videoCaption,
    this.category,
    this.videoDefinition,
    this.videoDimension,
    this.videoDuration,
    this.videoEmbeddable,
    this.videoLicense,
    this.videoSyndicated,
    this.videoType,
  });
  final Set<SearchPart> parts;

  /// This parameter can only be used in a properly authorized request, and it
  /// is intended exclusively for YouTube content partners.
  ///
  /// `boolean`
  ///
  /// The `forContentOwner` parameter restricts the search to only retrieve
  /// videos owned by the content owner identified by the
  /// `onBehalfOfContentOwner` parameter. If `forContentOwner` is set to
  /// true, the request must also meet these requirements:
  ///
  /// *   The `onBehalfOfContentOwner` parameter is required.
  /// *   The user authorizing the request must be using an account linked to
  ///     the specified content owner.
  /// *   The `type` parameter value must be set to `video`.
  /// *   None of the following other parameters can be set: `videoDefinition`,
  ///     `videoDimension`, `videoDuration`, `videoLicense`, `videoEmbeddable`,
  ///     `videoSyndicated`, `videoType`.
  final bool? forContentOwner;

  /// This parameter can only be used in a properly authorized request. The
  /// `forDeveloper` parameter restricts the search to only retrieve videos
  /// uploaded via the developer's application or website. The API server uses
  /// the request's authorization credentials to identify the developer. The
  /// `forDeveloper` parameter can be used in conjunction with optional search
  /// parameters like the `q` parameter.
  ///
  /// `boolean`
  ///
  /// For this feature, each uploaded video is automatically tagged with the
  /// project number that is associated with the developer's application in the
  /// [Google Developers Console](https://console.developers.google.com).
  ///
  /// When a search request subsequently sets the `forDeveloper` parameter to
  /// `true`, the API server uses the request's authorization credentials to
  /// identify the developer. Therefore, a developer can restrict results to
  /// videos uploaded through the developer's own app or website but not to
  /// videos uploaded through other apps or sites.
  final bool? forDeveloper;

  /// This parameter can only be used in a properly authorized request. The
  /// `forMine` parameter restricts the search to only retrieve videos owned by
  /// the authenticated user. If you set this parameter to `true`, then the
  /// `type` parameter's value must also be set to `video`. In addition, none of
  /// the following other parameters can be set in the same request:
  /// `videoDefinition`, `videoDimension`, `videoDuration`, `videoLicense`,
  /// `videoEmbeddable`, `videoSyndicated`, `videoType`.
  ///
  /// `boolean`
  final bool? forMine;

  /// The `channelId` parameter indicates that the API response should only
  /// contain resources created by the channel.
  ///
  /// **Note:** Search results are constrained to a maximum of 500 videos if your
  /// request specifies a value for the `channelId` parameter and sets the `type`
  /// parameter value to `video`, but it does not also set one of the
  /// `forContentOwner`, `forDeveloper`, or `forMine` filters.
  ///
  /// `string`
  final String? channelId;

  /// The `channelType` parameter lets you restrict a search to a particular
  /// type of channel.
  ///
  /// `string`
  ///
  /// Acceptable values are:
  /// *   `any` – Return all channels.
  /// *   `show` – Only retrieve shows.
  final ChannelType? channelType;

  /// The `eventType` parameter restricts a search to broadcast events. If
  /// you specify a value for this parameter, you must also set the
  /// `type` parameter's value to `video`.
  ///
  /// `string`
  ///
  /// Acceptable values are:
  ///
  /// *   `completed` – Only include completed broadcasts.
  /// *   `live` – Only include active broadcasts.
  /// *   `upcoming` – Only include upcoming broadcasts.
  final EventType? eventType;

  /// The `location` parameter, in conjunction with the `locationRadius`
  /// parameter, defines a circular geographic area and also restricts a search
  /// to videos that specify, in their metadata, a geographic location that
  /// falls within that area. The parameter value is a string that specifies
  /// latitude/longitude coordinates e.g. (`37.42307,-122.08427`).
  ///
  /// `string`
  ///
  /// *   The `location` parameter value identifies the point at the center of
  ///     the area.
  /// *   The `locationRadius` parameter specifies the maximum distance that the
  ///     location associated with a video can be from that point for the video
  ///     to still be included in the search results.
  ///
  /// The API returns an error if your request specifies a value for the
  /// `location` parameter but does not also specify a value for the
  /// `locationRadius` parameter.
  ///
  /// **Note:** If you specify a value for this parameter, you must also set the
  /// `type` parameter's value to `video`.
  final String? location;

  /// The `locationRadius` parameter, in conjunction with the `location`
  /// parameter, defines a circular geographic area.
  ///
  /// `string`
  ///
  /// The parameter value must be a floating point number followed by a
  /// measurement unit. Valid measurement units are `m`, `km`, `ft`, and `mi`.
  /// For example, valid parameter values include `1500m`, `5km`, `10000ft`, and
  /// `0.75mi`. The API does not support `locationRadius` parameter values
  /// larger than 1000 kilometers.
  ///
  /// **Note:** See the definition of the `location` parameter for
  /// more information.
  final String? locationRadius;

  /// The `order` parameter specifies the method that will be used to order
  /// resources in the API response. The default value is `relevance`.
  ///
  /// `string`
  ///
  /// Acceptable values are:
  ///
  /// *   `date` – Resources are sorted in reverse chronological order based
  ///     on the date they were created.
  /// *   `rating` – Resources are sorted from highest to lowest rating.
  /// *   `relevance` – Resources are sorted based on their relevance to the
  ///     search query. This is the default value for this parameter.
  /// *   `title` – Resources are sorted alphabetically by title.
  /// *   `videoCount` – Channels are sorted in descending order of their
  ///     number of uploaded videos.
  /// *   `viewCount` – Resources are sorted from highest to lowest number of
  ///     views. For live broadcasts, videos are sorted by number of concurrent
  ///     viewers while the broadcasts are ongoing.
  final Order? order;

  /// The `publishedAfter` parameter indicates that the API response should
  /// only contain resources created at or after the specified time. The value
  /// is an RFC 3339 formatted date-time value (1970-01-01T00:00:00Z).
  ///
  /// `datetime`
  final DateTime? publishedAfter;

  /// The `publishedBefore` parameter indicates that the API response should
  /// only contain resources created before or at the specified time. The value
  /// is an RFC 3339 formatted date-time value (1970-01-01T00:00:00Z).
  ///
  /// `datetime`
  final DateTime? publishedBefore;

  /// The `q` parameter specifies the query term to search for.
  ///
  /// `string`
  ///
  /// Your request can also use the Boolean NOT (`-`) and OR (`|`) operators to
  /// exclude videos or to find videos that are associated with one of several
  /// search terms. For example, to search for videos matching either "boating"
  /// or "sailing", set the `q` parameter value to `boating|sailing`. Similarly,
  /// to search for videos matching either "boating" or "sailing" but not
  /// "fishing", set the `q` parameter value to `boating|sailing -fishing`. Note
  /// that the pipe character must be URL-escaped when it is sent in your API
  /// request. The URL-escaped value for the pipe character is `%7C`.
  final String? query;

  /// The `relevanceLanguage` parameter instructs the API to return search
  /// results that are most relevant to the specified language. The parameter
  /// value is typically an ISO 639-1 two-letter language code. However, you
  /// should use the values `zh-Hans` for simplified Chinese and `zh-Hant` for
  /// traditional Chinese. Please note that results in other languages will
  /// still be returned if they are highly relevant to the search query term.
  ///
  /// `string`
  final String? relevanceLanguage;

  /// The `safeSearch` parameter indicates whether the search results should
  /// include restricted content as well as standard content.
  ///
  /// `string`
  ///
  /// Acceptable values are:
  ///
  /// *   `moderate` – YouTube will filter some content from search results and,
  ///     at the least, will filter content that is restricted in your locale.
  ///     Based on their content, search results could be removed from search
  ///     results or demoted in search results. This is the default parameter
  ///     value.
  /// *   `none` – YouTube will not filter the search result set.
  /// *   `strict` – YouTube will try to exclude all restricted content from the
  ///     search result set. Based on their content, search results could be
  ///     removed from search results or demoted in search results.
  final SafeSearch? safeSearch;

  /// The `topicId` parameter indicates that the API response should only
  /// contain resources associated with the specified topic. The value
  /// identifies a Freebase topic ID.
  ///
  /// `string`
  ///
  /// **Important:** Due to the deprecation of Freebase and the Freebase API,
  /// the `topicId` parameter started working differently as of February 27,
  /// 2017. At that time, YouTube started supporting a small set of curated
  /// topic IDs, and you can only use that smaller set of IDs as values for this
  /// parameter.
  final Topic? topic;

  /// The `type` parameter restricts a search query to only retrieve a
  /// particular type of resource. The value is a comma-separated list of
  /// resource types. The default value is `video,channel,playlist`.
  ///
  /// `string`
  ///
  /// Acceptable values are:
  ///
  /// *   `channel`
  /// *   `playlist`
  /// *   `video`
  final List<ResultType>? type;

  /// The `videoCaption` parameter indicates whether the API should filter
  /// video search results based on whether they have captions. If you specify a
  /// value for this parameter, you must also set the `[type](#type)` parameter's
  /// value to `video`.
  ///
  /// `string`
  ///
  /// Acceptable values are:
  ///
  /// *   `any` – Do not filter results based on caption availability.
  /// *   `closedCaption` – Only include videos that have captions.
  /// *   `none` – Only include videos that do not have captions.
  final VideoCaption? videoCaption;

  /// The `videoCategoryId` parameter filters video search results based on
  /// their category. If you specify a value
  /// for this parameter, you must also set the `type` parameter's
  /// value to `video`.
  ///
  /// `string`
  final Category? category;

  /// The `videoDefinition` parameter lets you restrict a search to only
  /// include either high definition (HD) or standard definition (SD) videos. HD
  /// videos are available for playback in at least 720p, though higher
  /// resolutions, like 1080p, might also be available. If you specify a value for
  /// this parameter, you must also set the `type` parameter's value to
  /// `video`.
  ///
  /// `string`
  ///
  /// Acceptable values are:
  ///
  /// *   `any` – Return all videos, regardless of their resolution.
  /// *   `high` – Only retrieve HD videos.
  /// *   `standard` – Only retrieve videos in standard definition.
  final VideoDefinition? videoDefinition;

  /// The `videoDimension` parameter lets you restrict a search to only retrieve 2D
  /// or 3D videos. If you specify a value for this parameter, you must also set
  /// the `type` parameter's value to `video`.
  ///
  /// `string`
  ///
  /// Acceptable values are:
  ///
  /// *   `2d` – Restrict search results to exclude 3D videos.
  /// *   `3d` – Restrict search results to only include 3D videos.
  /// *   `any` – Include both 3D and non-3D videos in returned results. This is
  ///     the default value.
  final VideoDimension? videoDimension;

  /// The `videoDuration` parameter filters video search results based on
  /// their duration. If you specify a value for this parameter, you must also set
  /// the `type` parameter's value to `video`.
  ///
  /// `string`
  ///
  /// Acceptable values are:
  ///
  /// *   `any` – Do not filter video search results based on their duration.
  ///     This is the default value.
  /// *   `long` – Only include videos longer than 20 minutes.
  /// *   `medium` – Only include videos that are between four and 20 minutes
  ///     long (inclusive).
  /// *   `short` – Only include videos that are less than four minutes long.
  final VideoDuration? videoDuration;

  /// The `videoEmbeddable` parameter lets you to restrict a search to only videos
  /// that can be embedded into a webpage. If you specify a value for this
  /// parameter, you must also set the `type` parameter's value to
  /// `video`.
  ///
  /// `string`
  ///
  /// Acceptable values are:
  ///
  /// *   `any` – Return all videos, embeddable or not.
  /// *   `true` – Only retrieve embeddable videos.
  final VideoEmbeddable? videoEmbeddable;

  /// The `videoLicense` parameter filters search results to only include videos
  /// with a particular license. YouTube lets video uploaders choose to attach
  /// either the Creative Commons license or the standard YouTube license to each
  /// of their videos. If you specify a value for this parameter, you must also
  /// set the `type` parameter's value to `video`.
  ///
  /// `string`
  ///
  /// Acceptable values are:
  ///
  /// *   `any` – Return all videos, regardless of which license they have, that
  ///     match the query parameters.
  /// *   `creativeCommon` – Only return videos that have a Creative Commons
  ///     license. Users can reuse videos with this license in other videos that
  ///     they create. [Learn
  ///     more](http://www.google.com/support/youtube/bin/answer.py?answer=1284989).
  /// *   `youtube` – Only return videos that have the standard YouTube license.
  final VideoLicense? videoLicense;

  /// The `videoSyndicated` parameter lets you to restrict a search to only videos
  /// that can be played outside youtube.com. If you specify a value for this
  /// parameter, you must also set the `type` parameter's value to
  /// `video`.
  ///
  /// `string`
  ///
  /// Acceptable values are:
  ///
  /// *   `any` – Return all videos, syndicated or not.
  /// *   `true` – Only retrieve syndicated videos.
  final VideoSyndicated? videoSyndicated;

  /// The `videoType` parameter lets you restrict a search to a particular
  /// type of videos. If you specify a value for this parameter, you must also set
  /// the `type` parameter's value to `video`.
  ///
  /// `string`
  ///
  /// Acceptable values are:
  ///
  /// *   `any` – Return all videos.
  /// *   `episode` – Only retrieve episodes of shows.
  /// *   `movie` – Only retrieve movies.
  final VideoType? videoType;

  @override
  Map<String, String> getMap(String key) => {
        ...super.getMap(key),
        QueryParameter.part.name: parts.map((part) => part.name).join(','),
        if (forContentOwner != null)
          QueryParameter.forContentOwner.name: "$forContentOwner",
        if (forDeveloper != null)
          QueryParameter.forDeveloper.name: "$forDeveloper",
        if (forMine != null) QueryParameter.forMine.name: "$forMine",
        if (channelId != null) QueryParameter.channelId.name: channelId!,
        if (channelType != null)
          QueryParameter.channelType.name: channelType!.name,
        if (eventType != null) QueryParameter.eventType.name: eventType!.name,
        if (location != null) QueryParameter.location.name: location!,
        if (locationRadius != null)
          QueryParameter.locationRadius.name: locationRadius!,
        if (order != null) QueryParameter.order.name: order!.name,
        if (publishedAfter != null)
          QueryParameter.publishedAfter.name:
              publishedAfter!.toUtc().toIso8601String(),
        if (publishedBefore != null)
          QueryParameter.publishedBefore.name:
              publishedBefore!.toUtc().toIso8601String(),
        if (query != null) QueryParameter.q.name: query!,
        if (relevanceLanguage != null)
          QueryParameter.q.name: relevanceLanguage!,
        if (safeSearch != null)
          QueryParameter.safeSearch.name: safeSearch!.name,
        if (topic != null) QueryParameter.topicId.name: topic!.id,
        if (type != null)
          QueryParameter.type.name: type!.map((e) => e.name).join(','),
        if (videoCaption != null)
          QueryParameter.videoCaption.name: videoCaption!.name,
        if (category != null)
          QueryParameter.videoCategoryId.name: "${category!.categoryId}",
        if (videoDefinition != null)
          QueryParameter.videoDefinition.name: videoDefinition!.name,
        if (videoDimension != null)
          QueryParameter.videoDimension.name: videoDimension!.name,
        if (videoDuration != null)
          QueryParameter.videoDuration.name: videoDuration!.name,
        if (videoEmbeddable != null)
          QueryParameter.videoEmbeddable.name: videoEmbeddable!.name,
        if (videoLicense != null)
          QueryParameter.videoLicense.name: videoLicense!.name,
        if (videoSyndicated != null)
          QueryParameter.videoSyndicated.name: videoSyndicated!.name,
        if (videoType != null) QueryParameter.videoType.name: videoType!.name,
      };

  SearchOptions copyWith({
    Set<SearchPart>? part,
    int? maxResults,
    String? onBehalfOfContentOwner,
    String? pageToken,
    String? regionCode,
    bool? forContentOwner,
    bool? forDeveloper,
    bool? forMine,
    String? channelId,
    ChannelType? channelType,
    EventType? eventType,
    String? location,
    String? locationRadius,
    Order? order,
    DateTime? publishedAfter,
    DateTime? publishedBefore,
    String? query,
    String? relevanceLanguage,
    SafeSearch? safeSearch,
    Topic? topic,
    List<ResultType>? type,
    VideoCaption? videoCaption,
    Category? category,
    VideoDefinition? videoDefinition,
    VideoDimension? videoDimension,
    VideoDuration? videoDuration,
    VideoEmbeddable? videoEmbeddable,
    VideoLicense? videoLicense,
    VideoSyndicated? videoSyndicated,
    VideoType? videoType,
  }) =>
      SearchOptions(
        parts: part ?? this.parts,
        maxResults: maxResults ?? this.maxResults,
        onBehalfOfContentOwner:
            onBehalfOfContentOwner ?? this.onBehalfOfContentOwner,
        pageToken: pageToken ?? this.pageToken,
        regionCode: regionCode ?? this.regionCode,
        forContentOwner: forContentOwner ?? this.forContentOwner,
        forDeveloper: forDeveloper ?? this.forDeveloper,
        forMine: forMine ?? this.forMine,
        channelId: channelId ?? this.channelId,
        channelType: channelType ?? this.channelType,
        eventType: eventType ?? this.eventType,
        location: location ?? this.location,
        locationRadius: locationRadius ?? this.locationRadius,
        order: order ?? this.order,
        publishedAfter: publishedAfter ?? this.publishedAfter,
        publishedBefore: publishedBefore ?? this.publishedBefore,
        query: query ?? this.query,
        relevanceLanguage: relevanceLanguage ?? this.relevanceLanguage,
        safeSearch: safeSearch ?? this.safeSearch,
        topic: topic ?? this.topic,
        type: type ?? this.type,
        videoCaption: videoCaption ?? this.videoCaption,
        category: category ?? this.category,
        videoDefinition: videoDefinition ?? this.videoDefinition,
        videoDimension: videoDimension ?? this.videoDimension,
        videoDuration: videoDuration ?? this.videoDuration,
        videoEmbeddable: videoEmbeddable ?? this.videoEmbeddable,
        videoLicense: videoLicense ?? this.videoLicense,
        videoSyndicated: videoSyndicated ?? this.videoSyndicated,
        videoType: videoType ?? this.videoType,
      );
}
