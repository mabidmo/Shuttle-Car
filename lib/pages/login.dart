import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shuttle_car/pages/signup.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String message = '';

  Future<void> loginUser(String username, String password) async {
    final response = await http.post(
      Uri.parse(
          'http://192.168.1.5:8080/ShuttleCarAPI/loginn.php'), // Sesuaikan URL dengan URL backend Anda
      body: {
        'username': username,
        'password': password,
      },
    );

    final responseData = json.decode(response.body);

    setState(() {
      message = responseData['message'];
    });

    if (response.statusCode == 200) {
      // Login berhasil
      print(responseData['user']);
      // Lakukan navigasi ke halaman berikutnya atau lakukan tindakan lain sesuai kebutuhan Anda
      // Navigator.pushReplacementNamed(context, '/home');
    } else {
      // Login gagal
      print('Login gagal: $message');
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
                  height: 50,
                ),
                Text(
                  'Login',
                  style: TextStyle(fontSize: 25),
                ),
                Text(
                  'Welcome Back',
                  style: TextStyle(fontSize: 15, fontFamily: 'Roboto'),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    labelText: 'Email',
                    hintText: 'Email UISI',
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
                    hintText: 'Password',
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
                        String username = usernameController.text.trim();
                        String password = passwordController.text.trim();
                        if (username.isNotEmpty && password.isNotEmpty) {
                          loginUser(username, password);
                        } else {
                          setState(() {
                            message =
                                'Username dan password tidak boleh kosonggg';
                          });
                        }
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Colors.red),
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14)))),
                      child: Text(
                        'Login',
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
                    Text("Tidak punya akun?"),
                    TextButton(
                      onPressed: () {
                        // Action when Sign Up button is pressed
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => signup()),
                        );
                      },
                      child: Text(
                        'Sign Up',
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
