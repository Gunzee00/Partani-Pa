import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:partani_mobile/user_login/login_admin.dart';
import 'package:partani_mobile/pages/product_detail.dart'; // Import ProductDetailPage

class PembeliPage extends StatefulWidget {
  @override
  _PembeliPageState createState() => _PembeliPageState();
}

class _PembeliPageState extends State<PembeliPage> {
  List<dynamic> products = [];
  TextEditingController searchController =
      TextEditingController(); // Define TextEditingController

  // Future<void> fetchData() async {
  //   final response =
  //       await http.get(Uri.parse('http://192.168.158.141:3001/api/readdataproduk'));

  //   if (response.statusCode == 200) {
  //     setState(() {
  //       products = json.decode(response.body);
  //     });
  //   } else {
  //     throw Exception('Failed to load data');
  //   }
  // }

  Future<void> logout() async {
    // Hapus informasi login dari SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('role');

    // Arahkan pengguna kembali ke halaman login
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  Widget menuItem({required String label, required Color color}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            padding: EdgeInsets.fromLTRB(36, 20, 36, 36), // Adjusted padding
            margin: EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Partani',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.logout),
                      color: Colors.white,
                      onPressed: () {
                        logout(); // Panggil fungsi logout saat tombol logout ditekan
                      },
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.all(Radius.circular(32)),
                  ),
                  height: 40,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: TextFormField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: Icon(Icons.search),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: 26),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    menuItem(label: 'All', color: Colors.purple),
                    menuItem(label: 'Sayur', color: Colors.grey),
                    menuItem(label: 'Buah', color: Colors.grey),
                    menuItem(label: 'Rempah-Rempah', color: Colors.grey),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 2.2),
              ),
              itemCount: products.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 6.0, vertical: 2.0), // Adjusted padding
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProductDetailPage(product: products[index]),
                        ),
                      );
                    },
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Center(
                                  child: Image.asset(
                                    'assets/images/image.jpeg', // Ganti dengan path gambar Anda
                                    fit: BoxFit
                                        .cover, // Sesuaikan fit sesuai kebutuhan Anda
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15), // Tambahkan padding ke kiri
                                child: Text(
                                  products[index]['nama_produk'] ?? '',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  '\Rp.${products[index]['harga_produk'] ?? '0'}',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.6),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            bottom: 8, // Tambahkan padding dari bawah
                            right: 8, // Tambahkan padding dari kanan
                            child: Icon(
                              Icons.add_circle,
                              color: Colors.green,
                              size: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          // Ubah latar belakang menjadi putih
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.home,
                  color: Color(0xFF64AA54), // Ubah warna ikon menjadi #64AA54
                ),
                iconSize:
                    30, // Ubah ukuran ikon menjadi lebih besar (misalnya 30)
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  color: Color(0xFF64AA54), // Ubah warna ikon menjadi #64AA54
                ),
                iconSize:
                    30, // Ubah ukuran ikon menjadi lebih besar (misalnya 30)
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  Icons.account_circle,
                  color: Color(0xFF64AA54), // Ubah warna ikon menjadi #64AA54
                ),
                iconSize:
                    30, // Ubah ukuran ikon menjadi lebih besar (misalnya 30)
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
