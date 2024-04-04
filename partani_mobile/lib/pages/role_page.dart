import 'package:flutter/material.dart';
import 'package:partani_mobile/user_login/register_pembeli.dart'; // Ubah sesuai dengan import halaman pendaftaran pembeli
// Import halaman pendaftaran penjual jika ada
import 'package:partani_mobile/user_login/register_penjual.dart'; // Import halaman pendaftaran penjual

class RolePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register As'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          RegisterPembeliPage()), // Ubah sesuai dengan halaman pendaftaran pembeli
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color(0xFF64AA54), // Text color
              ),
              child: Text('Pembeli'),
            ),
            SizedBox(width: 20), // Menambahkan jarak antara tombol
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          RegisterPenjualPage()), // Ubah sesuai dengan halaman pendaftaran penjual
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Color(0xFF64AA54),
                backgroundColor: Colors.white, // Text color
                side: BorderSide(color: Color(0xFF64AA54)), // Border color
              ),
              child: Text('Penjual'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: RolePage(),
  ));
}
