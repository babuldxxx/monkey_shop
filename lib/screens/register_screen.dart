import 'package:flutter/material.dart';
import '../domain/models/user.dart';
import '../widgets/button_app.dart';
import '../widgets/text_field_app.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var loginController = TextEditingController();
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Создать аккаунт',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: const <Color>[
                Color.fromARGB(255, 80, 50, 20),
                Color.fromARGB(248, 222, 181, 158),
              ],
            ),
          ),
        ),
        elevation: 0,
      ),

      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.person_add_alt_1,
                size: 60,
                color: Color.fromARGB(248, 222, 181, 158),
              ),

              const SizedBox(height: 20),
              TextFieldApp(controller: nameController, hintText: 'Ваше имя'),

              const SizedBox(height: 16),
              TextFieldApp(
                controller: loginController,
                hintText: 'Придумайте логин',
              ),

              const SizedBox(height: 16),
              TextFieldApp(
                controller: passwordController,
                hintText: 'Пароль',
                isObscure: true,
              ),

              const SizedBox(height: 16),
              TextFieldApp(
                controller: confirmPasswordController,
                hintText: 'Повторите пароль',
                isObscure: true,
              ),

              const SizedBox(height: 30),
              ButtonApp(onPressed: register, text: 'Зарегистрироваться'),
            ],
          ),
        ),
      ),
    );
  }

  void register() {
    formKey.currentState!.validate();
    if (nameController.text.isEmpty ||
        loginController.text.isEmpty ||
        passwordController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Поля введены неверно')));
    } else if (loginController.text.length < 5 ||
        passwordController.text.length < 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Логин и пароль должны содержать больше 5 символов'),
        ),
      );
    } else if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Пароли не совпадают')));
    } else if (users.any((user) => user.login == loginController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Пользователь с таким логином уже существует')),
      );
    } else {
      var user = User(
        name: nameController.text,
        login: loginController.text,
        password: passwordController.text,
      );
      users.add(user);
      Navigator.pop(context);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Вы успешно зарегистрировались!')));
    }
  }
}
