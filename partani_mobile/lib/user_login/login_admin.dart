import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../pages/pembeli_page.dart';
import '../pages/penjual/penjual_page.dart';
import '../pages/role_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Future<void> loginUser() async {
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      _showErrorDialog("Username dan password harus diisi");
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/user/login'),
        body: jsonEncode({'username': username, 'password': password}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        print("Login berhasil: $responseData");

        if (responseData['data'] != null &&
            responseData['data'].containsKey('role') &&
            responseData['token'] != null) {
          String role = responseData['data']['role'];
          String token = responseData['token'];
          // Simpan token ke shared preferences
          await saveToken(token);
          // Redirect sesuai role
          if (role == 'pembeli') {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => PembeliPage()),
            );
          } else if (role == 'penjual') {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => PenjualPage()),
            );
          } else {
            _showErrorDialog("Invalid user role");
          }
        } else {
          _showErrorDialog("Data user tidak tersedia dalam respons");
        }
      } else if (response.statusCode == 401) {
        _showErrorDialog("Username atau password salah");
      } else {
        _showErrorDialog("Gagal melakukan login");
      }
    } catch (error) {
      _showErrorDialog("Terjadi kesalahan: $error");
    }
  }

  // Fungsi untuk menyimpan token ke shared preferences
  Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.grey),
              ),
              child: TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 12.0,
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.0),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.grey),
              ),
              child: TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 12.0,
                  ),
                ),
                obscureText: true,
              ),
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: loginUser,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color(0xFF64AA54), // Text color
              ),
              child: Text('Login'),
            ),
            SizedBox(height: 12.0),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => RolePage(),
                ));
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Color(0xFF64AA54),
                backgroundColor: Colors.white, // Text color
                side: BorderSide(color: Color(0xFF64AA54)), // Border color
              ),
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Login App',
    home: LoginPage(),
  ));
}
