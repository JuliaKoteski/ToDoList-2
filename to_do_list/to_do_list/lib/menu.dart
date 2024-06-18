import 'package:bloco_de_notas/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  final User user;

  const Menu({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(children: [
      UserAccountsDrawerHeader(
        accountName: Text(
          (user.displayName != null) ? user.displayName! : '',
        ),
        accountEmail: Text(user.email!),
        currentAccountPicture: const CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(
            Icons.manage_accounts_rounded,
            size: 48,
          ),
        ),
      ),
      ListTile(
        leading: const Icon(Icons.logout),
        title: const Text('Sair'),
        onTap: () {
          AuthService().deslogar();
        },
      )
    ]));
  }
}
