import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  CustomFormField(
      {Key? key,
      required this.prefix,
      this.validator,
      required this.labelText,
      required this.suffixPressed,
      required this.textInputType,
      this.onTap,
      required this.controller, this.isClickable=true})
      : super(key: key);

  TextInputType textInputType;
  GlobalKey formKey = GlobalKey<FormState>();
  TextEditingController controller;
  Widget prefix;
  Function suffixPressed;
  void Function(String)? onChanged;

  String labelText;
  String? Function(String?)? validator;
  void Function()? onTap;
 bool  isClickable;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled:isClickable  ,
      onChanged: onChanged,
      controller: controller,
      decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: prefix,
          border: OutlineInputBorder()),
      onTap: onTap,
      keyboardType: textInputType,
      validator: validator,

      /* (value) {
        if (value == null && value!.isEmpty) {
          return 'please enter some inputs ';
        }
        return null;
       },*/
    );
  }
}
