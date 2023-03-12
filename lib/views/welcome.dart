import 'package:flutter/material.dart';
import 'package:hornero_app/widgets/decoration.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.95,
        height: MediaQuery.of(context).size.width * 0.95,
        child: Stack(alignment: AlignmentDirectional.bottomEnd, children: [
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.3,
              child: Image.asset('assets/images/logo-nome.png')),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.90,
            height: MediaQuery.of(context).size.height * 0.02,
            child: LinearProgressIndicator(
              color: HorneroDecoration().getColor('orange'),
              backgroundColor: Colors.orange[200],
            ),
          )
        ]));
  }
}
