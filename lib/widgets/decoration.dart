import 'package:flutter/material.dart';

class HorneroDecoration {
  Color? getColor(color) {
    if (color == 'blue') {
      return const Color.fromARGB(255, 29, 58, 107);
    } else if (color == 'orange') {
      return const Color.fromARGB(255, 241, 143, 52);
    } else if (color == 'blueGrey') {
      return const Color.fromARGB(255, 96, 125, 139);
    } else if (color == 'grey') {
      return const Color.fromARGB(255, 211, 214, 215);
    }
    return null;
  }

  Color colorSale(double? vv) {
    if (vv == 0) {
      return const Color.fromARGB(255, 241, 143, 52);
    } else {
      return const Color.fromARGB(255, 112, 211, 154);
    }
  }

  OutlineInputBorder myinputborder() {
    //return type is OutlineInputBorder
    return OutlineInputBorder(
        //Outline border type for TextFeild
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          color: HorneroDecoration().getColor('grey')!,
          width: 3,
        ));
  }

  OutlineInputBorder myfocusborder() {
    return OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          color: HorneroDecoration().getColor('blue')!,
          width: 3,
        ));
  }

  ButtonStyle myElevatedButtonStyle() {
    return ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
            HorneroDecoration().getColor('blue')!),
        textStyle: MaterialStateProperty.all<TextStyle>(
            const TextStyle(fontFamily: 'TangoSans', fontSize: 17)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(50)),
        )));
  }
}
