import 'package:vimeo_video_player_custom/vimeo_video_player_custom.dart';

class VimeoVideoConfig {
  VimeoVideoConfig({this.request});

  VimeoVideoConfig.fromJson(Map<String, dynamic> json){
    if(json["request"]!=null) {
      request = RequestModel.fromJson(json["request"]);
    }
    if(json["video"]!=null) {
      request = RequestModel.fromJson(json["request"]);
    }

  }

  RequestModel? request;
  VideoModel? video;

}
