import 'package:youtube_api/src/enum/video/chart.dart';
import 'package:youtube_api/src/enum/video/my_rating.dart';
import 'package:youtube_api/src/enum/video/video_part.dart';
import 'package:youtube_api/src/model/options.dart';

class VideoOptions extends SpecificKindOptions {
  const VideoOptions({
    this.parts = const {VideoPart.snippet},
    this.chart,
    super.id,
    this.myRating,
    super.maxResults,
    super.onBehalfOfContentOwner,
    super.pageToken,
    super.regionCode,
    super.hl,
    this.maxHeight,
    this.maxWidth,
  });

  final Set<VideoPart> parts;

  final Chart? chart;

  final MyRating? myRating;

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
        QueryParameter.part.name: parts.map((part) => part.name).join(','),
        if (chart != null) QueryParameter.chart.name: chart!.name,
        if (id != null) QueryParameter.id.name: id!.join(','),
        if (myRating != null) QueryParameter.myRating.name: myRating!.name,
        if (hl != null) QueryParameter.hl.name: hl!,
        if (maxHeight != null) QueryParameter.maxHeight.name: "$maxHeight",
        if (maxWidth != null) QueryParameter.maxWidth.name: "$maxWidth",
      };

  VideoOptions copyWith({
    Set<VideoPart>? parts,
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
  }) =>
      VideoOptions(
        parts: parts ?? this.parts,
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
