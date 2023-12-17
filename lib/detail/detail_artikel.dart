import 'package:flutter/material.dart';
import 'package:uas/data/data_artikel.dart';
import 'package:uas/widget/big_text.dart';
import 'package:uas/widget/color.dart';
import 'package:uas/widget/dimensions.dart';
import 'package:uas/widget/exandable_text_widget.dart';

class DetailArtikel extends StatelessWidget {
  final ArtikelDetail artikel; // Terima data artikel

  DetailArtikel({required this.artikel}); // Konstruktor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // SliverAppBar untuk menampilkan judul artikel dan gambar header
          SliverAppBar(
            toolbarHeight: 50,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(10),
              child: Container(
                child: Center(
                  child: BigText(
                    color: Colors.white,
                    size: Dimensions.font26,
                    text: artikel
                        .judulArtikel, // Gunakan judul artikel sebagai judul
                  ),
                ),
                width: double.maxFinite,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20),
                    topRight: Radius.circular(Dimensions.radius20),
                  ),
                ),
              ),
            ),
            pinned: true,
            backgroundColor: Colors.white,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                artikel
                    .image, // Gunakan gambar artikel atau kategori gambar yang sesuai
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          // SliverToBoxAdapter untuk menampilkan isi artikel yang dapat di-expand
          SliverToBoxAdapter(
            child: Column(
              children: [
                // Container untuk mengatur margin pada isi artikel
                Container(
                  padding: EdgeInsets.all(8),
                  child: ExpandableTextWidget(
                    text: artikel.isiArtikel, // Gunakan isi artikel
                  ),
                  margin: EdgeInsets.only(
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
