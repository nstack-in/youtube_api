/// The `videoDefinition` parameter lets you restrict a search to only
/// include either high definition (HD) or standard definition (SD) videos. HD
/// videos are available for playback in at least 720p, though higher
/// resolutions, like 1080p, might also be available. If you specify a value for
/// this parameter, you must also set the `type` parameter's value to
/// `video`.
///
/// `string`
///
/// Acceptable values are:
///
/// *   `any` – Return all videos, regardless of their resolution.
/// *   `high` – Only retrieve HD videos.
/// *   `standard` – Only retrieve videos in standard definition.
enum VideoDefinition {
  any,
  high,
  standard;

  static VideoDefinition? fromString(String string) => switch (string) {
        "hd" => high,
        "sd" => standard,
        _ => null,
      };
}
