import 'package:vimeo_video_player_custom/vimeo_video_player_custom.dart';

class RequestModel {
  RequestModel({this.files});

  factory RequestModel.fromJson(Map<String, dynamic> json) => RequestModel(files: FileModel.fromJson(json["files"]));

  FileModel? files;
}