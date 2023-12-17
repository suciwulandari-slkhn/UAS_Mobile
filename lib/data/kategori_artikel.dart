class CategoryArtikel {
  final String name;
  final String image;

  CategoryArtikel(this.name, this.image);

  static List<CategoryArtikel> all() {
    return [
      CategoryArtikel("Kesehatan Umum", "assets/image/health.jpg"),
      CategoryArtikel("Gaya Hidup", "assets/image/lifestyle.jpg"),
      CategoryArtikel("Nutrisi", "assets/image/nutrition.jpg"),
      CategoryArtikel("Kesehatan Mental", "assets/image/mental_health.jpg"),
      CategoryArtikel("Olahraga", "assets/image/sports.jpg"),
      CategoryArtikel("Parenting", "assets/image/parenting.jpg"),
    ];
  }
}
