import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_app/auth/auth_service.dart';
import 'package:test_app/ui/main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? login;
  String? password;
  bool isSave = false;

  final formKey = GlobalKey<FormState>();

  register() {
    final isValidated = formKey.currentState?.validate() ?? false;

    if (isValidated) {
      FocusScope.of(context).unfocus();
      formKey.currentState?.save();
      if (login == 'admin' && password == '123456') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen()),
        );
      } else {
        return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text(
                'Логин или Пароль не корректны',
                textAlign: TextAlign.center,
              ),
              titleTextStyle: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
              content: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Попробуйте еще раз'),
              ),
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'login',
                  prefixIcon: Icon(Icons.person_outline_rounded),
                  contentPadding: EdgeInsets.symmetric(vertical: 16.0),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    borderSide: BorderSide.none,
                  ),
                  counterText: '',
                ),
                maxLength: 8,
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return 'Имя пользователя не может быть пустым';
                  }
                  if (value.length < 4) {
                    return 'Имя пользователя не может быть меньше 4 символа';
                  }
                  return null;
                },
                onSaved: (value) {
                  login = value;
                },
              ),
              const SizedBox(height: 25.0),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'password',
                  prefixIcon: Icon(Icons.lock_outline_rounded),
                  contentPadding: EdgeInsets.symmetric(vertical: 16.0),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    borderSide: BorderSide.none,
                  ),
                  counterText: '',
                ),
                maxLength: 16,
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return 'Пароль не может быть пустым';
                  }
                  if (value.length < 6) {
                    return 'Пароль не может быть меньше 6 символа';
                  }
                  return null;
                },
                onSaved: (value) {
                  password = value;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Checkbox(
                    value: isSave,
                    onChanged: (value) async {
                      final SharedPreferences prefs = await AuthService.prefs;
                      await prefs.setBool('isSave', value!);
                      isSave = value;
                      setState(() {});
                    },
                  ),
                  const Text('Save'),
                ],
              ),
              ElevatedButton(
                onPressed: () => register(),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(vertical: 14.0),
                  ),
                ),
                child: const Center(
                  child: Text('Sign In', style: TextStyle(fontSize: 20.0)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
