import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ndao_hitafa/pages/login_page.dart';
import 'package:ndao_hitafa/themes/light_mode.dart'; // Assurez-vous que `myColors` est défini dans ce fichier
import 'package:http/http.dart' as http;

class MyProfile extends StatelessWidget {
  final int userId;
  final String username, email, profileUrl;

  const MyProfile({
    super.key,
    required this.userId,
    required this.username,
    required this.email,
    required this.profileUrl,
  });

  Future<void> deleteAccount(BuildContext context) async {
    try {
      final response = await http.delete(
        Uri.parse('http://192.168.56.1:7576/api/users/delete-account/$userId'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(onTap: () {}),
          ),
        );
      } else {
        throw Exception('Failed to delete account');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur lors de la suppression du compte: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil Utilisateur'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 25),
            Image.asset(
              profileUrl,
              width: 65,
              height: 65,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            Text(
              username,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              email,
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UsernameProfileEditPage(
                      username: username,
                      userIdUU: userId,
                    ),
                  ),
                );
              },
              child: const Text('Modifier votre nom'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EmailProfileEditPage(
                      email: email,
                      userIdUU: userId,
                    ),
                  ),
                );
              },
              child: const Text('Modifier votre email'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PasswordProfileEditPage(
                      userIdUU: userId,
                    ),
                  ),
                );
              },
              child: const Text('Modifier votre mot de passe'),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => deleteAccount(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 255, 17, 0),
                textStyle: const TextStyle(color: Colors.white),
              ),
              child: const Text(
                'Supprimer le compte',
                style: TextStyle(color: myColors.white),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(
                      onTap: () {},
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              child: Text(
                'Déconnexion',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UsernameProfileEditPage extends StatefulWidget {
  final int userIdUU;
  final String username;

  const UsernameProfileEditPage({
    super.key,
    required this.userIdUU,
    required this.username,
  });

  @override
  _UsernameProfileEditPageState createState() =>
      _UsernameProfileEditPageState();
}

class EmailProfileEditPage extends StatefulWidget {
  final int userIdUU;
  final String email;

  const EmailProfileEditPage({
    super.key,
    required this.userIdUU,
    required this.email,
  });

  @override
  _EmailProfileEditPageState createState() => _EmailProfileEditPageState();
}

class PasswordProfileEditPage extends StatefulWidget {
  final int userIdUU;

  const PasswordProfileEditPage({
    super.key,
    required this.userIdUU,
  });

  @override
  _PasswordProfileEditPageState createState() =>
      _PasswordProfileEditPageState();
}

class _UsernameProfileEditPageState extends State<UsernameProfileEditPage> {
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: widget.username);
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> updateUsername(BuildContext context) async {
    try {
      final response = await http.put(
        Uri.parse(
            'http://192.168.56.1:7576/api/users/modifier-username/${widget.userIdUU}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(<String, String>{
          'username': _usernameController.text,
          'password': _passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(
              onTap: () {},
            ),
          ),
        );
      } else {
        throw Exception('Failed to update username');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur lors de la modification du nom: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modifier le nom d’utilisateur'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Nom d’utilisateur',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Mot de passe',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => updateUsername(context),
              child: Text('Enregistrer les modifications'),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmailProfileEditPageState extends State<EmailProfileEditPage> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: widget.email);
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> updateEmail(BuildContext context) async {
    try {
      final response = await http.put(
        Uri.parse(
            'http://192.168.56.1:7576/api/users/modifier-email/${widget.userIdUU}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(<String, String>{
          'email': _emailController.text,
          'password': _passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(
              onTap: () {},
            ),
          ),
        );
      } else {
        throw Exception('Failed to update email');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur lors de la modification de l’email: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modifier l’email'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'E-mail',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Mot de passe',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => updateEmail(context),
              child: Text('Enregistrer les modifications'),
            ),
          ],
        ),
      ),
    );
  }
}

class _PasswordProfileEditPageState extends State<PasswordProfileEditPage> {
  late TextEditingController _passwordController;
  late TextEditingController _newPasswordController;
  late TextEditingController _confirmNewPasswordController;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmNewPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();
    super.dispose();
  }

  Future<void> updatePassword(BuildContext context) async {
    try {
      final response = await http.put(
        Uri.parse(
            'http://192.168.56.1:7576/api/users/modifier-password/${widget.userIdUU}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(<String, String>{
          'currentPassword': _passwordController.text,
          'newPassword': _newPasswordController.text,
          'confirmNewPassword': _confirmNewPasswordController.text,
        }),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(
              onTap: () {},
            ),
          ),
        );
      } else {
        throw Exception('Failed to update password');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur lors de la modification du mot de passe: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modifier le mot de passe'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Entrer votre mot de passe actuel',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _newPasswordController,
              decoration: InputDecoration(
                labelText: 'Nouveau mot de passe',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _confirmNewPasswordController,
              decoration: InputDecoration(
                labelText: 'Confirmer le nouveau mot de passe',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => updatePassword(context),
              child: Text('Enregistrer les modifications'),
            ),
          ],
        ),
      ),
    );
  }
}
