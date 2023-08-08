class ThumbsModel {
  String? s640;
  String? s960;
  String? base;

  ThumbsModel({this.s640, this.s960, this.base});

  ThumbsModel.fromJson(Map<String, dynamic> json) {
    s640 = json['640'];
    s960 = json['960'];
    base = json['base'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['640'] = s640;
    data['960'] = s960;
    data['base'] = base;
    return data;
  }
}
