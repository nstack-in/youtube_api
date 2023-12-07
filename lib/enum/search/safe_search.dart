/// The `safeSearch` parameter indicates whether the search results should
/// include restricted content as well as standard content.
///
/// `string`
///
/// Acceptable values are:
///
/// *   `moderate` – YouTube will filter some content from search results and,
///     at the least, will filter content that is restricted in your locale.
///     Based on their content, search results could be removed from search
///     results or demoted in search results. This is the default parameter
///     value.
/// *   `none` – YouTube will not filter the search result set.
/// *   `strict` – YouTube will try to exclude all restricted content from the
///     search result set. Based on their content, search results could be
///     removed from search results or demoted in search results.
enum SafeSearch { moderate, none, strict }
