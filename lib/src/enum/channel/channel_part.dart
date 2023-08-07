/// The `part` parameter specifies a comma-separated list of one or more
/// `channel` resource properties that the API response will include.
///
/// `string`
///
/// If the parameter identifies a property that contains child properties, the
/// child properties will be included in the response. For example, in a
/// `channel` resource, the `contentDetails` property contains other properties,
/// such as the `uploads` properties. As such, if you set `part=contentDetails`,
/// the API response will also contain all of those nested properties.
///
/// The following list contains the `part` names that you can include in the
/// parameter value:
///
/// *   `auditDetails`
/// *   `brandingSettings`
/// *   `contentDetails`
/// *   `contentOwnerDetails`
/// *   `id`
/// *   `localizations`
/// *   `snippet`
/// *   `statistics`
/// *   `status`
/// *   `topicDetails`
enum ChannelPart {
  auditDetails,
  brandingSettings,
  contentDetails,
  contentOwnerDetails,
  id,
  localizations,
  snippet,
  statistics,
  status,
  topicDetails;

  static const implementedParts = {snippet, brandingSettings};
}
