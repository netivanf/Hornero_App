import 'package:flutter/material.dart';
import 'package:hornero_app/data/dummy_category.dart';
import 'package:hornero_app/models/user.dart';
import 'package:hornero_app/provider/image_sale.dart';
import 'package:hornero_app/widgets/decoration.dart';
import 'package:hornero_app/widgets/drawer.dart';
import 'package:hornero_app/widgets/header.dart';
import 'package:provider/provider.dart';

import '../models/sale.dart';
import '../provider/sale.dart';
import '../routes/app_routes.dart';

class SaleForm extends StatefulWidget {
  const SaleForm({super.key});

  @override
  State<SaleForm> createState() => _SaleFormState();
}

class _SaleFormState extends State<SaleForm> {
  bool donation = true;

  final titulo = TextEditingController();
  FocusNode focusNode = FocusNode();

  final _keySalesForm = GlobalKey<FormState>();
  final Map<String, dynamic> _formDataSale = {};

  @override
  Widget build(BuildContext context) {
    Argumentos varArg =
        ModalRoute.of(context)?.settings.arguments as Argumentos;
    User? user = varArg.user;
    final imgSale = Provider.of<ImageSaleProvider>(context).all;

    var ctg = {...DUMMY_CATEGORIES}.values.toList();

    //List<String> lista;
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
                    key: _keySalesForm,
                    child: Column(
                      children: [
                        TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Descrição do Produto',
                              prefixIcon: const Icon(Icons.edit_note),
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
                            onSaved: (value) =>
                                _formDataSale['descProduct'] = value!),
                        const Padding(padding: EdgeInsets.all(5)),
                        TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Modelo',
                              prefixIcon: const Icon(Icons.design_services),
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
                            onSaved: (value) =>
                                _formDataSale['model'] = value!),
                        const Padding(padding: EdgeInsets.all(5)),
                        TextFormField(
                            onTap: () => focusNode.requestFocus(),
                            decoration: InputDecoration(
                              hintText: 'Marca',
                              prefixIcon: const Icon(Icons.api),
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
                            onSaved: (value) =>
                                _formDataSale['brand'] = value!),
                        const Padding(padding: EdgeInsets.all(5)),
                        TextFormField(
                            onTap: () => focusNode.requestFocus(),
                            decoration: InputDecoration(
                              hintText: 'Unidade de Medida',
                              prefixIcon: const Icon(Icons.square_foot),
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
                            onSaved: (value) =>
                                _formDataSale['unitMeasurement'] = value!),
                        const Padding(padding: EdgeInsets.all(5)),
                        TextFormField(
                            keyboardType: TextInputType.number,
                            onTap: () => focusNode.requestFocus(),
                            decoration: InputDecoration(
                              hintText: 'Quantidade',

                              prefixIcon: const Icon(Icons.one_x_mobiledata),
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
                            onSaved: (value) => _formDataSale['quantity'] =
                                double.parse(value!)),
                        const Padding(padding: EdgeInsets.all(5)),
                        DropdownButtonFormField(
                            isExpanded: false,
                            decoration: InputDecoration(
                                border: HorneroDecoration().myinputborder(),
                                focusedBorder:
                                    HorneroDecoration().myfocusborder()),
                            hint: Text(
                              'Categoria',
                              style: TextStyle(
                                  fontFamily: 'TangoSansbold',
                                  fontSize: 15,
                                  color:
                                      HorneroDecoration().getColor('blueGrey')),
                            ),
                            items: ctg
                                .map((e) => DropdownMenuItem(
                                      value: e.id,
                                      child: Text(e.descricao.toString()),
                                    ))
                                .toList(),
                            onChanged: ((value) =>
                                _formDataSale['categoryId'] = value!),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Valor incorreto';
                              }
                            },
                            onSaved: (value) =>
                                _formDataSale['categoryId'] = value!),
                        const Padding(padding: EdgeInsets.all(5)),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  width: 3,
                                  color:
                                      HorneroDecoration().getColor('grey')!)),
                          child: Column(
                            children: [
                              Text(
                                "Tipo de Negócio",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: "TangoSansbold",
                                    color: HorneroDecoration()
                                        .getColor('blueGrey')!),
                              ),
                              const Divider(),
                              RadioListTile(
                                title: const Text("Doação"),
                                value: true,
                                groupValue: donation,
                                onChanged: (value) {
                                  setState(() {
                                    donation = value!;
                                    titulo.text = '0.0';
                                  });
                                },
                              ),
                              RadioListTile(
                                title: const Text("Venda"),
                                value: false,
                                groupValue: donation,
                                onChanged: (value) {
                                  setState(() {
                                    donation = value!;

                                    titulo.text = '0.0';
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        const Padding(padding: EdgeInsets.all(5)),
                        TextFormField(
                            keyboardType: TextInputType.number,
                            controller: titulo,
                            decoration: InputDecoration(
                              hintText: 'Preço',
                              prefixIcon: const Icon(Icons.monetization_on),
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
                              double vl = 0.0;

                              if (value == null || value.isEmpty) {
                                return 'Valor incorreto';
                              } else if (double.parse(value) == vl &&
                                  donation == false) {
                                return 'Nesse caso, selecione como Doação';
                              } else if (double.parse(value) > vl &&
                                  donation == true) {
                                return 'Parece que você gostaria de vender!';
                              }
                            },
                            onSaved: (value) => {
                                  _formDataSale['priceSell'] =
                                      double.parse(value!),
                                  _formDataSale['user'] = user,
                                  _formDataSale['imageURL'] = imgSale,
                                  _formDataSale['donation'] = donation,
                                  _formDataSale['sell'] = (!donation),
                                }),
                        const Padding(padding: EdgeInsets.all(5)),
                        Container(
                          decoration: const BoxDecoration(),
                          padding: const EdgeInsets.only(top: 50, bottom: 15),
                          width: double.infinity,
                          child: TextButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.grey[400]),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                ))),
                            child: const Text(
                              'Selecionar Fotos',
                              style: TextStyle(
                                  fontFamily: 'TangoSansbold',
                                  fontSize: 20,
                                  color: Colors.white),
                            ),
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                  AppRoutes.IMAGES_FORM,
                                  arguments: Argumentos(user: user));
                            },
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(),
                          padding: const EdgeInsets.only(top: 10, bottom: 15),
                          width: double.infinity,
                          child: ElevatedButton(
                            style: HorneroDecoration().myElevatedButtonStyle(),
                            onPressed: () {
                              final isValid =
                                  _keySalesForm.currentState?.validate();

                              if (isValid == false || imgSale.isEmpty) {
                              } else {
                                _keySalesForm.currentState?.save();
                                //Salva um novo anúncio
                                Provider.of<SalesProvider>(context,
                                        listen: false)
                                    .saveSales(_formDataSale);

                                Navigator.of(context).pop();
                              }
                            },
                            child: const Text('Enviar Solicitação'),
                          ),
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
