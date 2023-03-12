import 'package:flutter/material.dart';
import 'package:hornero_app/provider/category.dart';
import 'package:hornero_app/provider/image_sale.dart';
import 'package:hornero_app/provider/sale.dart';
import 'package:hornero_app/provider/user.dart';
import 'package:hornero_app/routes/app_routes.dart';
import 'package:hornero_app/views/category_form.dart';
import 'package:hornero_app/views/category_list.dart';
import 'package:hornero_app/views/images_form.dart';
import 'package:hornero_app/views/main_page.dart';
import 'package:hornero_app/views/sale_form.dart';
import 'package:hornero_app/views/sale_list.dart';
import 'package:hornero_app/views/sale_selected.dart';
import 'package:hornero_app/views/user_form.dart';
import 'package:hornero_app/views/user_list.dart';
import 'package:hornero_app/views/user_login.dart';
import 'package:hornero_app/views/welcome.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const HorneroApp());
}

class HorneroApp extends StatelessWidget {
  const HorneroApp({super.key});

  @override
  Widget build(BuildContext context) {
    //O Material APP será envolvido pelo ChangeNotifier a fim de
    //saber toda vez que houver uma alteração
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) {
            return UsersProvider();
          },
          //ou create: (context) => Users(),
          //Arrow Function tem um return implicito
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) {
            return CategoriesProvider();
          },
          //ou create: (context) => Users(),
          //Arrow Function tem um return implicito
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) {
            return ImageSaleProvider();
          },
          //ou create: (context) => Users(),
          //Arrow Function tem um return implicito
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) {
            return SalesProvider();
          },
          //ou create: (context) => Users(),
          //Arrow Function tem um return implicito
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        //home: const UserList(),
        routes: {
          AppRoutes.HOME: (_) => UserLogin(),
          AppRoutes.USER_FORM: (_) => const UserForm(),
          AppRoutes.USER_LIST: (_) => const UserList(),
          AppRoutes.HORNERO_MAIN: (_) => const HorneroHome(),
          AppRoutes.CATEGORY: (_) => const CategoryList(),
          AppRoutes.CATEGORY_FORM: (_) => CategoryForm(),
          AppRoutes.SALE: (_) => const SaleList(),
          AppRoutes.SALE_SELECTED: (_) => const SaleSelected(),
          AppRoutes.SALE_FORM: (_) => const SaleForm(),
          AppRoutes.IMAGES_FORM: (_) => const ImagesForm(),
          AppRoutes.WELCOME_SCREEN: (_) => const WelcomeScreen(),
        },
      ),
    );
  }
}
