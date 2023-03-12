import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:hornero_app/models/category.dart';
import 'package:http/http.dart' as http;

import '../data/dummy_category.dart';

//Padrão observer ChangeNotifier
//Sempre que tiver uma mudança nesse MAP de usuários
//Os listeners serão notificados e a interface gráfica
//vai ser atualizada
class CategoriesProvider with ChangeNotifier {
  final Map<String, Category> _items = {...DUMMY_CATEGORIES};

  List<Category> get all {
    return [..._items.values];
  }

  int get count {
    return _items.length;
  }

  Category byIndex(int i) {
    return _items.values.elementAt(i);
  }

  String lastId() {
    return _items.keys.last;
  }

  void put(Category category) {
    if (category.id.toString() != "" &&
        _items.containsKey(category.id.toString())) {
      //(_)Significa que não vou usar nenhum parametro embora seja
      //exigido
      _items.update(category.id.toString(), (_) => category);
    } else {
//adicionar usuário
      var id = int.parse(lastId()) + 1;
      _items.putIfAbsent(
        id.toString(),
        () => Category(
          descricao: category.descricao,
          imageURL: category.imageURL,
          id: id.toString(),
        ),
      );
    }

    notifyListeners();
  }

  void remove(Category category) {
    if (category != null && category.id != null) {
      _items.remove(category.id.toString());
    }
    notifyListeners();
  }

  String? byId(String id) {
    for (int i = 0; i < _items.length; i++) {
      if (id == (_items.values.elementAt(i).id)) {
        return (_items.values.elementAt(i).descricao);
      }
    }
  }
}
