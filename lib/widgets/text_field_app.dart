import 'package:flutter/material.dart';

class TextFieldApp extends StatelessWidget {
  const TextFieldApp({
    super.key,
    this.controller,
    this.hintText,
    this.isObscure = false,
    this.onChanged,
  });

  final TextEditingController? controller;
  final String? hintText;
  final bool isObscure;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
  return TextFormField(
    controller: controller,
    obscureText: isObscure,
    onChanged: onChanged,

    style: const TextStyle(
      color: Colors.brown, 
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),

    decoration: InputDecoration(
      labelText: hintText,

      labelStyle: TextStyle(
        color: Colors.brown, 
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),

      floatingLabelStyle: const TextStyle(
        color: Color.fromARGB(248, 222, 181, 158), 
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),

      filled: true,
      fillColor: const Color.fromARGB(255, 255, 249, 240), 

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          width: 1.5,
          color: Colors.brown, 
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          width: 2,
          color: Color.fromARGB(248, 222, 181, 158), 
        ),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          width: 2,
          color: Colors.deepOrangeAccent, 
        ),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          width: 2,
          color: Colors.deepOrangeAccent, 
        ),
      ),
    ),
    
    validator: (value) {
      if (value!.isEmpty) return 'Поле не может быть пустым';
      return null;
    },
  );
  }
}
