import 'package:flutter/material.dart';
import 'package:hornero_app/models/user.dart';
import 'package:hornero_app/provider/user.dart';
import 'package:hornero_app/routes/app_routes.dart';
import 'package:provider/provider.dart';

//Classe criada para gerar cada widget que mosta o cadastro
//do usuário
class UserTile extends StatelessWidget {
  const UserTile({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    //ListTile é o "tijolinho" que compõe a listView

    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: Color.fromARGB(255, 29, 58, 107),
        child: Icon(Icons.person, color: Colors.white),
      ),
      title: Text(user.nome.toString()),
      subtitle: Text(user.email.toString()),
      trailing: SizedBox(
        width: 100,
        child: Row(children: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(AppRoutes.USER_FORM, arguments: user);
              },
              icon: const Icon(
                Icons.edit,
                color: Color.fromARGB(255, 221, 179, 54),
              )),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Excluir usuário'),
                  content: const Text('Tem certeza?'),
                  actions: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: const Text('Não'),
                    ),
                    ElevatedButton(
                        child: const Text('Sim'),
                        onPressed: () {
                          Provider.of<UsersProvider>(context, listen: false)
                              .remove(user);
                          Navigator.of(context).pop(true);
                        })
                  ],
                ),
              ).then((confirmed) => confirmed == true
                  ? showDialog(
                      context: context,
                      builder: (context) => const AlertDialog(
                          title: Text('Hornero APP'),
                          content: Text('Usuário excluído com sucesso!')))
                  : showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        icon: const Icon(Icons.auto_awesome),
                        title: const Text('Hornero APP'),
                        content: const Text('Operação cancelada pelo usuário!'),
                        actions: <Widget>[
                          ElevatedButton(
                            child: const Text('Ok'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    ));
            },
            icon: const Icon(Icons.delete,
                color: Color.fromARGB(255, 221, 179, 54)),
          )
        ]),
      ),
    );
  }
}
