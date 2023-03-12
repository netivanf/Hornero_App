import 'package:flutter/material.dart';
import 'package:hornero_app/models/category.dart';
import 'package:hornero_app/models/user.dart';
import 'package:hornero_app/provider/user.dart';
import 'package:provider/provider.dart';
import '../routes/app_routes.dart';

class HorneroDrawer extends StatelessWidget {
  final User user;
  const HorneroDrawer({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    const String teste = 'Teste';
    return Drawer(
      backgroundColor: Colors.white,
      child: SingleChildScrollView(
        child: Wrap(
          runSpacing: 12,
          alignment: WrapAlignment.spaceEvenly,
          children: [
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(
                top: 24 + MediaQuery.of(context).padding.top,
                bottom: 24,
              ),
              child: Column(
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 52,
                    backgroundImage: AssetImage('assets/images/icon.png'),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    user.nome.toString(),
                    style: const TextStyle(
                      fontFamily: 'TangoSans',
                      fontSize: 20,
                      color: Color.fromARGB(255, 29, 58, 107),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    user.email.toString(),
                    style: const TextStyle(
                      fontFamily: 'TangoSans',
                      fontSize: 15,
                      color: Color.fromARGB(255, 29, 58, 107),
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                    color: Color.fromARGB(255, 29, 58, 107),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.home_outlined,
                size: 30,
                color: Color.fromARGB(255, 29, 58, 107),
              ),
              title: const Text(
                "Home",
                style: TextStyle(
                  fontFamily: "TangoSans",
                  fontSize: 20,
                  color: Colors.blueGrey,
                ),
              ),
              onTap: () {
                Navigator.of(context)
                    .pushNamed(AppRoutes.HORNERO_MAIN, arguments: user);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.view_list,
                size: 30,
                color: Color.fromARGB(255, 29, 58, 107),
              ),
              title: const Text(
                "Categorias",
                style: TextStyle(
                  fontFamily: "TangoSans",
                  fontSize: 20,
                  color: Colors.blueGrey,
                ),
              ),
              onTap: () {
                Navigator.of(context)
                    .pushNamed(AppRoutes.CATEGORY, arguments: user);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.grid_view,
                size: 30,
                color: Color.fromARGB(255, 29, 58, 107),
              ),
              title: const Text(
                "Cadastrar Anúncio",
                //"Meus Anúncios",
                style: TextStyle(
                  fontFamily: "TangoSans",
                  fontSize: 20,
                  color: Colors.blueGrey,
                ),
              ),
              onTap: () {
                //Por enquanto vai para um FORM cadastrar um anúncio
                Navigator.of(context).pushNamed(AppRoutes.SALE_FORM,
                    arguments: Argumentos(user: user));
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.favorite,
                size: 30,
                color: Color.fromARGB(255, 29, 58, 107),
              ),
              title: const Text(
                "Favoritos",
                style: TextStyle(
                  fontFamily: "TangoSans",
                  fontSize: 20,
                  color: Colors.blueGrey,
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(
                Icons.exit_to_app,
                size: 30,
                color: Color.fromARGB(255, 29, 58, 107),
              ),
              title: const Text(
                "Sair",
                style: TextStyle(
                  fontFamily: "TangoSans",
                  fontSize: 20,
                  color: Colors.blueGrey,
                ),
              ),
              onTap: () {
                Provider.of<UsersProvider>(context, listen: false).clearUsers();
                Navigator.of(context).pushNamed(AppRoutes.HOME);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Argumentos {
  final User? user;
  final Category? category;

  Argumentos({this.user, this.category});
}
