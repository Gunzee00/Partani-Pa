import 'package:flutter/material.dart';

class EditProduct extends StatefulWidget {
  final Map<String, dynamic> product;

  EditProduct({required this.product});

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  TextEditingController _productNameController = TextEditingController();
  TextEditingController _productDescriptionController = TextEditingController();
  TextEditingController _productPriceController = TextEditingController();
  TextEditingController _productImageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _productNameController.text = widget.product['nama_produk'];
    _productDescriptionController.text = widget.product['deskripsi'];
    _productPriceController.text = widget.product['harga_produk'].toString();
    _productImageController.text = widget.product['gambar_produk'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _productNameController,
              decoration: InputDecoration(labelText: 'Product Name'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _productDescriptionController,
              decoration: InputDecoration(labelText: 'Product Description'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _productPriceController,
              decoration: InputDecoration(labelText: 'Product Price'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            TextField(
              controller: _productImageController,
              decoration: InputDecoration(labelText: 'Product Image URL'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Prepare updated data
                Map<String, dynamic> updatedData = {
                  'nama_produk': _productNameController.text,
                  'deskripsi': _productDescriptionController.text,
                  'harga_produk': double.parse(
                      _productPriceController.text), // Konversi ke double
                  'gambar_produk': _productImageController.text,
                };
                // Pass the updated data back to the calling widget
                Navigator.pop(context, updatedData);
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
