/// The `part` parameter specifies a comma-separated list of one or more
/// `video` resource properties that the API response will include.
///
/// `string`
///
/// If the parameter identifies a property that contains child properties, the
/// child properties will be included in the response. For example, in a `video`
/// resource, the `snippet` property contains the `channelId`, `title`,
/// `description`, `tags`, and `categoryId` properties. As such, if you set
/// `part=snippet`, the API response will contain all of those properties.
///
/// The following list contains the `part` names that you can include in the
/// parameter value:
///
/// *   `contentDetails`
/// *   `fileDetails`
/// *   `id`
/// *   `liveStreamingDetails`
/// *   `localizations`
/// *   `player`
/// *   `processingDetails`
/// *   `recordingDetails`
/// *   `snippet`
/// *   `statistics`
/// *   `status`
/// *   `suggestions`
/// *   `topicDetails`
enum DataPart {
  contentDetails,
  fileDetails,
  id,
  liveStreamingDetails,
  localizations,
  player,
  processingDetails,
  recordingDetails,
  snippet,
  statistics,
  status,
  suggestions,
  topicDetails,
}
