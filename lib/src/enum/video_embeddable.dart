/// The `videoEmbeddable` parameter lets you to restrict a search to only videos
/// that can be embedded into a webpage. If you specify a value for this
/// parameter, you must also set the `type` parameter's value to
/// `video`.
///
/// `string`
///
/// Acceptable values are:
///
/// *   `any` – Return all videos, embeddable or not.
/// *   `true` – Only retrieve embeddable videos.
enum VideoEmbeddable { any, true_ }
