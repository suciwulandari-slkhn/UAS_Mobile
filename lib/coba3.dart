import 'package:flutter/material.dart';
import 'package:uas/allObat_list.dart';
import 'package:uas/list_obatperpenyakit.dart';
import 'package:uas/Api_obat/conn_obat.dart';
import 'package:uas/Api_obat/model_obat.dart';
import 'package:uas/obat/gridObat_berdsPenyakit.dart';
import 'package:uas/widget/color.dart';

// StatefulWidget untuk memilih 3 kategori
class Pilih3Kategori extends StatefulWidget {
  @override
  _Pilih3KategoriState createState() => _Pilih3KategoriState();
}

// Kelas State untuk Pilih3Kategori
class _Pilih3KategoriState extends State<Pilih3Kategori> {
  late Future<List<Obat>> futureObat;

  @override
  void initState() {
    super.initState();
    // Mengambil daftar obat (medikasi)
    futureObat = Repository.fetchObat();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Obat>>(
      future: futureObat,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Menampilkan spinner loading saat menunggu data
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          // Menampilkan pesan kesalahan jika pengambilan data gagal
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          // Jika data berhasil diambil
          List<Obat> daftarObat = snapshot.data!;
          List<String> kategoriTerpilih = [
            "Suplemen",
            "Flu dan Batuk",
            "Asma",
            "Lainnya",
          ];

          List<IconData> ikonKategori = [
            Icons.health_and_safety, // Ikon untuk "Suplemen"
            Icons.sick, // Ikon untuk "Flu dan Batuk"
            Icons.sick, // Ikon untuk "Asma"
            Icons.category, // Ikon untuk "Lainnya"
          ];

          return Container(
            height: 100,
            padding: EdgeInsets.only(top: 10, right: 35, left: 35),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: kategoriTerpilih.length,
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 1.2,
              ),
              itemCount: kategoriTerpilih.length,
              itemBuilder: (context, index) {
                // Mendapatkan nama kategori dan ikon yang sesuai dengan indeks
                String kategori = kategoriTerpilih[index];
                IconData ikon = ikonKategori[index];

                return Card(
                  elevation: 4, // Menambah elevasi untuk bayangan
                  color: AppColors.mainColor,
                  child: InkWell(
                    onTap: () {
                      if (index == kategoriTerpilih.length - 1) {
                        // Navigasi ke halaman daftar semua kategori obat
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => KategoriObatAll(),
                          ),
                        );
                      } else {
                        // Navigasi ke halaman DaftarObatKategori dengan kategori yang dipilih
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DaftarObatKategori(
                              daftarObat,
                              kategori,
                            ),
                          ),
                        );
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            ikon,
                            size: 35,
                            color: Colors.white,
                          ),
                          SizedBox(height: 5),
                          Text(
                            kategori,
                            style: TextStyle(fontSize: 10, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
