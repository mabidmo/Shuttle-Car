import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shuttle_car/pages/login.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:email_validator/email_validator.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String message = '';

  Future<void> register(String username, String password, String email) async {
    final response = await http.post(
      Uri.parse(
          'http://192.168.1.5:8080/ShuttleCarAPI/registerr.php'), // Sesuaikan URL dengan URL backend Anda
      body: {
        'username': username,
        'password': password,
        'email': email,
      },
    );

    final responseData = json.decode(response.body);

    setState(() {
      message = responseData['message'];
    });

    if (response.statusCode == 200) {
      // Registrasi berhasil
      print('Registrasi berhasil: $message');
      // Lakukan navigasi ke halaman login atau lakukan tindakan lain sesuai kebutuhan Anda
    } else {
      // Registrasi gagal
      print('Registrasi gagal: $message');
    }
  }

  bool _showPassword = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.fromLTRB(28, 0, 28, 0),
        child: SafeArea(
            child: Center(
          child: SingleChildScrollView(
            // reverse: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage('images/Logo Apk.png'),
                      width: 200,
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'Create Account',
                  style: TextStyle(fontSize: 13),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    labelText: 'Name',
                    hintText: 'Nama Anda',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    labelText: 'Email',
                    hintText: 'Email Anda',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: passwordController,
                  obscureText: !_showPassword,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _showPassword = !_showPassword;
                          });
                        },
                        icon: Icon(_showPassword
                            ? Icons.visibility
                            : Icons.visibility_off)),
                    labelText: 'Password',
                    hintText: 'Password anda',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  message,
                  style: TextStyle(color: Colors.red),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: 360,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {
                        String username = nameController.text.trim();
                        String password = passwordController.text.trim();
                        String email = emailController.text.trim();
                        if (username.isEmpty ||
                            password.isEmpty ||
                            email.isEmpty) {
                          setState(() {
                            message = 'Harap isi semua kolom';
                          });
                        } else if (!EmailValidator.validate(email)) {
                          setState(() {
                            message = 'Email tidak valid';
                          });
                        } else if (password.length < 8 ||
                            !password.contains(RegExp(r'[A-Z]'))) {
                          setState(() {
                            message =
                                'Password harus terdiri dari minimal 8 karakter dan memiliki setidaknya satu huruf besar';
                          });
                        } else {
                          // Semua validasi berhasil, lakukan registrasi
                          register(username, password, email);
                        }
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Colors.red),
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14)))),
                      child: Text(
                        'Register',
                        style: TextStyle(color: Colors.white),
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Divider(
                        color: Colors.black,
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text("Or Sign Up With"),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.black,
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 360,
                  height: 50,
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                    icon: Icon(
                      FontAwesomeIcons.google,
                      color: Colors.black,
                    ),
                    label: Text(
                      'Login With Google',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Saya mempunyai account"),
                    TextButton(
                      onPressed: () {
                        // Action when Sign Up button is pressed
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => login()),
                        );
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
