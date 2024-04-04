import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:partani_mobile/pages/penjual/manage_product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _satuanController = TextEditingController();
  TextEditingController _minOrderController = TextEditingController();
  TextEditingController _stockController = TextEditingController();

  File? _image;

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _addProduct(String token) async {
    String name = _nameController.text.trim();
    String price = _priceController.text.trim();
    String description = _descriptionController.text.trim();
    String satuan = _satuanController.text.trim();
    String minOrder = _minOrderController.text.trim();
    String stock = _stockController.text.trim();
    String base64Image = '';

    if (_image == null) {
      // Set default image value if user hasn't selected any image
      // You can provide your own default image path or use asset images
      base64Image = 'default_image_path';
    } else {
      // Encode the image file to base64
      List<int> imageBytes = await _image!.readAsBytes();
      base64Image = base64Encode(imageBytes);
    }

    if (name.isEmpty ||
        price.isEmpty ||
        description.isEmpty ||
        satuan.isEmpty ||
        minOrder.isEmpty ||
        stock.isEmpty) {
      _showErrorDialog("Semua kolom harus diisi");
      return;
    }

    try {
      final response = await http.post(
        Uri.parse(
            'http://10.0.2.2:8000/api/create-barang'), // Ganti URL_API_STORE dengan URL API Anda
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, dynamic>{
          'nama_barang': name,
          'harga': price,
          'gambar': base64Image,
          'deskripsi': description,
          'satuan': satuan,
          'minimal_pemesanan': minOrder,
          'stok': stock,
        }),
      );

      if (response.statusCode == 201) {
        _showSuccessDialog();
      } else {
        _showErrorDialog("Gagal menambahkan produk. Silakan coba lagi.");
      }
    } catch (error) {
      _showErrorDialog("Terjadi kesalahan: $error");
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Sukses"),
          content: Text("Produk berhasil ditambahkan"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Navigasi ke halaman ManageProductPage
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ManageProductPage()),
                );
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambahkan Produk'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nama Produk',
                prefixIcon: Icon(Icons.shopping_bag),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Color(0xFF64AA54)),
                ),
              ),
            ),
            SizedBox(height: 12.0),
            TextFormField(
              controller: _priceController,
              decoration: InputDecoration(
                labelText: 'Harga',
                prefixIcon: Icon(Icons.attach_money),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Color(0xFF64AA54)),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 12.0),
            TextFormField(
              controller: _satuanController,
              decoration: InputDecoration(
                labelText: 'Satuan',
                prefixIcon: Icon(Icons.dashboard),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Color(0xFF64AA54)),
                ),
              ),
            ),
            SizedBox(height: 12.0),
            TextFormField(
              controller: _minOrderController,
              decoration: InputDecoration(
                labelText: 'Minimal Order',
                prefixIcon: Icon(Icons.shopping_cart),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Color(0xFF64AA54)),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 12.0),
            TextFormField(
              controller: _stockController,
              decoration: InputDecoration(
                labelText: 'Stok',
                prefixIcon: Icon(Icons.category),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Color(0xFF64AA54)),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 12.0),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Deskripsi',
                // prefixIcon: Icon(Icons.description),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Color(0xFF64AA54)),
                ),
              ),
              maxLines: 5, // Mengatur jumlah baris maksimum
            ),
            SizedBox(height: 12.0),
            GestureDetector(
              onTap: _getImage,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                height: 50,
                child: _image == null
                    ? Icon(Icons.add_a_photo, size: 50, color: Colors.grey)
                    : Image.file(_image!, fit: BoxFit.cover),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                String? token = prefs.getString('token');
                if (token != null) {
                  _addProduct(token);
                } else {
                  // Token belum tersedia, mungkin perlu proses autentikasi
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF64AA54),
              ),
              child: Text('Tambahkan Produk',
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
