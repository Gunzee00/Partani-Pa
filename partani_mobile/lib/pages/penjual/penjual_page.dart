import 'package:flutter/material.dart';
import 'package:partani_mobile/user_login/login_admin.dart';
import 'manage_product.dart'; // Import halaman Manage Product

class PenjualPage extends StatefulWidget {
  @override
  _PenjualPageState createState() => _PenjualPageState();
}

class _PenjualPageState extends State<PenjualPage> {
  int _selectedIndex = 0;

  void _logout(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
      (Route<dynamic> route) => false,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // Tambahkan penanganan untuk navigasi ke ManageProductPage saat indeks 1 diklik
      if (index == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ManageProductPage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Penjual Page'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Color(0xFF64AA54),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business, color: Color(0xFF64AA54)),
            label: 'Manajemen Produk',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Color(0xFF64AA54)),
            label: 'Profil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFF64AA54),
        onTap: _onItemTapped,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(16.0),
        mainAxisSpacing: 16.0,
        crossAxisSpacing: 16.0,
        children: <Widget>[
          _buildCard('Menunggu Proses Pemesanan', ' 1'),
          _buildCard('Pesanan Sedang Diproses', ' 9'),
          _buildCard('Pesanan Berhasil', '  10'),
        ],
      ),
    );
  }

  Widget _buildCard(String title, String subtitle) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Card(
        color: Colors.white, // set card color to white
        child: Center(
          child: ListTile(
            title: Text(
              title,
              textAlign: TextAlign.center, // center align the title
            ),
            subtitle: Text(
              subtitle,
              textAlign: TextAlign.center, // center align the subtitle
            ),
            // Tambahkan onTap untuk menavigasi ke halaman detail pesanan jika diperlukan
          ),
        ),
      ),
    );
  }
}
