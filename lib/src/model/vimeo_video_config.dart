class VimeoVideoConfig {
  VimeoVideoConfig({this.request});

  factory VimeoVideoConfig.fromJson(Map<String, dynamic> json) => VimeoVideoConfig(request: VimeoRequest.fromJson(json["request"]));

  VimeoRequest? request;
}

class VimeoRequest {
  VimeoRequest({this.files});

  factory VimeoRequest.fromJson(Map<String, dynamic> json) => VimeoRequest(files: VimeoFiles.fromJson(json["files"]));

  VimeoFiles? files;
}

class VimeoFiles {
  VimeoFiles({this.progressive});

  factory VimeoFiles.fromJson(Map<String, dynamic> json) => VimeoFiles(
        progressive: List<VimeoProgressive>.from(
          json["progressive"].map(
            (x) => VimeoProgressive.fromJson(x),
          ),
        ),
      );

  List<VimeoProgressive?>? progressive;
}

class VimeoProgressive {
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

  VimeoProgressive({this.profile, this.width, this.height, this.mime, this.fps, this.url, this.cdn, this.quality, this.id, this.origin});

  VimeoProgressive.fromJson(Map<String, dynamic> json) {
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
