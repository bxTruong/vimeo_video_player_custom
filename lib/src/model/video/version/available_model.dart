class AvailableModel {
  int? id;
  int? fileId;
  bool? isCurrent;

  AvailableModel({this.id, this.fileId, this.isCurrent});

  AvailableModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fileId = json['file_id'];
    isCurrent = json['is_current'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['file_id'] = fileId;
    data['is_current'] = isCurrent;
    return data;
  }

}