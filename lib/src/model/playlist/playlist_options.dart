import 'package:youtube_api/src/enum/playlist/playlist_part.dart';
import 'package:youtube_api/src/model/options.dart';

class PlaylistOptions extends SpecificKindOptions {
  const PlaylistOptions({
    this.parts = const {PlaylistPart.snippet},
    super.id,
    super.hl,
    super.maxResults,
    super.onBehalfOfContentOwner,
    super.pageToken,
    super.regionCode,
  });
  final Set<PlaylistPart> parts;

  @override
  Map<String, String> getMap(String key) => {
        ...super.getMap(key),
        QueryParameter.part.name: parts.map((part) => part.name).join(','),
      };

  PlaylistOptions copyWith({
    Set<PlaylistPart>? parts,
    int? maxResults,
    String? onBehalfOfContentOwner,
    String? pageToken,
    String? regionCode,
    List<String>? id,
    String? hl,
    String? forUsername,
    bool? managedByMe,
    bool? mine,
  }) =>
      PlaylistOptions(
        parts: parts ?? this.parts,
        maxResults: maxResults ?? this.maxResults,
        onBehalfOfContentOwner:
            onBehalfOfContentOwner ?? this.onBehalfOfContentOwner,
        pageToken: pageToken ?? this.pageToken,
        regionCode: regionCode ?? this.regionCode,
        id: id ?? this.id,
        hl: hl ?? this.hl,
      );
}
