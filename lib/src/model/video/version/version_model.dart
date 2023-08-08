import 'package:vimeo_video_player_custom/vimeo_video_player_custom.dart';

class VersionModel {
  String? current;
  List<AvailableModel>? available;

  VersionModel({this.current, this.available});

  VersionModel.fromJson(Map<String, dynamic> json) {
    current = json['current'];
    if (json['available'] != null) {
      available = <AvailableModel>[];
      json['available'].forEach((v) { available!.add(new AvailableModel.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current'] = current;
    if (available != null) {
      data['available'] = available!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}