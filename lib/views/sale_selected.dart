import 'package:flutter/material.dart';
import 'package:hornero_app/provider/category.dart';
import 'package:hornero_app/provider/sale.dart';
import 'package:hornero_app/views/sale_list.dart';
import 'package:hornero_app/widgets/decoration.dart';
import 'package:hornero_app/widgets/header.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../models/sale.dart';
import '../models/user.dart';
import '../widgets/drawer.dart';

class SaleSelected extends StatelessWidget {
  const SaleSelected({super.key});

  //final Set<Sale> _items = {...DUMMY_SALES};

  static User? userLogged;
  static Sale? saleSelected;

  @override
  Widget build(BuildContext context) {
    final SalesProvider salesProvider = Provider.of(context);
    final CategoriesProvider ctg = Provider.of(context);
    //var _items = salesProvider.all;

    //Receber os dados do anúncio da Tela anterior
    try {
      final saleList =
          ModalRoute.of(context)?.settings.arguments as ArgumentosSaleList;
      userLogged = saleList.userLogged;
      saleSelected = saleList.saleSelected;
    } catch (e) {}

    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    PageController controller =
        PageController(viewportFraction: 1.1, initialPage: 1);

    Text sellDonationFuncti(bool? saleValueDonation) {
      if (saleValueDonation == false) {
        return const Text("Venda",
            style: TextStyle(
                fontFamily: "TangoSans",
                fontSize: 20,
                color: Color.fromARGB(255, 29, 58, 107)));
      } else {
        return const Text("Doação",
            style: TextStyle(
                fontFamily: "TangoSans",
                fontSize: 20,
                color: Color.fromARGB(255, 29, 58, 107)));
      }
    }

    return Scaffold(
      endDrawer: HorneroDrawer(user: userLogged!),
      body: SizedBox(
        height: screenHeight,
        width: screenWidth,
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            HeaderHornero(startWidget: false, user: userLogged!),
            SizedBox(
              height: screenHeight * 0.8,
              width: double.infinity,
              child: ListView(children: [
                Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    fit: StackFit.loose,
                    clipBehavior: Clip.antiAlias,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: screenWidth * 0.8,
                        child: PageView.builder(
                          controller: controller,
                          scrollDirection: Axis.horizontal,
                          itemCount: saleSelected!.imageURL.length,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: ClipRRect(
                              child: Image.network(
                                saleSelected!.imageURL[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: HorneroDecoration().getColor('blue'),
                            border: Border.all(width: 0),
                            borderRadius: BorderRadius.circular(20)),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(5),
                        height: 30,
                        width: 150,
                        child: SmoothPageIndicator(
                            effect: WormEffect(
                              activeDotColor: HorneroDecoration().colorSale(00),
                              dotColor: Colors.white,
                            ),
                            controller: controller,
                            count: saleSelected!.imageURL.length),
                      )
                    ]),
                Container(
                  padding: const EdgeInsets.only(left: 65, right: 50),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        //A propriedade mainAxisAlignment está configurada como spaceEvenly
                        //para distribuir igualmente os espaços entre os Widgets filhos do Widget Center;
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Marca",
                                  style: TextStyle(
                                      fontFamily: "TangoSans_Bold",
                                      color: Colors.grey),
                                ),
                                Text(
                                  saleSelected!.brand.toString(),
                                  style: const TextStyle(
                                      fontFamily: "TangoSans",
                                      fontSize: 20,
                                      color: Color.fromARGB(255, 29, 58, 107)),
                                ),
                              ]),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Modelo",
                                  style: TextStyle(
                                      fontFamily: "TangoSans_Bold",
                                      color: Colors.grey)),
                              Text(
                                saleSelected!.model.toString(),
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    fontFamily: "TangoSans",
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 29, 58, 107)),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        //mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Text("Descrição",
                                style: TextStyle(
                                    fontFamily: "TangoSans_Bold",
                                    color: Colors.grey)),
                          ),
                          Text(saleSelected!.descProduct.toString(),
                              style: const TextStyle(
                                  fontFamily: "TangoSans",
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 29, 58, 107))),
                        ],
                      ),
                      Column(
                        //mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Text("Unidade de Medida e Quantidade",
                                style: TextStyle(
                                    fontFamily: "TangoSans_Bold",
                                    color: Colors.grey)),
                          ),
                          Text(
                              "${saleSelected!.unitMeasurement.toString()} ${saleSelected!.quantity.toString()}",
                              style: const TextStyle(
                                  fontFamily: "TangoSans",
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 29, 58, 107))),
                        ],
                      ),
                      Column(
                        //mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Text("Categoria",
                                style: TextStyle(
                                    fontFamily: "TangoSans_Bold",
                                    color: Colors.grey)),
                          ),
                          Text(ctg.byId(saleSelected!.idCategory).toString(),
                              style: const TextStyle(
                                  fontFamily: "TangoSans",
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 29, 58, 107))),
                        ],
                      ),
                      Column(
                        //mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Text("Vendedor",
                                style: TextStyle(
                                    fontFamily: "TangoSans_Bold",
                                    color: Colors.grey)),
                          ),
                          Text(saleSelected!.user.nome.toString(),
                              style: const TextStyle(
                                  fontFamily: "TangoSans",
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 29, 58, 107))),
                        ],
                      ),
                      Column(
                        //mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Text("Venda / Doação",
                                style: TextStyle(
                                    fontFamily: "TangoSans_Bold",
                                    color: Colors.grey)),
                          ),
                          Row(
                            children: [
                              sellDonationFuncti(saleSelected!.donation),
                              Text(" R\$ ${saleSelected!.priceSell}",
                                  style: const TextStyle(
                                      fontFamily: "TangoSans",
                                      fontSize: 20,
                                      color: Color.fromARGB(255, 29, 58, 107))),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ]),
            ),
            ElevatedButton(
                style: ButtonStyle(
                    side: MaterialStateProperty.all(const BorderSide(
                      width: 2,
                      color: Color.fromARGB(255, 241, 143, 52),
                    )),
                    backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 255, 255, 255),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ))),
                onPressed: () {},
                child: const Text("Enviar Proposta",
                    style: TextStyle(
                        fontFamily: "TangoSans",
                        fontSize: 15,
                        color: Color.fromARGB(255, 29, 58, 107))))
          ]),
        ),
      ),
    );
  }
}
