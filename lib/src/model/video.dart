
class Video {
  String? duration;
  String? id;

  Video(dynamic data) {
    id = data['id'];
    duration = data['contentDetails']['duration'];
  }
}
