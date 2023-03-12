import 'package:flutter/material.dart';
import 'package:hornero_app/provider/sale.dart';
import 'package:hornero_app/provider/user.dart';
import 'package:hornero_app/routes/app_routes.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';

class HeaderHornero extends StatelessWidget {
  final bool? startWidget;
  final User? user;

  const HeaderHornero({super.key, this.startWidget, this.user});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    bool startApp = startWidget!;

    if (startApp == false) {
      return Container(
        decoration: const BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 15.0,
            offset: Offset(0, 0.75),
          )
        ]),
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: SizedBox(
            height: screenHeight * 0.08,
            width: screenWidth,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: IconButton(
                          iconSize: 30,
                          color: Colors.blueGrey,
                          alignment: Alignment.centerRight,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.arrow_back)),
                    ),
                    SizedBox(
                      child: Image.asset('assets/images/logo-nome-bg.png',
                          scale: 5),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 40),
                      width: 200,
                      child: Row(
                        children: [
                          screen(startApp, user!, context),
                          SizedBox(
                            width: 50,
                            child: IconButton(
                                iconSize: 30,
                                color: Colors.blueGrey,
                                //padding: const EdgeInsets.only(left: 100),
                                alignment: Alignment.centerRight,
                                onPressed: () {
                                  print(Provider.of<SalesProvider>(context,
                                      listen: false));
                                  print(Provider.of<UsersProvider>(context,
                                          listen: false)
                                      .all
                                      .length
                                      .toString());
                                },
                                icon: const Icon(Icons.search_outlined)),
                          ),
                          SizedBox(
                            width: 50,
                            child: Builder(builder: (context) {
                              return IconButton(
                                  iconSize: 30,
                                  color: Colors.blueGrey,
                                  alignment: Alignment.centerRight,
                                  onPressed: () {
                                    Scaffold.of(context).openEndDrawer();
                                  },
                                  icon: const Icon(Icons.menu));
                            }),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      //Header para a tela de cadastro de Usuário
      return Container(
        decoration: const BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 15.0,
            offset: Offset(0, 0.75),
          )
        ]),
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: SizedBox(
            height: screenHeight * 0.08,
            width: screenWidth,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: IconButton(
                          iconSize: 30,
                          color: Colors.blueGrey,
                          alignment: Alignment.centerRight,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.arrow_back)),
                    ),
                    SizedBox(
                      child: Image.asset('assets/images/logo-nome-bg.png',
                          scale: 5),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  Widget screen(bool startApp, User user, context) {
    if (startApp == 'saleScreen') {
      return SizedBox(
        width: 40,
        child: IconButton(
            iconSize: 30,
            color: Colors.blueGrey,
            //padding: const EdgeInsets.only(left: 100),
            alignment: Alignment.centerRight,
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(arguments: user, AppRoutes.SALE_FORM);
            },
            icon: const Icon(Icons.add)),
      );
    } else {
      return const SizedBox(
        width: 40,
      );
    }
  }
}
