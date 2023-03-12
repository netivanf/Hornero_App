import 'package:flutter/cupertino.dart';

//Padrão observer ChangeNotifier
//Sempre que tiver uma mudança nesse MAP de usuários
//Os listeners serão notificados e a interface gráfica
//vai ser atualizada
class ImageSaleProvider with ChangeNotifier {
  List<String> _imageList = [];

  List<String> get all {
    return _imageList;
  }

  void put(List<String> imgSale) {
    _imageList = imgSale;

    notifyListeners();
  }

  void delete() {
    _imageList.clear();

    notifyListeners();
  }
}
