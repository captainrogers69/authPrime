import 'package:flutter/material.dart';

class RoundedTextField extends StatelessWidget {
  const RoundedTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.secureIt,
    required this.icon,
    required this.keyboardType,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final bool secureIt;
  final Icon icon;
  final dynamic keyboardType;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: secureIt,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          prefixIcon: icon,
          // color: Theme.of(context).textTheme.bodyText2!.color),
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 15,
            // color: Theme.of(context).textTheme.bodyText2!.color,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              // color: Theme.of(context).backgroundColor,
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: Colors.black, //0xffF14C37
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}
