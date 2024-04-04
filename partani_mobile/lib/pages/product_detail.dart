import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
  final dynamic product;

  ProductDetailPage({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Produk"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Place the image widget here
            Container(
              height: 300, // Set the height according to your requirement
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/image.jpeg'),
                  fit: BoxFit.cover, // Adjust the fit as needed
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Text(
                    '\Rp.${product['harga_produk']}',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    product['nama_produk'],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Deskripsi Produk',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    product['deskripsi'],
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 60,
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Implement your cart functionality here
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Color(0xFF64AA54),
                  backgroundColor: Colors.white, // Text color
                  side: BorderSide(color: Color(0xFF64AA54)), // Border color
                ),
                child: Text('chat'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Implement your buy now functionality here
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Color(0xFF64AA54),
                  backgroundColor: Colors.white, // Text color
                  side: BorderSide(color: Color(0xFF64AA54)), // Border color
                ),
                child: Text('Beli Langsung'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Implement your cart functionality here
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFF64AA54), // Text color
                ),
                child: Text('Keranjang'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
