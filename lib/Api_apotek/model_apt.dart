class Apotek {
  String? namaApotek;
  String? ket;
  String? alamat;
  String? jamOp;
  String? imgApt;
  String? idApotek;

  Apotek(
      {this.namaApotek,
      this.ket,
      this.alamat,
      this.jamOp,
      this.imgApt,
      this.idApotek});

  Apotek.fromJson(Map<String, dynamic> json) {
    namaApotek = json['namaApotek'];
    ket = json['ket'];
    alamat = json['alamat'];
    jamOp = json['jamOp'];
    imgApt = json['imgApt'];
    idApotek = json['idApotek'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['namaApotek'] = this.namaApotek;
    data['ket'] = this.ket;
    data['alamat'] = this.alamat;
    data['jamOp'] = this.jamOp;
    data['imgApt'] = this.imgApt;
    data['idApotek'] = this.idApotek;
    return data;
  }
}
