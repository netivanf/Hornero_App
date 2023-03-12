import 'package:flutter/material.dart';
import 'package:hornero_app/models/category.dart';
import 'package:provider/provider.dart';

import '../provider/category.dart';

//Classe criada para gerar cada widget que mosta o cadastro
//do usuário
class CategoryTile extends StatelessWidget {
  const CategoryTile({super.key, required this.category});

  final Category category;

  @override
  Widget build(BuildContext context) {
    //ListTile é o "tijolinho" que compõe a listView

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(8),
      width: double.infinity,
      child: SizedBox(
        width: 100,
        child: Row(
          children: [
            Expanded(
                child: AspectRatio(
              aspectRatio: 4 / 3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  category.imageURL.toString(),
                  fit: BoxFit.fill,
                  width: 0.5,
                ),
              ),
            )),
            Container(
              padding: const EdgeInsets.only(left: 8),
              width: 120,
              child: Text(
                category.descricao.toString(),
                style: const TextStyle(
                    fontFamily: 'TangoSans',
                    fontSize: 20,
                    color: Color.fromARGB(
                      255,
                      29,
                      58,
                      107,
                    )),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.edit),
              color: const Color.fromARGB(255, 29, 58, 107),
            ),
            IconButton(
                icon: const Icon(Icons.delete),
                color: const Color.fromARGB(255, 241, 143, 52),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text(
                        'Hornero APP',
                        style: TextStyle(
                          fontFamily: 'TangoSans',
                          color: Color.fromARGB(255, 29, 58, 107),
                        ),
                      ),
                      content: const Text(
                          'Tem certeza que deseja excluir essa categoria?',
                          style: TextStyle(
                            fontFamily: 'TangoSans',
                            color: Color.fromARGB(255, 29, 58, 107),
                          )),
                      actions: <Widget>[
                        ElevatedButton(
                          style: const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll<Color>(
                                  Color.fromARGB(255, 241, 143, 52))),
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          child: const Text('Não',
                              style: TextStyle(
                                fontFamily: 'TangoSans',
                                //color: Color.fromARGB(255, 29, 58, 107),
                                color: Color.fromARGB(255, 255, 255, 255),
                              )),
                        ),
                        ElevatedButton(
                            style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        Color.fromARGB(255, 29, 58, 107))),
                            child: const Text('Sim',
                                style: TextStyle(
                                  fontFamily: 'TangoSans',
                                  color: Colors.white,
                                )),
                            onPressed: () {
                              Provider.of<CategoriesProvider>(context,
                                      listen: false)
                                  .remove(category);
                              Navigator.of(context).pop(true);
                            })
                      ],
                    ),
                  ).then(
                    (confirmed) => confirmed == true
                        ? showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                    title: const Text('Hornero APP',
                                        style: TextStyle(
                                          fontFamily: 'TangoSans',
                                          color:
                                              Color.fromARGB(255, 29, 58, 107),
                                        )),
                                    content: const Text(
                                        'Categoria excluída com sucesso!',
                                        style: TextStyle(
                                          fontFamily: 'TangoSans',
                                          color:
                                              Color.fromARGB(255, 29, 58, 107),
                                        )),
                                    actions: <Widget>[
                                      ElevatedButton(
                                          child: const Text('Ok',
                                              style: TextStyle(
                                                fontFamily: 'TangoSans',
                                                color: Color.fromARGB(
                                                    255, 29, 58, 107),
                                              )),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          })
                                    ]))
                        : showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              //icon: const Icon(Icons.auto_awesome),
                              title: const Text('Hornero APP',
                                  style: TextStyle(
                                    fontFamily: 'TangoSans',
                                    color: Color.fromARGB(255, 29, 58, 107),
                                  )),
                              content:
                                  const Text('Operação cancelada pelo usuário!',
                                      style: TextStyle(
                                        fontFamily: 'TangoSans',
                                        color: Color.fromARGB(255, 29, 58, 107),
                                      )),
                              actions: <Widget>[
                                ElevatedButton(
                                  child: const Text('Ok'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
