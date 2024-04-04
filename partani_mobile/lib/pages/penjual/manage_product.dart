import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:partani_mobile/pages/penjual/add_product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ManageProductPage extends StatefulWidget {
  @override
  _ManageProductPageState createState() => _ManageProductPageState();
}

class _ManageProductPageState extends State<ManageProductPage> {
  List<dynamic> _barangs = [];

  @override
  void initState() {
    super.initState();
    _fetchBarangs();
  }

  Future<void> _fetchBarangs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null) {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/barang'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        setState(() {
          _barangs = json.decode(response.body)['barang'];
        });
      } else {
        throw Exception('Failed to load products');
      }
    } else {
      // Token not available, perhaps need authentication process
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Products'),
      ),
      body: _barangs.isEmpty
          ? Center(
              child: Text('No products available'),
            )
          : ListView.builder(
              itemCount: _barangs.length,
              itemBuilder: (context, index) {
                final barang = _barangs[index];
                return ListTile(
                  title: Text(barang['nama_barang']),
                  subtitle: Text(barang['harga'].toString()),
                  // Add more details as needed
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToAddProductPage(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _navigateToAddProductPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddProductPage()),
    );
  }
}
