class ProgressiveModel {
  String? profile;
  int? width;
  int? height;
  String? mime;
  int? fps;
  String? url;
  String? cdn;
  String? quality;
  int? qualityInt;
  String? id;
  String? origin;

  ProgressiveModel({this.profile, this.width, this.height, this.mime, this.fps, this.url, this.cdn, this.quality, this.id, this.origin});

  ProgressiveModel.fromJson(Map<String, dynamic> json) {
    profile = json['profile'];
    width = json['width'];
    height = json['height'];
    mime = json['mime'];
    fps = json['fps'];
    url = json['url'];
    quality = json['quality'];

    int lastIndex = quality?.lastIndexOf("p") ?? 0;
    String qualitySubstring = quality?.substring(0, lastIndex) ?? '';
    qualityInt = int.tryParse(qualitySubstring);

    id = json['id'];
    origin = json['origin'];
  }
}
