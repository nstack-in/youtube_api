import 'package:youtube_api/src/enum/channel/channel_part.dart';
import 'package:youtube_api/src/model/options.dart';

class ChannelOptions extends SpecificKindOptions {
  ChannelOptions({
    this.parts = const {ChannelPart.snippet},
    this.forUsername,
    this.managedByMe,
    this.mine,
    super.id,
    super.maxResults,
    super.onBehalfOfContentOwner,
    super.pageToken,
    super.regionCode,
    super.hl,
  });
  final Set<ChannelPart> parts;

  /// The `forUsername` parameter specifies a YouTube username, thereby
  /// requesting the channel associated with that username.
  ///
  /// `string`
  final String? forUsername;

  /// This parameter can only be used in a properly authorized request.
  /// **Note:** This parameter is intended exclusively for YouTube content
  /// partners.
  ///
  /// `boolean`
  ///
  /// Set this parameter's value to `true` to instruct the API to only return
  /// channels managed by the content owner that the `onBehalfOfContentOwner`
  /// parameter specifies. The user must be authenticated as a CMS account
  /// linked to the specified content owner and `onBehalfOfContentOwner` must be
  /// provided.
  final bool? managedByMe;

  /// This parameter can only be used in a properly authorized request. Set this
  /// parameter's value to `true` to instruct the API to only return channels
  /// owned by the authenticated user.
  ///
  /// `boolean`
  final bool? mine;

  @override
  Map<String, String> getMap(String key) => {
        ...super.getMap(key),
        QueryParameter.part.name: parts.map((part) => part.name).join(','),
        if (forUsername != null) QueryParameter.forUsername.name: forUsername!,
        if (managedByMe != null)
          QueryParameter.managedByMe.name: "$managedByMe",
        if (mine != null) QueryParameter.mine.name: "$mine",
      };

  ChannelOptions copyWith({
    Set<ChannelPart>? parts,
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
      ChannelOptions(
        parts: parts ?? this.parts,
        maxResults: maxResults ?? this.maxResults,
        onBehalfOfContentOwner:
            onBehalfOfContentOwner ?? this.onBehalfOfContentOwner,
        pageToken: pageToken ?? this.pageToken,
        regionCode: regionCode ?? this.regionCode,
        id: id ?? this.id,
        hl: hl ?? this.hl,
        forUsername: forUsername ?? this.forUsername,
        managedByMe: managedByMe ?? this.managedByMe,
        mine: mine ?? this.mine,
      );
}
