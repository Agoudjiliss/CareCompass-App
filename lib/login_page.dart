import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:untitled1/token.dart';
import 'package:untitled1/pages/home_page.dart';
import 'package:untitled1/pages/home_screen.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    Future<void> _login(BuildContext context) async {
      final url = Uri.parse('http://localhost:8080/auth/login');

      final email = _emailController.text;
      final password = _passwordController.text;

      try {
        final response = await http.post(
          url,
          body: jsonEncode({
            'email': email,
            'password': password,
          }),
          headers: {
            'Content-Type': 'application/json',
          },
        );

        if (response.statusCode == 200) {
          final token = jsonDecode(response.body)['token'] as String?;
          if (token != null) {
            // Stocker le token dans le fournisseur
            final tokenProvider = Provider.of<TokenProvider>(context, listen: false);
            tokenProvider.setToken(token);
            // Rediriger vers la page d'accueil
            Navigator.pushReplacementNamed(context, '/home');
          } else {
            // Afficher un message d'erreur si le jeton est manquant
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to get token. Please try again.')),
            );
          }
        } else {
          // Afficher un message d'erreur en cas d'échec de la connexion
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to login. Please try again.')),
          );
        }
      } catch (e) {
        // Gérer les erreurs éventuelles
        print('Error: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred. Please try again later.')),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Username',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            _login(context);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()), // Replace HomePage with your actual home page widget
            );
          },
          child: const Text('Login'),
        ),
      
        SizedBox(height: 20),
      ],
    ),
    ),
    );
  }
}
