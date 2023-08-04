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
enum VideoType { any, episode, movie }
