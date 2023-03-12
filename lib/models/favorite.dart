import 'package:hornero_app/models/sale.dart';
import 'package:hornero_app/models/user.dart';

class Favorite {
  User? user;
  Sale? sale;

  Favorite(this.user, this.sale);
}
