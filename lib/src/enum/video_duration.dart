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
enum VideoDuration { any, long, medium, short }
