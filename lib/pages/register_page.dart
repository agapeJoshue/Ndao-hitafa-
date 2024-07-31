import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ndao_hitafa/Auth/login_or_register.dart';
import 'dart:convert';
import '../utils/host.dart';
import '../components/my_textfield.dart';
import '../components/my_button.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final void Function()? onTap;

  RegisterPage({super.key, required this.onTap});

  Future<void> register(BuildContext context) async {
    final String username = _usernameController.text;
    final String email = _emailController.text;
    final String password = _passwordController.text;
    final String cpassword = _confirmPasswordController.text;

    if (username == "" || email == "" || password == "" || cpassword == "") {
    } else {
      if (password != cpassword) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text("Password do not match!"),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      } else {
        try {
          final response = await http.post(
            Uri.parse(Host.registerHost),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              'username': username,
              'email': email,
              'password': password,
            }),
          );

          final data = jsonDecode(response.body);
          print(data["data"]["message"]);

          if (data['status']) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginOrRegister()),
            );
          } else {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Error'),
                content: Text(data['message']),
                /* actions: <Widget>[
                  TextButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ], */
              ),
            );
          }
        } catch (e) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Error'),
              content: Text(e.toString()),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.wechat,
                size: 100,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 10),
              Text(
                "NDAO HITAFA",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 50),
              Text(
                "Let's create an account for you.",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary, fontSize: 16),
              ),
              const SizedBox(height: 30),
              MyTextfield(
                  hintText: "Email",
                  obscureText: false,
                  controller: _emailController),
              const SizedBox(height: 10),
              MyTextfield(
                  hintText: "Username",
                  obscureText: false,
                  controller: _usernameController),
              const SizedBox(height: 10),
              MyTextfield(
                  hintText: "Your assword",
                  obscureText: true,
                  controller: _passwordController),
              const SizedBox(height: 10),
              MyTextfield(
                  hintText: "Confirm password",
                  obscureText: true,
                  controller: _confirmPasswordController),
              const SizedBox(height: 20),
              MyButton(
                text: "Register",
                onTap: () => register(context),
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      )),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: onTap,
                    child: Text(
                      "Login now",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
