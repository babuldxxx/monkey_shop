import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monkey_shop/data/repository/user_repository.dart';
import 'package:monkey_shop/providers/auth_notifier.dart';
import "main_screen.dart";
import 'register_screen.dart';
import "../domain/models/user.dart";
import '../widgets/button_app.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  var loginController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Авторизация',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.brown,
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: loginController,
              decoration: InputDecoration(hintText: 'Логин'),
            ),
            SizedBox(height: 8),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Пароль',
                focusColor: Colors.brown,
              ),
            ),
            SizedBox(height: 24),

            authState.when(
              data: (user) {
                if (user != null) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainScreen(title: 'Главная'),
                      ),
                    );
                  });
                }
                return ButtonApp(onPressed: onLogin, text: 'Войти');
              },
              error: (Object error, StackTrace stackTrace) {
                return Column(
                  children: [
                    Text(
                      error.toString(),
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 16),
                    ButtonApp(onPressed: onLogin, text: 'Войти'),
                  ],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
            ),

            const SizedBox(height: 16,),

            GestureDetector(
              onTap: onRegister,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(),
                child: Text(
                  'Зарегистрироваться',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrangeAccent,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> onLogin() async {
    if (loginController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Заполните все поля')));
      return;
    }

    await ref
        .read(authProvider.notifier)
        .auth(loginController.text, passwordController.text);
  }

  void onRegister() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => RegisterScreen()));
  }
}
