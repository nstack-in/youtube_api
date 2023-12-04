/// The `order` parameter specifies the method that will be used to order
/// resources in the API response. The default value is `relevance`.
///
/// `string`
///
/// Acceptable values are:
///
/// *   `date` – Resources are sorted in reverse chronological order based
///     on the date they were created.
/// *   `rating` – Resources are sorted from highest to lowest rating.
/// *   `relevance` – Resources are sorted based on their relevance to the
///     search query. This is the default value for this parameter.
/// *   `title` – Resources are sorted alphabetically by title.
/// *   `videoCount` – Channels are sorted in descending order of their
///     number of uploaded videos.
/// *   `viewCount` – Resources are sorted from highest to lowest number of
///     views. For live broadcasts, videos are sorted by number of concurrent
///     viewers while the broadcasts are ongoing.
enum Order { date, rating, relevance, title, videoCount, viewCount }
