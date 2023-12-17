import 'package:flutter/material.dart';
import 'package:uas/obat/detail_obat.dart';
import 'package:uas/Api_obat/model_obat.dart';
import 'package:uas/widget/color.dart';

class DaftarObatKategori extends StatelessWidget {
  final List<Obat> obatList; // Daftar semua obat
  final String selectedCategory; // Kategori yang dipilih

  DaftarObatKategori(this.obatList, this.selectedCategory);

  @override
  Widget build(BuildContext context) {
    // Filter obat berdasarkan kategori yang dipilih
    List<Obat> selectedObatList =
        obatList.where((obat) => obat.category == selectedCategory).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Obat Kategori $selectedCategory'),
      ),
      body: Container(
        color: AppColors.mainColor,
        child: ListView.builder(
          itemCount: selectedObatList.length,
          itemBuilder: (context, index) {
            // Mendapatkan objek Obat pada indeks tertentu
            Obat obat = selectedObatList[index];
            // Membuat tampilan ListTile untuk setiap item dalam ListView
            return Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: ListTile(
                contentPadding: EdgeInsets.all(8),
                leading: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(obat.image ?? ""),
                    ),
                  ),
                ),
                title: Text(obat.name ?? ""),
                onTap: () {
                  // Navigasi ke halaman detail obat saat item di-tap
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CobaDetail(obat: obat),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
