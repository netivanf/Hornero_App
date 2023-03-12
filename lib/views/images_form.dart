import 'package:flutter/material.dart';
import 'package:hornero_app/models/user.dart';
import 'package:hornero_app/widgets/decoration.dart';
import 'package:hornero_app/widgets/drawer.dart';
import 'package:hornero_app/widgets/header.dart';
import 'package:provider/provider.dart';

import '../provider/image_sale.dart';

class ImagesForm extends StatelessWidget {
  const ImagesForm({super.key});

  @override
  Widget build(BuildContext context) {
    final keyImagesForm = GlobalKey<FormState>();
    Argumentos varArg =
        ModalRoute.of(context)?.settings.arguments as Argumentos;
    User? user = varArg.user;

    List<String> urlImage = [];

    return Scaffold(
      endDrawer: HorneroDrawer(user: user!),
      body: Column(
        children: [
          HeaderHornero(startWidget: false, user: user),
          Expanded(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: ListView(
                children: [
                  Form(
                    key: keyImagesForm,
                    child: Column(
                      children: [
                        TextFormField(
                            autofocus: true,
                            decoration: InputDecoration(
                              hintText: 'Foto 1',
                              prefixIcon: const Icon(Icons.http_rounded),
                              prefixIconColor:
                                  HorneroDecoration().getColor('blueGrey'),
                              hintStyle: TextStyle(
                                  fontFamily: 'TangoSansbold',
                                  fontSize: 15,
                                  color:
                                      HorneroDecoration().getColor('blueGrey')),
                              enabledBorder:
                                  HorneroDecoration().myinputborder(),
                              focusedBorder:
                                  HorneroDecoration().myfocusborder(),
                              // hintStyle: TextStyle(color: Colors.pinkAccent)
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Valor incorreto';
                              }
                              return null;
                            },
                            onSaved: (value) => urlImage.add(value!)),
                        const Padding(padding: EdgeInsets.all(5)),
                        TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Foto 2',
                              prefixIcon: const Icon(Icons.http_rounded),
                              prefixIconColor:
                                  HorneroDecoration().getColor('blueGrey'),
                              hintStyle: TextStyle(
                                  fontFamily: 'TangoSansbold',
                                  fontSize: 15,
                                  color:
                                      HorneroDecoration().getColor('blueGrey')),
                              enabledBorder:
                                  HorneroDecoration().myinputborder(),
                              focusedBorder:
                                  HorneroDecoration().myfocusborder(),
                              // hintStyle: TextStyle(color: Colors.pinkAccent)
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Valor incorreto';
                              }
                            },
                            onSaved: (value) => urlImage.add(value!)),
                        const Padding(padding: EdgeInsets.all(5)),
                        TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Foto 3',
                              prefixIcon: const Icon(Icons.http_rounded),
                              prefixIconColor:
                                  HorneroDecoration().getColor('blueGrey'),
                              hintStyle: TextStyle(
                                  fontFamily: 'TangoSansbold',
                                  fontSize: 15,
                                  color:
                                      HorneroDecoration().getColor('blueGrey')),
                              enabledBorder:
                                  HorneroDecoration().myinputborder(),
                              focusedBorder:
                                  HorneroDecoration().myfocusborder(),
                              // hintStyle: TextStyle(color: Colors.pinkAccent)
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Valor incorreto';
                              }
                            },
                            onSaved: (value) => urlImage.add(value!)),
                        const Padding(padding: EdgeInsets.all(5)),
                        Container(
                          decoration: const BoxDecoration(),
                          padding: const EdgeInsets.only(top: 50, bottom: 15),
                          width: double.infinity,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                              ))),
                              onPressed: () {
                                final isValid =
                                    keyImagesForm.currentState?.validate();
                                if (isValid!) {
                                  keyImagesForm.currentState?.save();

                                  Provider.of<ImageSaleProvider>(context,
                                          listen: false)
                                      .delete();
                                  Provider.of<ImageSaleProvider>(context,
                                          listen: false)
                                      .put(urlImage);

                                  Navigator.of(context).pop();
                                }
                              },
                              child: const Text('Enviar Solicitação')),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
