class CityModel {
  List<KotaKabupaten>? kotaKabupaten;

  CityModel({this.kotaKabupaten});

  CityModel.fromJson(Map<String, dynamic> json) {
    if (json['kota_kabupaten'] != null) {
      kotaKabupaten = <KotaKabupaten>[];
      json['kota_kabupaten'].forEach((v) {
        kotaKabupaten!.add(KotaKabupaten.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (kotaKabupaten != null) {
      data['kota_kabupaten'] =
          kotaKabupaten!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class KotaKabupaten {
  int? id;
  String? idProvinsi;
  String? nama;

  KotaKabupaten({this.id, this.idProvinsi, this.nama});

  KotaKabupaten.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idProvinsi = json['id_provinsi'];
    nama = json['nama'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['id_provinsi'] = idProvinsi;
    data['nama'] = nama;
    return data;
  }
}
