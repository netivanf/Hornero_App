import 'package:flutter/material.dart';
import 'package:hornero_app/models/category.dart';
import 'package:hornero_app/models/sale.dart';
import 'package:hornero_app/provider/sale.dart';
import 'package:hornero_app/routes/app_routes.dart';
import 'package:hornero_app/widgets/decoration.dart';
import 'package:hornero_app/widgets/drawer.dart';
import 'package:hornero_app/widgets/header.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';

class SaleList extends StatelessWidget {
  const SaleList({super.key});

  //final User user = ModalRoute.of(context)?.settings.arguments as User;

  @override
  Widget build(BuildContext context) {
    final str = ModalRoute.of(context)?.settings.arguments as Argumentos;
    final User? user = str.user;
    final Category? categorySale = str.category;

    List<Sale> categorySales;

    final SalesProvider ctgSales = Provider.of(context);

    if (categorySale!.descricao == "Todas") {
      //categorySales = DUMMY_SALES.toList();
      categorySales = ctgSales.all.toList();
      //categorySales = DUMMY_SALES.toList();

    } else {
      categorySales = ctgSales.all.where((sale) {
        return sale.idCategory.contains(categorySale.id.toString());
      }).toList();
    }
    //categorySales = DUMMY_SALES.where((sale) {
    // return sale.idCategory!.contains(categorySale.id.toString());
    //}).toList();
    //   }

    //if (categorySales.isEmpty) {
    if (categorySales.isEmpty) {
      return Scaffold(
        endDrawer: HorneroDrawer(user: user!),
        body: Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: HeaderHornero(
                startWidget: false,
                user: user,
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 150),
                child: Text(
                  textAlign: (TextAlign.center),
                  'Não há anúncios nessa categoria!',
                  style: TextStyle(
                    fontFamily: "TangoSans",
                    fontSize: 50,
                    color: HorneroDecoration().getColor('blue'),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    } else {
      return Scaffold(
        endDrawer: HorneroDrawer(user: user!),
        body: Center(
          child: Wrap(
            children: [
              HeaderHornero(
                startWidget: false,
                user: user,
              ),
              Container(
                  padding: const EdgeInsets.only(top: 15, bottom: 15),
                  child: Center(
                      child: Text(
                    'Anúncios em Destaque ${categorySales.length.toString()}',
                    style: TextStyle(
                      fontFamily: "TangoSans",
                      fontSize: 20,
                      color: HorneroDecoration().getColor('blue'),
                    ),
                  ))),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.85,
                width: MediaQuery.of(context).size.width,
                child: GridView.builder(
                  padding: const EdgeInsets.all(10.0),
                  itemCount: categorySales.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 2,
                  ),
                  itemBuilder: ((context, index) => Column(
                        children: [
                          Expanded(
                            child: Container(
                              width: 370,
                              height: 100,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(categorySales
                                          .elementAt(index)
                                          .imageURL[0]),
                                      fit: BoxFit.fill),
                                  border: Border.all(
                                    color: HorneroDecoration().colorSale(
                                        categorySales
                                            .elementAt(index)
                                            .priceSell),
                                    width: 3,
                                  ),
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: Text(
                                (categorySales
                                    .elementAt(index)
                                    .descProduct
                                    .toString()),
                                style: TextStyle(
                                    fontFamily: "TangoSans",
                                    color: HorneroDecoration().getColor('blue'),
                                    fontSize: 18)),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 15.0, bottom: 2),
                            child: Text(
                                ('R\$ ${categorySales.elementAt(index).priceSell.toString()}'),
                                style: TextStyle(
                                    fontFamily: "TangoSans",
                                    color: HorneroDecoration().getColor('blue'),
                                    fontSize: 18)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    foregroundColor:
                                        HorneroDecoration().getColor('blue'),
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            width: 3,
                                            color: HorneroDecoration()
                                                .colorSale(categorySales
                                                    .elementAt(index)
                                                    .priceSell)),
                                        borderRadius:
                                            BorderRadius.circular(20))),
                                onPressed: () => Navigator.pushNamed(
                                    context, AppRoutes.SALE_SELECTED,
                                    arguments: ArgumentosSaleList(
                                        saleSelected:
                                            categorySales.elementAt(index),
                                        userLogged: user)),

                                /*Sale(
                                      user: categorySales.elementAt(index).user,
                                      category:
                                          categorySales.elementAt(index).category,
                                      model: categorySales.elementAt(index).model,
                                      brand: categorySales.elementAt(index).brand,
                                      descProduct:
                                          categorySales.elementAt(index).descProduct,
                                      unitMeasurement: categorySales
                                          .elementAt(index)
                                          .unitMeasurement,
                                      quantity:
                                          categorySales.elementAt(index).quantity,
                                      sell: categorySales.elementAt(index).sell,
                                      donation: categorySales.elementAt(index).donation,
                                      imageURL: categorySales.elementAt(index).imageURL,
                                      priceSell: categorySales.elementAt(index).priceSell))*/
                                child: const Text('Ver detalhes')),
                          )
                        ],
                      )),
                ),
              )
            ],
          ),
        ),
      );
    }
  }
}

class ArgumentosSaleList {
  Sale? saleSelected;
  User? userLogged;

  ArgumentosSaleList({required this.saleSelected, required this.userLogged});
}
