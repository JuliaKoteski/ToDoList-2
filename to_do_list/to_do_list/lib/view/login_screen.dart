import 'package:bloco_de_notas/auth_service.dart';
import 'package:bloco_de_notas/view/register_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _senhaController = TextEditingController();

  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.deepPurple,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      const FlutterLogo(size: 76),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _emailController,
                        decoration: const InputDecoration(hintText: 'E-mail'),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        obscureText: true,
                        controller: _senhaController,
                        decoration: const InputDecoration(hintText: 'Senha'),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          authService.entrarUsuario(
                              email: _emailController.text,
                              senha: _senhaController.text);
                        },
                        child: const Text('Acessar'),
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterScreen()));
                        },
                        child: const Text('Criar sua Conta'),
                      ),
                    ],
                  ))
            ],
          )),
    );
  }
}
