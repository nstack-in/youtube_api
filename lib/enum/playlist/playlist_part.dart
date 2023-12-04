/// The `part` parameter specifies a comma-separated list of one or more
/// `playlist` resource properties that the API response will include.
///
/// `string`
///
/// If the parameter identifies a property that contains child properties, the
/// child properties will be included in the response. For example, in a
/// `playlist` resource, the `snippet` property contains properties like
/// `author`, `title`, `description`, and `timeCreated`. As such, if you set
/// `part=snippet`, the API response will contain all of those properties.
///
/// The following list contains the `part` names that you can include in the
/// parameter value:
///
/// *   `contentDetails`
/// *   `id`
/// *   `localizations`
/// *   `player`
/// *   `snippet`
/// *   `status`
enum PlaylistPart {
  contentDetails,
  id,
  localizations,
  player,
  snippet,
  status;

  static const implementedParts = {snippet};
}
