import 'package:flutter/material.dart';
import 'package:hornero_app/models/category.dart';
import 'package:provider/provider.dart';
import '../provider/category.dart';

class CategoryForm extends StatelessWidget {
  final _keyForm = GlobalKey<FormState>();

  CategoryForm({super.key});

  final Map<String, String> _formData = {};

  @override
  Widget build(BuildContext context) {
    _formData['id'] = 0.toString();
    //Somente executa o try se estiver tudo ok, se não tiver nenhum erro
    // try {
    //  final user = ModalRoute.of(context)?.settings.arguments as User;
    //  _loadFormData(user);
    // ignore: empty_catches
    // } catch (e) {}

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cadastro de Categoria',
          style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontFamily: 'TangoSans',
              fontSize: 18),
        ),
        backgroundColor: const Color.fromARGB(255, 29, 58, 107),
        centerTitle: true,
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 30, bottom: 30, left: 15, right: 15),
        child: ListView(
          children: [
            Form(
              key: _keyForm,
              child: Column(
                children: [
                  TextFormField(
                    //initialValue: _formData['descricao'],
                    decoration: const InputDecoration(
                      labelText: 'Descrição',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Descrição Inválida';
                      }
                    },
                    //onSaved: (value) => _formData['nome'] = value!,
                    onSaved: (value) {
                      _formData['descricao'] = value!;
                    },
                  ),
                  TextFormField(
                    //initialValue: _formData['descricao'],
                    decoration: const InputDecoration(
                      labelText: 'Imagem',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Caminho Inválido';
                      }
                    },
                    //onSaved: (value) => _formData['nome'] = value!,
                    onSaved: (value) {
                      _formData['imageURL'] = value!;
                    },
                  ),
                  Container(
                    decoration: const BoxDecoration(),
                    padding: const EdgeInsets.only(top: 50, bottom: 15),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FloatingActionButton(
                          heroTag: 'btnNewCategory',
                          onPressed: () {
                            final isValid = _keyForm.currentState?.validate();

                            if (isValid!) {
                              _keyForm.currentState?.save();
                              CategoriesProvider category =
                                  Provider.of(context, listen: false);
                              category.put(Category(
                                id: ((_formData['id'].toString())),
                                //
                                descricao: _formData['descricao'].toString(),
                                imageURL: _formData['imageURL'].toString(),
                              ));

                              Navigator.of(context).pop();
                            }
                          },
                          hoverColor: const Color.fromARGB(255, 241, 143, 52),
                          backgroundColor:
                              const Color.fromARGB(255, 241, 143, 52),
                          child: const Icon(Icons.key),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            'Cadastrar Categoria',
                            style: TextStyle(
                                color: Color.fromARGB(255, 29, 58, 107),
                                fontFamily: 'TangoSans'),
                          ),
                        ),
                      ],
                    ),
                  ),

                  /*child: ElevatedButton(
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ))),
                      onPressed: () {
                        final isValid = _keyForm.currentState?.validate();

                        if (isValid!) {
                          _keyForm.currentState?.save();
                          CategoriesProvider category =
                              Provider.of(context, listen: false);
                          category.put(Category(
                            id: (int.parse(_formData['id'].toString())),
                            //
                            descricao: _formData['descricao'].toString(),
                            imageURL: _formData['imageURL'].toString(),
                          ));

                          Navigator.of(context).pop();
                        }
                      },
                      child: const Text('Cadastrar Nova Categoria'),
                    ),*/
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
