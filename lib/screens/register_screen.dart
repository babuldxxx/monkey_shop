import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monkey_shop/providers/auth_notifier.dart';
import '../domain/models/user.dart';
import '../widgets/button_app.dart';
import '../widgets/text_field_app.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  var loginController = TextEditingController();
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    if (authState.hasValue && authState.value != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Вы успешно зарегистрировались!'), backgroundColor: Colors.green,),
        );
      });
    }

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
              authState.when(
                data: (_) =>
                    ButtonApp(onPressed: register, text: 'Зарегистрироваться'),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) {
                  return Column(
                    children: [
                      Text(
                        error.toString(),
                        style: const TextStyle(color: Colors.red),
                      ),
                      const SizedBox(height: 16),
                      ButtonApp(
                        onPressed: register,
                        text: 'Зарегистрироваться',
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> register() async {
    formKey.currentState!.validate();

    if (nameController.text.isEmpty ||
        loginController.text.isEmpty ||
        passwordController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Поля введены неверно')));

      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Пароли не совпадают')));

      return;
    }

    final user = User.newUser(
      name: nameController.text,
      login: loginController.text,
      password: passwordController.text,
      role: 'user',
    );

    await ref.read(authProvider.notifier).register(user);
  }
}
