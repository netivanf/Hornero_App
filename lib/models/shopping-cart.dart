import 'sale.dart';
import 'user.dart';

class ShoppingCart {
  final String? id;
  final User? user;
  final Sale? sale;
  final double? quantity;
  double? _amount;

  ShoppingCart({
    required this.id,
    required this.user,
    required this.sale,
    required this.quantity,
  });

  double get amount {
    return _amount = (quantity! * sale!.priceSell);
  }
}
