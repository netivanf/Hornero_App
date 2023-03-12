import 'package:flutter/material.dart';
import 'package:hornero_app/widgets/categoy_tile.dart';
import 'package:hornero_app/widgets/drawer.dart';
import 'package:hornero_app/widgets/header.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../provider/category.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    final CategoriesProvider categories = Provider.of(context);
    final User user = ModalRoute.of(context)?.settings.arguments as User;

    return Scaffold(
        endDrawer: HorneroDrawer(
          user: user,
        ),

        //LisView builder -> Lista para Exibir muitos resultados na tela
        body: Column(
          children: [
            HeaderHornero(
              user: user,
              startWidget: false,
            ),
            const SizedBox(
              height: 6,
            ),
            Container(
              color: Colors.grey[200],
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: ListView.builder(
                  itemCount: categories.count,
                  itemBuilder: (context, item) => Column(
                    children: [
                      const SizedBox(
                        height: 4,
                      ),
                      CategoryTile(category: categories.byIndex(item)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
