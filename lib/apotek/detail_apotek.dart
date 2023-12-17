import 'package:flutter/material.dart';
import 'package:uas/Api_apotek/model_apt.dart';
import 'package:uas/widget/app_column.dart';
import 'package:uas/widget/app_icon.dart';
import 'package:uas/widget/big_text.dart';
import 'package:uas/widget/color.dart';
import 'package:uas/widget/dimensions.dart';
import 'package:uas/widget/exandable_text_widget.dart';

class DetailApotek extends StatelessWidget {
  final Apotek apotek;

  DetailApotek({required this.apotek});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background Image
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      apotek.imgApt ?? ""), // Menggunakan gambar dari Apotek
                ),
              ),
            ),
          ),
          // Icons
          Positioned(
            top: Dimensions.height45,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: AppIcon(icon: Icons.arrow_back_ios),
                ),
              ],
            ),
          ),
          // Apotek Information
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            top: 250,
            child: Container(
              padding: EdgeInsets.only(
                left: Dimensions.width10,
                right: Dimensions.width10,
                top: Dimensions.height20,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(Dimensions.radius20),
                  topLeft: Radius.circular(Dimensions.radius20),
                ),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  AppColumn(
                      text: apotek.namaApotek ??
                          ""), // Menggunakan nama dari Apotek
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: ExpandableTextWidget(
                        text: apotek.ket ??
                            "", // Menggunakan keterangan dari Apotek
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 70,
        padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
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
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: Colors.grey.shade300,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.access_time_filled_rounded,
                    color: Colors.green,
                  ),
                  SizedBox(width: 5),
                  BigText(
                    text: apotek.jamOp ?? "",
                    size: 15,
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
