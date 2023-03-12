import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hornero_app/models/sale.dart';
import 'package:hornero_app/data/dummy_sale.dart';
import 'package:hornero_app/provider/user.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../models/user.dart';

class SalesProvider with ChangeNotifier {
  BuildContext? context;
  final Set<Sale> _items = {...DUMMY_SALES};
  //final Set<Sale> _itemsFirebase = {};
  final _baseUrl = 'https://hornero-app-db-default-rtdb.firebaseio.com';

  List<Sale> get all {
    return [..._items];
  }

  Future<void> saveSales(var formSale) async {
    User user = formSale['user'];
    String userId = user.id.toString();

    final response = await http.post(
      Uri.parse('$_baseUrl/sales.json'),
      body: jsonEncode(
        {
          "brand": formSale['brand'],
          "idCategory": formSale['categoryId'],
          "descProduct": formSale['descProduct'],
          "donation": formSale['donation'],
          "imageURL": formSale['imageURL'],
          "model": formSale['brand'],
          "quantity": formSale['quantity'],
          "sell": formSale['sell'],
          "unitMeasurement": formSale['unitMeasurement'],
          "user": userId,
          "priceSell": formSale['priceSell'],
        },
      ),
    );

    //void addSale(Sale sale) {
    final idFirebase = jsonDecode(response.body)['name'];

    bool donation = (formSale['donation']);

    _items.add(Sale(
      brand: formSale['brand'],
      idCategory: formSale['categoryId'],
      descProduct: formSale['descProduct'],
      donation: donation,
      imageURL: formSale['imageURL'],
      model: formSale['brand'],
      quantity: formSale['quantity'],
      sell: !donation,
      unitMeasurement: formSale['unitMeasurement'],
      user: user,
      id: idFirebase,
      priceSell: formSale['priceSell'],
    ));
    notifyListeners();
  }
}
