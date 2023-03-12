import 'dart:convert';
import 'package:flutter/cupertino.dart';
import '../models/user.dart';
import 'package:http/http.dart' as http;

//Padrão observer ChangeNotifier
//Sempre que tiver uma mudança nesse MAP de usuários
//Os listeners serão notificados e a interface gráfica
//vai ser atualizada
//***** Precisa criar um método de atualizar os usuários **** update */
class UsersProvider with ChangeNotifier {
  final _baseUrl = 'https://hornero-app-db-default-rtdb.firebaseio.com';
  //final Map<String, User> _items = {...DUMMY_USERS};
  final Map<String, User> _items = {};

  List<User> get all {
    return [..._items.values];
  }

  void clearUsers() {
    _items.clear();
    notifyListeners();
  }

  User? getUserbyID(String idUser) {
    print(_items.length);
    for (var index = 0; index < _items.length; index++) {
      if (idUser == (_items.values.elementAt(index).id)) {
        User user = (_items.values.elementAt(index));
        return user;
      }
    }
    return null;
  }

  Future<void> loadUsers() async {
    final response = await http.get(Uri.parse('$_baseUrl/users.json'));

    Map<String, dynamic> dataUsers = jsonDecode(response.body);

    dataUsers.forEach((userId, userData) {
      _items.putIfAbsent(
        userId,
        () => User(
            email: userData['email'],
            cpf: userData['cpf'],
            nome: userData['nome'],
            senha: userData['senha'],
            id: userId),
      );
    });
  }

  int get count {
    return _items.length;
  }

  User byIndex(int i) {
    return _items.values.elementAt(i);
  }

  User? getUserbyCPF(String cpf) {
    for (var index = 0; index < _items.length; index++) {
      if (cpf == (_items.values.elementAt(index).cpf)) {
        User user = (_items.values.elementAt(index));
        return user;
      }
    }
    return null;
  }

  String lastId() {
    return _items.keys.last;
  }

  String? nomeUser(String cpf) {
    for (var index = 0; index < _items.length; index++) {
      if (cpf == (_items.values.elementAt(index).cpf)) {
        return (_items.values.elementAt(index).nome);
      }
    }
    return null;
  }

  String? emailUser(String cpf) {
    for (var index = 0; index < _items.length; index++) {
      if (cpf == (_items.values.elementAt(index).cpf)) {
        return (_items.values.elementAt(index).email);
      }
    }
    return null;
  }

  loginUser(String cpf, String password) {
    for (var index = 0; index < _items.length; index++) {
      if (cpf == (_items.values.elementAt(index).cpf) &&
          (password == (_items.values.elementAt(index).senha))) {
        return (_items.values.elementAt(index).nome);
      }
    }
  }

  Future<void> put(User user) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/users.json'),
      body: jsonEncode(
        {
          "nome": user.nome,
          "email": user.email,
          "cpf": user.cpf,
          "senha": user.senha,
        },
      ),
    );
    //response é o parametro que recebo do Future. Pode ser qualquer nome
    //Após receber a resposa eu executo o resto do código

    final id = jsonDecode(response.body)['name'];

    _items.putIfAbsent(
      id,
      () => User(
          email: user.email,
          cpf: user.cpf,
          nome: user.nome,
          senha: user.senha,
          id: id),
    );
    notifyListeners();
  }

  void remove(User user) {
    if (user.id != null) {
      _items.remove(user.id.toString());
    }
    notifyListeners();
  }
}
