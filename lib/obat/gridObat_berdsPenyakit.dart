import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:uas/allObat_list.dart';
import 'package:uas/home.dart';
import 'package:uas/list_obatperpenyakit.dart';
import 'package:uas/Api_obat/conn_obat.dart';
import 'package:uas/Api_obat/model_obat.dart';
import 'package:uas/profile.dart';
import 'package:uas/widget/color.dart';

// Kode ini mendefinisikan kelas stateful widget untuk halaman kategori obat.
class KategoriObatAll extends StatefulWidget {
  @override
  _KategoriObatAllState createState() => _KategoriObatAllState();
}

class _KategoriObatAllState extends State<KategoriObatAll> {
  late Future<List<Obat>>
      futureObat; // Deklarasi variabel futureObat untuk menampung hasil pemanggilan Repository.fetchObat().
  int _selectedIndex = 2; // Indeks terpilih pada bottom navigation bar.

  @override
  void initState() {
    super.initState();
    futureObat = Repository
        .fetchObat(); // Memanggil metode fetchObat() dari kelas Repository untuk mendapatkan daftar obat.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text('Kategori Penyakit'),
            automaticallyImplyLeading: false,
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: FutureBuilder<List<Obat>>(
          future: futureObat,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              // Proses ketika data sudah tersedia.
              // menggunakan snapshot.data u/ mendapatan data dr futurebuilder
              List<Obat> obatList =
                  snapshot.data!; //data yg didapat tidak boleh null
              //mnggnkan 'map' u/ mengakses 'category' pd stiap objek 'Obat' dlm 'obatlist'
              Set<String> categories =
                  obatList.map((obat) => obat.category!).toSet();
              // mengkonversi menjadi dftar List dgn properti toList, agar dapat diakses dgn index
              List<String> allCategories = categories.toList();

              return Container(
                padding: EdgeInsets.all(15),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 2,
                  ),
                  itemCount: allCategories.length,
                  itemBuilder: (context, index) {
                    // mengambil index pd list "allCategories"
                    String category = allCategories[index];
                    // Membuat card yang dapat diklik untuk setiap kategori.
                    return Card(
                      elevation: 5,
                      child: InkWell(
                        onTap: () {
                          // Navigasi ke halaman DaftarObatKategori dengan kategori yang dipilih
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DaftarObatKategori(
                                obatList,
                                category,
                              ),
                            ),
                          );
                        },
                        child: Center(
                          child: Text(
                            category,
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
      // BottomNavigationBar menampilkan tab navigasi bawah untuk berpindah halaman.
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        child: Container(
          color: AppColors.mainColor,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: GNav(
              color: Colors.white,
              activeColor: AppColors.mainColor,
              tabBackgroundColor: const Color.fromARGB(255, 243, 241, 241),
              gap: 5,
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                handleTabChange(index);
              },
              padding: EdgeInsets.all(10),
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.local_hospital_rounded,
                  text: 'Obat',
                ),
                GButton(
                  icon: Icons.sick_rounded,
                  text: 'Penyakit',
                ),
                GButton(
                  icon: Icons.person,
                  text: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Metode untuk menangani perubahan tab di BottomNavigationBar.
  void handleTabChange(int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ObatListAll(),
          ),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => KategoriObatAll(),
          ),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => profile(),
          ),
        );
        break;
      default:
    }
  }
}
