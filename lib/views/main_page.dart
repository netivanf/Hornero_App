import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hornero_app/models/category.dart';
import 'package:hornero_app/models/user.dart';
import 'package:hornero_app/widgets/decoration.dart';
import 'package:hornero_app/widgets/header.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../provider/category.dart';
import '../provider/user.dart';
import '../routes/app_routes.dart';
import '../widgets/drawer.dart';

class HorneroHome extends StatefulWidget {
  const HorneroHome({super.key});

  @override
  State<HorneroHome> createState() => _HorneroHomeState();
}

class _HorneroHomeState extends State<HorneroHome> {
  int activeIndex = 0;
  final strImages = [
    'assets/images/banner1.PNG',
    'assets/images/banner2.PNG',
    'assets/images/banner3.PNG',
    'assets/images/banner4.PNG'
  ];

  final cat = const Category(
      id: '5',
      descricao: 'Marcenaria',
      imageURL: 'assets/images/construcao.png');

  @override
  Widget build(BuildContext context) {
    final CategoriesProvider categories = Provider.of(context);
    final UsersProvider users = Provider.of(context);
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    final User user = ModalRoute.of(context)?.settings.arguments as User;

    return Scaffold(
      endDrawer: HorneroDrawer(user: user),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: [
            Column(
              children: [
                HeaderHornero(startWidget: false, user: user),
                SizedBox(
                  height: screenHeight * 0.40,
                  width: double.infinity,
                  child: CarouselSlider.builder(
                    options: CarouselOptions(
                      autoPlay: true,
                      //Apresenta uma imagem por vez na tela
                      viewportFraction: 1,
                      onPageChanged: (index, reason) =>
                          setState(() => activeIndex = index),
                    ),
                    itemCount: strImages.length,
                    itemBuilder: (context, index, realIndex) {
                      final strImage = strImages[index];
                      return buildImage(strImage, index);
                    },
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
                  child: AnimatedSmoothIndicator(
                    activeIndex: activeIndex,
                    count: strImages.length,
                    effect: JumpingDotEffect(
                      activeDotColor: HorneroDecoration().colorSale(00),
                      dotColor: Colors.white,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 30, left: 25, bottom: 10),
                  child: Text('Navegue por Categoria',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontFamily: 'TangoSans',
                          fontSize: 20,
                          color: HorneroDecoration().getColor('blue'))),
                ),
                SizedBox(
                  height: screenHeight * 0.22,
                  width: screenWidth * 0.95,
                  //Navegar por categoria - ListView
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.count,
                    itemBuilder: (context, index) =>
                        buildCategory(categories.byIndex(index), user),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildImage(String strImage, int index) => Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 3),
        child: Image.asset(
          strImage,
          fit: BoxFit.cover,
        ),
      );

  Widget buildCategory(final Category category, final User user) => Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height * 0.25,
        width: MediaQuery.of(context).size.width * 0.35,
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 4 / 3,
              child: Material(
                child: Ink.image(
                  image: AssetImage(category.imageURL.toString()),
                  fit: BoxFit.fill,
                  child: InkWell(onTap: () {
                    Navigator.of(context).pushNamed(AppRoutes.SALE,
                        arguments: Argumentos(user: user, category: category));
                  }),
                ),
              ),
            ),
            Text(
              textAlign: TextAlign.center,
              category.descricao.toString(),
              style: TextStyle(
                  fontFamily: 'TangoSans',
                  color: HorneroDecoration().getColor('blue')),
            )
          ],
        ),
      );
}
