class ProvModel {
  List<Provinsi>? provinsi;

  ProvModel({this.provinsi});

  ProvModel.fromJson(Map<String, dynamic> json) {
    if (json['provinsi'] != null) {
      provinsi = <Provinsi>[];
      json['provinsi'].forEach((v) {
        provinsi!.add(Provinsi.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (provinsi != null) {
      data['provinsi'] = provinsi!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Provinsi {
  int? id;
  String? nama;

  Provinsi({this.id, this.nama});

  Provinsi.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nama'] = nama;
    return data;
  }
}