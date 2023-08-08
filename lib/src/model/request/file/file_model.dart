import 'package:vimeo_video_player_custom/vimeo_video_player_custom.dart';

class FileModel {
  FileModel({this.progressive});

  factory FileModel.fromJson(Map<String, dynamic> json) => FileModel(
        progressive: List<ProgressiveModel>.from(
          json["progressive"].map(
            (x) => ProgressiveModel.fromJson(x),
          ),
        ),
      );

  List<ProgressiveModel?>? progressive;
}
