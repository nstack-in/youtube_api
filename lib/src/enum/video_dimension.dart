/// The `videoDimension` parameter lets you restrict a search to only retrieve 2D
/// or 3D videos. If you specify a value for this parameter, you must also set
/// the `type` parameter's value to `video`.
///
/// `string`
///
/// Acceptable values are:
///
/// *   `2d` – Restrict search results to exclude 3D videos.
/// *   `3d` – Restrict search results to only include 3D videos.
/// *   `any` – Include both 3D and non-3D videos in returned results. This is
///     the default value.
enum VideoDimension {
  twoD('2d'),
  threeD('3d'),
  any('any');

  const VideoDimension(this.value);

  final String value;
}
