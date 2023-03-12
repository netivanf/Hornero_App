import 'package:flutter/material.dart';

import 'package:hornero_app/provider/user.dart';
import 'package:hornero_app/routes/app_routes.dart';
import 'package:hornero_app/widgets/user_tile.dart';
import 'package:provider/provider.dart';

class UserList extends StatelessWidget {
  const UserList({super.key});

  @override
  Widget build(BuildContext context) {
    final UsersProvider users = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 29, 58, 107),
        centerTitle: true,
        title: const Text('Lista de Usuários', textAlign: TextAlign.center),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.USER_FORM,
                );
              },
              icon: const Icon(Icons.add)),
        ],
      ),
      //LisView builder -> Lista para Exibir muitos resultados na tela

      body: ListView.builder(
        //itemCount -> Tamanho da lista -> peguei o tamanho do array users
        itemCount: users.count,
        //itemCount -> O que vai ser exibido na lista
        itemBuilder: (context, item) => UserTile(user: users.byIndex(item)),
      ),
    );
  }
}
