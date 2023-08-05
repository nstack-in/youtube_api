/// The `videoCaption` parameter indicates whether the API should filter
/// video search results based on whether they have captions. If you specify a
/// value for this parameter, you must also set the `[type](#type)` parameter's
/// value to `video`.
///
/// `string`
///
/// Acceptable values are:
///
/// *   `any` – Do not filter results based on caption availability.
/// *   `closedCaption` – Only include videos that have captions.
/// *   `none` – Only include videos that do not have captions.
enum VideoCaption {
  any,
  closedCaption,
  none;

  static VideoCaption? fromString(String string) => switch (string) {
        "false" => none,
        "true" => closedCaption,
        _ => null,
      };
}
