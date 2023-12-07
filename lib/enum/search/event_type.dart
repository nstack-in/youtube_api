/// The `eventType` parameter restricts a search to broadcast events. If
/// you specify a value for this parameter, you must also set the
/// `type` parameter's value to `video`.
///
/// `string`
///
/// Acceptable values are:
///
/// *   `completed` – Only include completed broadcasts.
/// *   `live` – Only include active broadcasts.
/// *   `upcoming` – Only include upcoming broadcasts.
enum EventType { completed, live, upcoming }
