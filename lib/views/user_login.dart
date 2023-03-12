import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hornero_app/provider/category.dart';
import 'package:hornero_app/provider/user.dart';
import 'package:hornero_app/views/welcome.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../routes/app_routes.dart';

class UserLogin extends StatefulWidget {
  const UserLogin({super.key});

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  bool _isLoading = false;

  @override
  void initState() {
    _isLoading = true;
    Provider.of<UsersProvider>(context, listen: false).loadUsers().then(
      (value) {
        setState(() {
          _isLoading = false;
        });
      },
    );

    super.initState();
  }

  final maskFormatterCPF = MaskTextInputFormatter(
      mask: '###.###.###-##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  final _keyForm = GlobalKey<FormState>();

  final _cpfForm = GlobalKey<FormFieldState>();

  final Map<String, String> _formData = {};
  final cpfField = TextEditingController();
  final passwordField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final UsersProvider users = Provider.of(context);

    return Scaffold(
        body: _isLoading
            ? const WelcomeScreen()
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 20, bottom: 10),
                      child: Image.asset(
                        'assets/images/logo-nome-bg.png',
                        scale: 5,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 20, bottom: 30),
                      child: Form(
                        key: _keyForm,
                        child: Column(
                          children: [
                            //FormField(builder: builder)
                            SizedBox(
                              width: 300,
                              height: 60,
                              child: TextFormField(
                                controller: cpfField,
                                key: _cpfForm,
                                inputFormatters: [maskFormatterCPF],
                                decoration: const InputDecoration(
                                  prefixIconColor: Colors.grey,
                                  prefixIcon: Icon(
                                    Icons.contact_page,
                                    color: Colors.grey,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 2, color: Colors.grey),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50))),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 2,
                                          color:
                                              Color.fromARGB(255, 29, 58, 107)),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50))),
                                  hintText: 'Informe o CPF',
                                ),
                                validator: (value) {
                                  if (value == "") {
                                    return "Invalido";
                                  }
                                  return null;
                                },
                                onSaved: (value) => _formData['cpf'] = value!,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 20, bottom: 5),
                              child: SizedBox(
                                width: 300,
                                height: 60,
                                child: TextFormField(
                                  controller: passwordField,

                                  //obscureText: true,
                                  //obscuringCharacter: '*',
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.key,
                                      color: Colors.grey,
                                    ),
                                    hintText: 'Informe a Senha',
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 2, color: Colors.grey),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50))),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 2,
                                            color: Color.fromARGB(
                                                255, 29, 58, 107)),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50))),
                                  ),

                                  onSaved: (value) =>
                                      _formData['password'] = value!,
                                ),
                              ),
                            ),
                            Container(
                              height: 150,
                              //decoration: const BoxDecoration(color: Colors.amber),
                              padding:
                                  const EdgeInsets.only(top: 40, bottom: 0),
                              child: Row(
                                //textDirection: TextDirection.rtl,
                                //crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Center(
                                    widthFactor: 1.0,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        FloatingActionButton(
                                          heroTag: 'btnNewPassword',
                                          onPressed: () {
                                            final isValid = _cpfForm
                                                .currentState
                                                ?.validate();
                                            if (isValid!) {
                                              // print('É valido vai form');
                                            }
                                          },
                                          hoverColor: const Color.fromARGB(
                                              255, 241, 143, 52),
                                          backgroundColor: const Color.fromARGB(
                                              255, 241, 143, 52),
                                          child: const Icon(Icons.key),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Text(
                                            'Nova Senha',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 29, 58, 107),
                                                fontFamily: 'TangoSans'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Center(
                                    widthFactor: 1.0,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        FloatingActionButton(
                                          heroTag: 'btnLogin',
                                          onPressed: () {
                                            final isValid = _keyForm
                                                .currentState
                                                ?.validate();
                                            print;
                                            if (isValid!) {
                                              _keyForm.currentState?.save();

                                              if (users.loginUser(
                                                      _formData['cpf']
                                                          .toString(),
                                                      _formData['password']
                                                          .toString()) !=
                                                  null) {
                                                final User user =
                                                    users.getUserbyCPF(
                                                        _formData['cpf']
                                                            .toString())!;

                                                cpfField.clear();
                                                passwordField.clear();

                                                Navigator.of(context).pushNamed(
                                                  arguments: user,
                                                  AppRoutes.HORNERO_MAIN,
                                                );
                                              }
                                            }
                                          },
                                          hoverColor: const Color.fromARGB(
                                              255, 241, 143, 52),
                                          backgroundColor: const Color.fromARGB(
                                              255, 29, 58, 107),
                                          child: const Icon(
                                              Icons.arrow_forward_ios_rounded),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Text(
                                            'Login',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 29, 58, 107),
                                                fontFamily: 'TangoSans'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Center(
                                    widthFactor: 1.0,
                                    child: Column(
                                      children: [
                                        FloatingActionButton(
                                          heroTag: 'btnNewUser',
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pushNamed(AppRoutes.USER_FORM);
                                          },
                                          hoverColor: const Color.fromARGB(
                                              255, 241, 143, 52),
                                          backgroundColor: const Color.fromARGB(
                                              255, 241, 143, 52),
                                          child: const Icon(Icons.person_add),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Text(
                                            'Novo Usuário',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 29, 58, 107),
                                                fontFamily: 'TangoSans'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Image.asset(
                      'assets/images/icon.png',
                      scale: 1,
                    ),
                  ],
                ),
              ));
  }
}
