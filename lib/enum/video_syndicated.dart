/// The `videoSyndicated` parameter lets you to restrict a search to only videos
/// that can be played outside youtube.com. If you specify a value for this
/// parameter, you must also set the `type` parameter's value to
/// `video`.
///
/// `string`
///
/// Acceptable values are:
///
/// *   `any` – Return all videos, syndicated or not.
/// *   `true` – Only retrieve syndicated videos.
enum VideoSyndicated { any, true_ }
