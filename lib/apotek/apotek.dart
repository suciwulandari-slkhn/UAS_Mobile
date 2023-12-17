import 'package:flutter/material.dart';
import 'package:uas/Api_apotek/conn_apiApotek.dart';
import 'package:uas/Api_apotek/model_apt.dart';
import 'package:uas/apotek/detail_apotek.dart';
import 'package:uas/widget/big_text.dart';
import 'package:uas/widget/color.dart';
import 'package:uas/widget/dimensions.dart';
import 'package:uas/widget/icon_and_text_widget.dart';
import 'package:uas/widget/small_text.dart';

class ApotekList extends StatefulWidget {
  @override
  _ApotekListState createState() => _ApotekListState();
}

class _ApotekListState extends State<ApotekList> {
  late Future<List<Apotek>> apoteksFuture;

  @override
  void initState() {
    super.initState();
    // Menginisialisasi future untuk mendapatkan daftar apotek
    apoteksFuture = RepositoryApt.fetchApotek();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: FutureBuilder<List<Apotek>>(
          future: apoteksFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Menampilkan indikator loading saat data masih diambil
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              // Menampilkan pesan kesalahan jika terjadi error
              return Text('Error: ${snapshot.error}');
            } else {
              // Jika data telah berhasil diambil
              List<Apotek> apoteks = snapshot.data!;

              return Column(
                children: [
                  // Menampilkan daftar apotek dalam ListView
                  ListView.builder(
                    padding: EdgeInsets.only(top: 15),
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: apoteks.length,
                    itemBuilder: (context, index) {
                      // Mengambil data apotek pada indeks tertentu
                      Apotek apotek = apoteks[index];

                      return GestureDetector(
                        onTap: () {
                          // Navigasi ke halaman detail apotek ketika di-tap
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DetailApotek(apotek: apotek),
                          ));
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                            left: Dimensions.width30,
                            right: Dimensions.width30,
                            bottom: Dimensions.height10,
                          ),
                          child: Row(
                            children: [
                              // Bagian kiri: Gambar apotek
                              Container(
                                width: Dimensions.ListViewImgSize,
                                height: Dimensions.ListViewImgSize,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius15),
                                  color: Colors.white38,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius15),
                                  child: Image.network(
                                    apotek.imgApt ?? " ",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              // Bagian kanan: Informasi apotek
                              Expanded(
                                child: Container(
                                  height: Dimensions.ListViewTextContSize,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topRight:
                                          Radius.circular(Dimensions.radius20),
                                      bottomRight:
                                          Radius.circular(Dimensions.radius20),
                                    ),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        spreadRadius: 1,
                                        blurRadius: 3,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: Dimensions.width10,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        // Nama Apotek
                                        BigText(text: apotek.namaApotek ?? ""),
                                        SizedBox(
                                          height: Dimensions.height10,
                                        ),
                                        // Informasi Jam Operasional
                                        Row(
                                          children: [
                                            IconAndTextWidget(
                                              icon: Icons
                                                  .access_time_filled_rounded,
                                              text: apotek.jamOp ?? "",
                                              iconColor: Colors.green,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
