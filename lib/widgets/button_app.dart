import 'package:flutter/material.dart';

class ButtonApp extends StatelessWidget{
  const ButtonApp({super.key, this.onPressed, required this.text});

  final VoidCallback? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color.fromARGB(248, 222, 181, 158), 
      foregroundColor: Colors.brown, 
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 18),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), 
        side: const BorderSide(
          color: Colors.brown, 
          width: 2,
        ),
      ),
      elevation: 5,
      shadowColor: Colors.brown,
    ),
    onPressed: onPressed, 
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.brown, 
        letterSpacing: 1.2,
      ),
    ),
  );
  }
}