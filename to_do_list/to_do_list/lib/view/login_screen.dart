import 'package:bloco_de_notas/to_do_list_page.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String username = '';
    String password = '';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) {
                username = value;
              },
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            const SizedBox(height: 20.0),
            TextField(
              onChanged: (value) {
                password = value;
              },
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Lógica de autenticação
                if (username == 'seu_usuario' && password == 'sua_senha') {
                  // Autenticação bem-sucedida, navegar para a próxima tela
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MyHomePage()));
                } else {
                  // Exibir mensagem de erro se a autenticação falhar
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Erro de autenticação'),
                        content: const Text('Nome de usuário ou senha incorretos.'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}


