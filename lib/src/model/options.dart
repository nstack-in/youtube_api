import 'package:youtube_api/src/enum/query_parameter.dart';

export 'package:youtube_api/src/enum/query_parameter.dart';

abstract class Options {
  const Options({
    this.maxResults,
    this.onBehalfOfContentOwner,
    this.pageToken,
    this.regionCode,
  });

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
        if (maxResults != null) QueryParameter.maxResults.name: "$maxResults",
        if (onBehalfOfContentOwner != null)
          QueryParameter.onBehalfOfContentOwner.name: onBehalfOfContentOwner!,
        if (pageToken != null) QueryParameter.pageToken.name: pageToken!,
        if (regionCode != null) QueryParameter.regionCode.name: regionCode!,
      };
}

abstract class SpecificKindOptions extends Options {
  const SpecificKindOptions({
    this.id,
    this.hl,
    super.maxResults,
    super.onBehalfOfContentOwner,
    super.pageToken,
    super.regionCode,
  });

  /// The `id` parameter specifies a comma-separated list of the YouTube
  /// video ID(s) for the resource(s) that are being retrieved. In a `video`
  /// resource, the `id` property specifies the video's ID.
  ///
  /// `string`
  final List<String>? id;

  /// The `hl` parameter instructs the API to retrieve localized resource
  /// metadata for a specific[application language that the YouTube website
  /// supports. The parameter value must be a language code included in the list
  /// returned by the `i18nLanguages.list` method.
  ///
  /// `string`
  ///
  /// If localized resource details are available in that language, the
  /// resource's `snippet.localized` object will contain the localized values.
  /// However, if localized details are not available, the `snippet.localized`
  /// object will contain resource details in the resource's default language.
  final String? hl;

  @override
  Map<String, String> getMap(String key) => {
        ...super.getMap(key),
        if (id != null) QueryParameter.id.name: id!.join(','),
        if (hl != null) QueryParameter.hl.name: hl!,
      };
}
