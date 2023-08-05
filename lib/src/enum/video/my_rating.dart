/// This parameter can only be used in a properly authorized request. Set this
/// parameter's value to `like` or `dislike` to instruct the API to only return
/// videos liked or disliked by the authenticated user.
///
/// `string`
///
/// Acceptable values are:
///
/// *   `dislike` – Returns only videos disliked by the authenticated user.
/// *   `like` – Returns only video liked by the authenticated user.
enum MyRating { dislike, like }
