class Obat {
  String? id;
  String? name;
  String? description;
  String? indication;
  String? contraindications;
  String? dose;
  String? sideEffect;
  String? price;
  String? image;
  String? category;

  Obat(
      {this.id,
      this.name,
      this.description,
      this.indication,
      this.contraindications,
      this.dose,
      this.sideEffect,
      this.price,
      this.image,
      this.category});

  Obat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    indication = json['indication'];
    contraindications = json['contraindications'];
    dose = json['dose'];
    sideEffect = json['side_effect'];
    price = json['price'];
    image = json['image'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['indication'] = this.indication;
    data['contraindications'] = this.contraindications;
    data['dose'] = this.dose;
    data['side_effect'] = this.sideEffect;
    data['price'] = this.price;
    data['image'] = this.image;
    data['category'] = this.category;
    return data;
  }
}
