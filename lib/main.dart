import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: LoginScreen(),
  ));
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _userController = TextEditingController();
  final _passwordController = TextEditingController();
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Iniciar Sesión')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column( mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Login', style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),TextField(controller: _userController,
              decoration: InputDecoration(labelText: 'Usuario'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Clave'),
              obscureText: true,
            ),
            SizedBox(height: 10),
            if (_errorMessage.isNotEmpty) 
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String usuario = _userController.text;
                String clave = _passwordController.text;

                if (usuario == 'admin' && clave == 'admin') {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Iniciando sesión'),
                  ));
                } else {
                  setState(() {
                    _errorMessage = 'Credenciales incorrectas';
                  });
                }
              },
              child: Text('Iniciar sesión'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _userController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
