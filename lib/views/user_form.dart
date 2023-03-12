import 'package:flutter/material.dart';
import 'package:hornero_app/models/user.dart';
import 'package:hornero_app/provider/user.dart';
import 'package:hornero_app/views/welcome.dart';
import 'package:hornero_app/widgets/header.dart';

import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

import '../widgets/decoration.dart';

class UserForm extends StatefulWidget {
  const UserForm({super.key});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _keyForm = GlobalKey<FormState>();
  //Cria uma chave para o campo Senha a fim de recuperar o valor e validar se as senhas conferem
  final _pwd1 = GlobalKey<FormFieldState>();
  final _pwd2 = GlobalKey<FormFieldState>();

  bool _isLoading = false;

  //String pwdValue = '';
  final maskFormatterCPF = MaskTextInputFormatter(
      mask: '###.###.###-##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  final Map<String, String> _formData = {};

  void _loadFormData(User user) {
    if (user.nome!.isNotEmpty) {
      _formData['id'] = user.id.toString();
      _formData['nome'] = user.nome!;
      _formData['email'] = user.email!;
      _formData['cpf'] = user.cpf!;
      _formData['password'] = user.senha!;
      _formData['password2'] = user.senha!;
    }
  }

  @override
  Widget build(BuildContext context) {
    //Somente executa o try se estiver tudo ok, se não tiver nenhum erro
    try {
      final user = ModalRoute.of(context)?.settings.arguments as User;
      _loadFormData(user);
      // ignore: empty_catches
    } catch (e) {
      _formData['id'] = 0.toString();
    }

    return Scaffold(
      body: _isLoading
          ? const WelcomeScreen()
          : SizedBox(
              height: MediaQuery.of(context).size.height * 0.95,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: const HeaderHornero(startWidget: true),
                  ),
                  Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.65,
                      padding: const EdgeInsets.all(20),
                      child: ListView(
                        children: [
                          Form(
                            key: _keyForm,
                            child: Column(
                              children: [
                                TextFormField(
                                  initialValue: _formData['nome'],
                                  decoration: InputDecoration(
                                    labelText: 'Nome',
                                    hintText: 'Nome Completo',
                                    prefixIcon: const Icon(Icons.person_add),
                                    prefixIconColor: HorneroDecoration()
                                        .getColor('blueGrey'),
                                    hintStyle: TextStyle(
                                        fontFamily: 'TangoSansbold',
                                        fontSize: 15,
                                        color: HorneroDecoration()
                                            .getColor('blueGrey')),
                                    enabledBorder:
                                        HorneroDecoration().myinputborder(),
                                    focusedBorder:
                                        HorneroDecoration().myfocusborder(),

                                    // hintStyle: TextStyle(color: Colors.pinkAccent)
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Nome inválido';
                                    }
                                  },
                                  //onSaved: (value) => _formData['nome'] = value!,
                                  onSaved: (value) {
                                    _formData['nome'] = value!;
                                  },
                                ),
                                const Padding(padding: EdgeInsets.all(5)),
                                TextFormField(
                                  initialValue: _formData['email'],
                                  decoration: InputDecoration(
                                    labelText: 'E-mail',
                                    hintText: 'email@email.com',
                                    prefixIcon: const Icon(Icons.email),
                                    prefixIconColor: HorneroDecoration()
                                        .getColor('blueGrey'),
                                    hintStyle: TextStyle(
                                        fontFamily: 'TangoSansbold',
                                        fontSize: 15,
                                        color: HorneroDecoration()
                                            .getColor('blueGrey')),
                                    enabledBorder:
                                        HorneroDecoration().myinputborder(),
                                    focusedBorder:
                                        HorneroDecoration().myfocusborder(),

                                    // hintStyle: TextStyle(color: Colors.pinkAccent)
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'E-mail inválido';
                                    } else if (!RegExp(r'^[\w-.\,]+@([\w$.])')
                                        .hasMatch(value)) {
                                      return 'Informe um e-mail válido';
                                    }
                                  },
                                  onSaved: (value) =>
                                      _formData['email'] = value!,
                                ),
                                const Padding(padding: EdgeInsets.all(5)),
                                TextFormField(
                                  initialValue: _formData['cpf'],
                                  inputFormatters: [maskFormatterCPF],
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    labelText: 'CPF',
                                    hintText: '000.000.000-00',
                                    prefixIcon:
                                        const Icon(Icons.import_contacts),
                                    prefixIconColor: HorneroDecoration()
                                        .getColor('blueGrey'),
                                    hintStyle: TextStyle(
                                        fontFamily: 'TangoSansbold',
                                        fontSize: 15,
                                        color: HorneroDecoration()
                                            .getColor('blueGrey')),
                                    enabledBorder:
                                        HorneroDecoration().myinputborder(),
                                    focusedBorder:
                                        HorneroDecoration().myfocusborder(),
                                    //hintStyle: TextStyle(color: Colors.pinkAccent),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'CPF inválido';
                                    }
                                  },
                                  onSaved: (value) => _formData['cpf'] = value!,
                                ),
                                const Padding(padding: EdgeInsets.all(5)),
                                TextFormField(
                                  initialValue: _formData['password'],
                                  key: _pwd1,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    labelText: 'Senha',
                                    hintText: 'Senha',
                                    prefixIcon: const Icon(Icons.key),
                                    prefixIconColor: HorneroDecoration()
                                        .getColor('blueGrey'),
                                    hintStyle: TextStyle(
                                        fontFamily: 'TangoSansbold',
                                        fontSize: 15,
                                        color: HorneroDecoration()
                                            .getColor('blueGrey')),
                                    enabledBorder:
                                        HorneroDecoration().myinputborder(),
                                    focusedBorder:
                                        HorneroDecoration().myfocusborder(),
                                    // hintStyle: TextStyle(color: Colors.pinkAccent)
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Senha Inválida';
                                    } else {}
                                  },
                                  onSaved: (value) =>
                                      _formData['password'] = value!,
                                ),
                                const Padding(padding: EdgeInsets.all(5)),
                                TextFormField(
                                  initialValue: _formData['password2'],
                                  key: _pwd2,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      labelText: 'Confirmação da Senha',
                                      hintText: 'Repita a Senha',
                                      prefixIcon: const Icon(Icons.key),
                                      prefixIconColor: HorneroDecoration()
                                          .getColor('blueGrey'),
                                      hintStyle: TextStyle(
                                          fontFamily: 'TangoSansbold',
                                          fontSize: 15,
                                          color: HorneroDecoration()
                                              .getColor('blueGrey')),
                                      enabledBorder:
                                          HorneroDecoration().myinputborder(),
                                      focusedBorder:
                                          HorneroDecoration().myfocusborder()),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Valor não permitido';
                                    } else if (_pwd1.currentState!.value !=
                                        value) {
                                      return 'Senhas não conferem ${_pwd1.currentState!.value} $value';
                                    }
                                  },
                                  onSaved: (value) =>
                                      _formData['password2'] = value!,
                                ),
                                Container(
                                  decoration: const BoxDecoration(),
                                  padding: const EdgeInsets.only(
                                      top: 50, bottom: 15),
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: HorneroDecoration()
                                        .myElevatedButtonStyle(),
                                    onPressed: () {
                                      final isValid =
                                          _keyForm.currentState?.validate();

                                      if (isValid!) {
                                        _keyForm.currentState?.save();
                                        setState(() {
                                          _isLoading = true;
                                        });
                                        UsersProvider user =
                                            Provider.of(context, listen: false);
                                        user
                                            .put(User(
                                                id: (_formData['id']
                                                    .toString()),

                                                //id: int.parse(_formData['id'].toString()),
                                                nome: _formData['nome']
                                                    .toString(),
                                                email: _formData['email']
                                                    .toString(),
                                                cpf:
                                                    _formData['cpf'].toString(),
                                                senha: _formData['password']
                                                    .toString()))
                                            .then((value) {
                                          setState(() {
                                            _isLoading = false;
                                          });
                                          if ((_formData['id']) != null) {
                                            // print(int.parse(_formData['id'].toString()));
                                          }
                                          Navigator.of(context).pop();
                                        });
                                      }
                                    },
                                    child: const Text('Enviar Solicitação'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
