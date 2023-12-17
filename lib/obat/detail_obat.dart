import 'package:flutter/material.dart';
import 'package:uas/Api_obat/model_obat.dart';
import 'package:uas/widget/big_text.dart';
import 'package:uas/widget/color.dart';
import 'package:uas/widget/dimensions.dart';
import 'package:uas/widget/exandable_text_widget.dart';

class CobaDetail extends StatelessWidget {
  final Obat obat;

  CobaDetail({required this.obat});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // SliverAppBar untuk header dengan gambar obat
          SliverAppBar(
            toolbarHeight: 50,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(10),
              child: Container(
                child: Center(
                  child: BigText(
                    size: Dimensions.font26,
                    text: obat.name ?? "", // Judul obat
                    color: Colors.black,
                  ),
                ),
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 5, bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
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
              background: Image.network(
                obat.image ?? "", // Gambar obat
                fit: BoxFit.cover,
              ),
            ),
          ),
          // SliverToBoxAdapter untuk bagian informasi obat
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.width20,
                vertical: Dimensions.height10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Deskripsi obat
                  ExpandableTextWidget(
                    text: "Deskripsi : \n" + (obat.description ?? ""),
                  ),
                  SizedBox(height: Dimensions.height10),
                  // Indikasi obat
                  Text("Indikasi : \n" + (obat.indication ?? "")),
                  SizedBox(height: Dimensions.height10),
                  // Kontraindikasi obat
                  Text("Kontraindikasi : \n" + (obat.contraindications ?? "")),
                  SizedBox(height: Dimensions.height10),
                  // Dosis obat
                  Text("Dosis : \n" + (obat.dose ?? "")),
                  SizedBox(height: Dimensions.height10),
                  // Efek Samping obat
                  Text("Efek Samping : \n" + (obat.sideEffect ?? "")),
                ],
              ),
            ),
          ),
        ],
      ),
      // Container untuk bottom navigation bar
      bottomNavigationBar: Container(
        height: 65,
        padding: EdgeInsets.only(
          top: 5,
          bottom: 5,
        ),
        decoration: BoxDecoration(
          color: AppColors.mainColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimensions.radius20 * 2),
            topRight: Radius.circular(Dimensions.radius20 * 2),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Container untuk harga obat
            Container(
              padding: EdgeInsets.all(15),
              child: BigText(
                text: "Rp ${obat.price ?? ""}", // Harga obat
                size: Dimensions.font20,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: Colors.grey.shade300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
