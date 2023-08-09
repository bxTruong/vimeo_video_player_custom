import 'package:vimeo_video_player_custom/vimeo_video_player_custom.dart';

class VimeoModel {
  PlayModel? play;

  VimeoModel({this.play});

  VimeoModel.fromJson(Map<String, dynamic> json) {
    play = json['play'] != null ? PlayModel.fromJson(json['play']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (play != null) {
      data['play'] = play!.toJson();
    }
    return data;
  }
}
