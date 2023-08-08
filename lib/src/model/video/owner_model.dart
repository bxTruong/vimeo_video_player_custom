class OwnerModel {
  int? id;
  String? name;
  String? img;
  String? img2x;
  String? url;
  String? accountType;

  OwnerModel({this.id, this.name, this.img, this.img2x, this.url, this.accountType});

  OwnerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    img = json['img'];
    img2x = json['img_2x'];
    url = json['url'];
    accountType = json['account_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['img'] = img;
    data['img_2x'] = img2x;
    data['url'] = url;
    data['account_type'] = accountType;
    return data;
  }
}
