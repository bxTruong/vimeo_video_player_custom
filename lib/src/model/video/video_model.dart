import 'package:vimeo_video_player_custom/vimeo_video_player_custom.dart';

class VideoModel {
  int? id;
  String? title;
  int? width;
  int? height;
  int? duration;
  String? url;
  String? shareUrl;
  String? embedCode;
  int? hd;
  int? allowHd;
  int? defaultToHd;
  String? privacy;
  String? embedPermission;
  ThumbsModel? thumbs;
  String? lang;
  OwnerModel? owner;
  int? spatial;
  String? liveEvent;
  VersionModel? version;
  String? unlistedHash;
  RatingModel? rating;
  int? fps;
  String? channelLayout;

  VideoModel(
      {this.id,
      this.title,
      this.width,
      this.height,
      this.duration,
      this.url,
      this.shareUrl,
      this.embedCode,
      this.hd,
      this.allowHd,
      this.defaultToHd,
      this.privacy,
      this.embedPermission,
      this.thumbs,
      this.lang,
      this.owner,
      this.spatial,
      this.liveEvent,
      this.version,
      this.unlistedHash,
      this.rating,
      this.fps,
      this.channelLayout});

  VideoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    width = json['width'];
    height = json['height'];
    duration = json['duration'];
    url = json['url'];
    shareUrl = json['share_url'];
    embedCode = json['embed_code'];
    hd = json['hd'];
    allowHd = json['allow_hd'];
    defaultToHd = json['default_to_hd'];
    privacy = json['privacy'];
    embedPermission = json['embed_permission'];
    thumbs = json['thumbs'] != null ? ThumbsModel.fromJson(json['thumbs']) : null;
    lang = json['lang'];
    owner = json['owner'] != null ? OwnerModel.fromJson(json['owner']) : null;
    spatial = json['spatial'];
    liveEvent = json['live_event'];
    version = json['version'] != null ? VersionModel.fromJson(json['version']) : null;
    unlistedHash = json['unlisted_hash'];
    rating = json['rating'] != null ? RatingModel.fromJson(json['rating']) : null;
    fps = json['fps'];
    channelLayout = json['channel_layout'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['width'] = width;
    data['height'] = height;
    data['duration'] = duration;
    data['url'] = url;
    data['share_url'] = shareUrl;
    data['embed_code'] = embedCode;
    data['hd'] = hd;
    data['allow_hd'] = allowHd;
    data['default_to_hd'] = defaultToHd;
    data['privacy'] = privacy;
    data['embed_permission'] = embedPermission;
    if (thumbs != null) {
      data['thumbs'] = thumbs!.toJson();
    }
    data['lang'] = lang;
    if (owner != null) {
      data['owner'] = owner!.toJson();
    }
    data['spatial'] = spatial;
    data['live_event'] = liveEvent;
    if (version != null) {
      data['version'] = version!.toJson();
    }
    data['unlisted_hash'] = unlistedHash;
    if (rating != null) {
      data['rating'] = rating!.toJson();
    }
    data['fps'] = fps;
    data['channel_layout'] = channelLayout;
    return data;
  }
}
