import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'package:app_frontend/app_state.dart';
import 'package:app_frontend/authentication/registration_page.dart';

import 'package:app_frontend/widgets/space_widgets.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/login';

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final String apiUrl = "http://localhost:8080/api/auth/login";
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool obscurePassword = true;

  String result = "";

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void toggleObscurePassword() {
    setState(() {
      obscurePassword = !obscurePassword;
    });
  }

  void login() {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isNotEmpty && password.isNotEmpty) {
      context.read<MyAppState>().login(email);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bitte E-Mail und Passwort eingeben.')),
      );
    }

    // Future<void> login() async {
    //   debugPrint('Login für ${_emailController.text}');

    //   try {
    //     final response = await http.post(
    //       Uri.parse(apiUrl),
    //       headers: <String, String>{
    //         "Content-Type": "application/json; charset=UTF-8",
    //       },
    //       body: jsonEncode(<String, dynamic>{
    //         "email": email,
    //         "password": password,
    //       }),
    //     );

    //     debugPrint('HTTP Status: ${response.statusCode}');
    //     debugPrint('Response: ${response.body}');

    //     if (!mounted) return;

    //     if (response.statusCode == 200) {
    //       context.read<MyAppState>().login(email);
    //     } else {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       const SnackBar(content: Text('Ungültige E-Mail oder Passwort.')),
    //     );
    // }
    //   } catch (e) {
    //     setState(() {
    //       result = "Error: $e";
    //     });
    //   }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 100,
                      fit: BoxFit.contain,
                    ),
                  ),

                  SpaceWidgets.large,

                  Text(
                    'Willkommen zurück',
                    style: theme.textTheme.headlineLarge,
                    textAlign: TextAlign.center,
                  ),

                  SpaceWidgets.small,

                  Text(
                    'Bitte melde dich mit deinem Konto an.',
                    style: theme.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),

                  SpaceWidgets.large,

                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'E-Mail',
                      hintText: 'E-Mail-Adresse eingeben',
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                  ),

                  SpaceWidgets.medium,

                  TextField(
                    controller: _passwordController,
                    obscureText: obscurePassword,
                    decoration: InputDecoration(
                      labelText: 'Passwort',
                      hintText: 'Passwort eingeben',
                      prefixIcon: Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscurePassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                        onPressed: toggleObscurePassword,
                      ),
                    ),
                  ),

                  SpaceWidgets.large,

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: login,
                      child: Text('Login'),
                    ),
                  ),

                  SpaceWidgets.medium,

                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RegistrationPage.routeName);
                    },
                    child: const Text('Noch kein Konto? Konto anlegen'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
