import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  bool _isLoading = false; // Para manejar el estado de carga

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    final String usuario = _userController.text.trim();
    final String clave = _passwordController.text.trim();

    if (usuario.isEmpty || clave.isEmpty) {
      setState(() {
        _errorMessage = 'Por favor ingrese usuario y contraseña';
        _isLoading = false;
      });
      return;
    }

    try {
      
      const String apiUrl = 'https://carros-electricos.wiremockapi.cloud/auth';
      
      // Realizar la petición POST
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': usuario,
          'password': clave,
        }),
      );

      if (response.statusCode == 200) {
        // Login exitoso
        final responseData = json.decode(response.body);
        // Puedes manejar los datos de respuesta aquí (token, user data, etc.)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login exitoso')),
        );
        // Navegar a otra pantalla después del login exitoso
        // Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } else {
        // Error en las credenciales
        final errorData = json.decode(response.body);
        setState(() {
          _errorMessage = errorData['message'] ?? 'Credenciales incorrectas';
        });
      }
    } catch (e) {
      // Error de conexión
      setState(() {
        _errorMessage = 'Error de conexión: ${e.toString()}';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Iniciar Sesión')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Login', style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            TextField(
              controller: _userController,
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
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _login,
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