/// The `videoLicense` parameter filters search results to only include videos
/// with a particular license. YouTube lets video uploaders choose to attach
/// either the Creative Commons license or the standard YouTube license to each
/// of their videos. If you specify a value for this parameter, you must also
/// set the `type` parameter's value to `video`.
///
/// `string`
///
/// Acceptable values are:
///
/// *   `any` – Return all videos, regardless of which license they have, that
///     match the query parameters.
/// *   `creativeCommon` – Only return videos that have a Creative Commons
///     license. Users can reuse videos with this license in other videos that
///     they create. [Learn
///     more](http://www.google.com/support/youtube/bin/answer.py?answer=1284989).
/// *   `youtube` – Only return videos that have the standard YouTube license.
enum VideoLicense { any, creativeCommon, youtube }
