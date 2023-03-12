import 'package:hornero_app/models/user.dart';

class Sale {
  final String id;
  final User user;
  final String idCategory;
  final String model;
  final String brand;
  final String descProduct;
  final String unitMeasurement;
  final double quantity;
  final bool sell;
  final bool donation;
  final double priceSell;
  final List<String> imageURL;

  Sale({
    required this.id,
    required this.user,
    required this.idCategory,
    required this.model,
    required this.brand,
    required this.descProduct,
    required this.unitMeasurement,
    required this.quantity,
    required this.sell,
    required this.donation,
    required this.priceSell,
    required this.imageURL,
  });
}
