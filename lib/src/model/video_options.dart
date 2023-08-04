import 'package:youtube_api/src/model/options.dart';

class VideoOptions extends Options {
  const VideoOptions({
    super.part = DataPart.snippet,
    this.chart,
    this.id,
    this.myRating,
    super.maxResults,
    super.onBehalfOfContentOwner,
    super.pageToken,
    super.regionCode,
    this.hl,
    this.maxHeight,
    this.maxWidth,
  });

  final Chart? chart;

  /// The `id` parameter specifies a comma-separated list of the YouTube
  /// video ID(s) for the resource(s) that are being retrieved. In a `video`
  /// resource, the `id` property specifies the video's ID.
  ///
  /// `string`
  final List<String>? id;

  final MyRating? myRating;

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

  /// The `maxHeight` parameter specifies the maximum height of the embedded
  /// player returned in the `player.embedHtml` property. You can use this
  /// parameter to specify that instead of the default dimensions, the embed
  /// code should use a height appropriate for your application layout. If the
  /// `maxWidth` parameter is also provided, the player may be shorter than the
  /// `maxHeight` in order to not violate the maximum width. Acceptable values
  /// are `72` to `8192`, inclusive.
  ///
  /// `unsigned integer`
  final int? maxHeight;

  /// The `maxWidth` parameter specifies the maximum width of the embedded
  /// player returned in the `player.embedHtml` property. You can use this
  /// parameter to specify that instead of the default dimensions, the embed
  /// code should use a width appropriate for your application layout.
  ///
  /// `unsigned integer`
  ///
  /// If the `maxHeight` parameter is also provided, the player may be narrower
  /// than `maxWidth` in order to not violate the maximum height. Acceptable
  /// values are `72` to `8192`, inclusive.
  final String? maxWidth;

  @override
  Map<String, String> getMap(String key) => {
        ...super.getMap(key),
        if (chart != null) QueryParameter.chart.name: "$chart",
        if (id != null) QueryParameter.id.name: id!.join(','),
        if (myRating != null) QueryParameter.myRating.name: myRating!.name,
        if (hl != null) QueryParameter.hl.name: hl!,
        if (maxHeight != null) QueryParameter.maxHeight.name: "$maxHeight",
        if (maxWidth != null) QueryParameter.maxWidth.name: "$maxWidth",
      };

  VideoOptions copyWith({
    DataPart? part,
    int? maxResults,
    String? onBehalfOfContentOwner,
    String? pageToken,
    String? regionCode,
    Chart? chart,
    List<String>? id,
    MyRating? myRating,
    String? hl,
    int? maxHeight,
    String? maxWidth,
  }) {
    return VideoOptions(
      part: part ?? this.part,
      maxResults: maxResults ?? this.maxResults,
      onBehalfOfContentOwner:
          onBehalfOfContentOwner ?? this.onBehalfOfContentOwner,
      pageToken: pageToken ?? this.pageToken,
      regionCode: regionCode ?? this.regionCode,
      chart: chart ?? this.chart,
      id: id ?? this.id,
      myRating: myRating ?? this.myRating,
      hl: hl ?? this.hl,
      maxHeight: maxHeight ?? this.maxHeight,
      maxWidth: maxWidth ?? this.maxWidth,
    );
  }
}
