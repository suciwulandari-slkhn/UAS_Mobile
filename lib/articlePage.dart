// Import beberapa paket yang diperlukan
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:uas/data/data_artikel.dart';
import 'package:uas/detail/detail_artikel.dart';
import 'package:uas/widget/color.dart';
import 'package:uas/widget/dimensions.dart';

// Kelas StatefulWidget untuk menampilkan halaman artikel
class ArticlePageBody extends StatefulWidget {
  const ArticlePageBody({Key? key}) : super(key: key);

  @override
  _ArticlePageBodyState createState() => _ArticlePageBodyState();
}

// Kelas State untuk ArticlePageBody
class _ArticlePageBodyState extends State<ArticlePageBody> {
  // Controller untuk PageView
  PageController pageController = PageController(viewportFraction: 0.80);
  double _currPageValue = 0.0; // Nilai halaman saat ini
  double _scaleFactor = 0.8; // Faktor skala untuk efek zoom
  double _height =
      Dimensions.pageViewContainer * 1; // Tinggi kontainer PageView

  @override
  void initState() {
    super.initState();
    // Menambahkan listener untuk mengupdate _currPageValue saat halaman berubah
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    // Memastikan untuk membuang controller setelah widget dihapus
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Slider Artikel menggunakan PageView
        Container(
          height: 220,
          child: PageView.builder(
            controller: pageController,
            itemCount: artikel.length,
            itemBuilder: (context, position) {
              return _buildPageItem(position);
            },
          ),
        ),
        SizedBox(
          height: Dimensions.height10,
        ),
      ],
    );
  }

  // Method untuk membangun item halaman dalam PageView
  Widget _buildPageItem(int index) {
    // Matriks transformasi untuk efek zoom
    Matrix4 matrix = Matrix4.identity();

    // Logika transformasi berdasarkan indeks halaman saat ini (_currPageValue)
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
    }

    // Menggunakan GestureDetector untuk menangani ketika artikel di-tap
    return GestureDetector(
      onTap: () {
        // Navigasi ke halaman detail artikel menggunakan Navigator
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailArtikel(artikel: artikel[index]),
          ),
        );
      },
      child: Transform(
        transform: matrix,
        child: Stack(
          children: [
            // Kontainer gambar artikel dengan efek zoom
            Container(
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(artikel[index].image),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Widget untuk menampilkan kategori artikel
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(10, 13, 15, 10),
                      padding: EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: AppColors.mainColor.withOpacity(0.7),
                      ),
                      child: Container(
                        child: Text(
                          artikel[index].kategoriArtikel.name,
                          style: TextStyle(
                            fontSize: 7,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Widget untuk menampilkan judul artikel
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.grey.shade300.withOpacity(0.7),
                      ),
                      child: Text(
                        artikel[index].judulArtikel,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
