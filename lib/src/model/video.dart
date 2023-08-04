class VideoDetails {
  String? duration;
  String? id;

  VideoDetails(dynamic data) {
    id = data['id'];
    duration = data['contentDetails']['duration'];
  }
}
