import 'package:vimeo_video_player_custom/vimeo_video_player_custom.dart';

class PlayModel {
  List<ProgressiveModel>? progressive;

  PlayModel({this.progressive});

  PlayModel.fromJson(Map<String, dynamic> json) {
    if (json['progressive'] != null) {
      progressive = <ProgressiveModel>[];
      json['progressive'].forEach((v) {
        progressive!.add(ProgressiveModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (progressive != null) {
      data['progressive'] = progressive!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
