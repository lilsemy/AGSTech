import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:app_frontend/app_state.dart';
import 'package:app_frontend/authentication/login_page.dart';

import 'package:app_frontend/app_themes.dart';
import 'package:app_frontend/widgets/space_widgets.dart';

class RegistrationPage extends StatefulWidget {
  static const routeName = '/registration';

  RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final String apiUrl = "http://localhost:8080/api/auth/register";

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool obscurePassword = true;

  final _phoneNumberController = TextEditingController();
  final _dateOfBirthController = TextEditingController();
  final _licenseExpiryDateController = TextEditingController();
  final _streetController = TextEditingController();
  final _houseNumberController = TextEditingController();
  final _postalCodeController = TextEditingController();
  final _cityController = TextEditingController();
  final _countryController = TextEditingController();

  String result = "";

  String? _licenseClass;

  final List<String> _licenseClasses = [
    'AM',
    'A1',
    'A2',
    'A',
    'B',
    'BE',
    'C',
    'CE',
    'D',
    'DE',
  ];

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneNumberController.dispose();
    _dateOfBirthController.dispose();
    _licenseExpiryDateController.dispose();
    _streetController.dispose();
    _houseNumberController.dispose();
    _postalCodeController.dispose();
    _cityController.dispose();
    _countryController.dispose();

    super.dispose();
  }

  void toggleObscurePassword() {
    setState(() {
      obscurePassword = !obscurePassword;
    });
  }

  String formatDate(String date) {
    final parts = date.split('.');

    return '${parts[2]}-${parts[1]}-${parts[0]}';
  }

  Future<void> register() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    debugPrint(
      'Registrierung für ${_lastNameController.text} ${_firstNameController.text}',
    );

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: jsonEncode(<String, dynamic>{
          "firstName": _firstNameController.text,
          "lastName": _lastNameController.text,
          "email": _emailController.text,
          "password": _passwordController.text,
          "phoneNumber": _phoneNumberController.text,
          "dateOfBirth": formatDate(_dateOfBirthController.text),
          "licenseClass": _licenseClass,
          "licenseExpiryDate": formatDate(_licenseExpiryDateController.text),
          "street": _streetController.text,
          "houseNumber": _houseNumberController.text,
          "postalCode": _postalCodeController.text,
          "city": _cityController.text,
          "country": _countryController.text,
        }),
      );

      debugPrint('HTTP Status: ${response.statusCode}');
      debugPrint('Response: ${response.body}');

      // Nach dem async-Gap prüfen:
      if (!mounted) return;

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registrierung erfolgreich!')),
        );
        context.read<MyAppState>().login(_emailController.text);
      }
    } catch (e) {
      setState(() {
        result = "Error: $e";
      });
    }
  }

  Widget buildRequiredField({
    required BuildContext context,
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
  }) {
    final theme = Theme.of(context);
    final isPassword = controller == _passwordController;

    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isPassword ? obscurePassword : false,

      decoration: InputDecoration(
        label: RichText(
          text: TextSpan(
            text: '$label ',
            style: theme.textTheme.bodyLarge,
            children: const [
              TextSpan(
                text: '*',
                style: TextStyle(
                  color: AppColors.burgundy,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),

        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  obscurePassword ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.grey,
                ),
                onPressed: toggleObscurePassword,
              )
            : null,

        border: theme.inputDecorationTheme.border,
        enabledBorder: theme.inputDecorationTheme.enabledBorder,
        focusedBorder: theme.inputDecorationTheme.focusedBorder,

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.burgundy, width: 1.5),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.burgundy, width: 1.5),
        ),
      ),

      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "Bitte $label eingeben";
        }
        if (controller == _emailController && !validateEmail(value.trim())) {
          return "Bitte eine gültige E-Mail-Adresse eingeben";
        }
        if (controller == _postalCodeController &&
            _postalCodeController.text.length != 5) {
          return "Bitte eine gültige Postleitzahl eingeben";
        }
        return null;
      },
    );
  }

  bool validateEmail(String email) {
    RegExp emailPattern = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    bool isValidEmail = emailPattern.hasMatch(email);
    return isValidEmail;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUnfocus,
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 400),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset("assets/images/logo.png"),

                    SpaceWidgets.large,

                    Text(
                      'Registrierung',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),

                    SpaceWidgets.medium,

                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, LoginPage.routeName);
                      },
                      child: const Text('Schon registriert? Hier einloggen.'),
                    ),

                    SpaceWidgets.medium,

                    Text(
                      'Persönliche Daten',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),

                    SpaceWidgets.small,

                    // Vorname
                    buildRequiredField(
                      context: context,
                      controller: _firstNameController,
                      label: 'Vorname',
                    ),

                    SpaceWidgets.small,

                    // Nachname
                    buildRequiredField(
                      context: context,
                      controller: _lastNameController,
                      label: 'Nachname',
                    ),

                    SpaceWidgets.small,

                    // Geburtsdatum
                    buildRequiredField(
                      context: context,
                      controller: _dateOfBirthController,
                      label: 'Geburtsdatum (TT.MM.JJJJ)',
                      keyboardType: TextInputType.datetime,
                    ),

                    SpaceWidgets.small,

                    // Telefonnummer
                    buildRequiredField(
                      context: context,
                      controller: _phoneNumberController,
                      label: 'Telefonnummer',
                      keyboardType: TextInputType.phone,
                    ),

                    SpaceWidgets.medium,

                    Text(
                      'Adresse',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),

                    SpaceWidgets.small,

                    // Straße
                    buildRequiredField(
                      context: context,
                      controller: _streetController,
                      label: 'Straße',
                    ),

                    SpaceWidgets.small,

                    // Hausnummer
                    buildRequiredField(
                      context: context,
                      controller: _houseNumberController,
                      label: 'Hausnummer',
                    ),

                    SpaceWidgets.small,

                    // Postleitzahl
                    buildRequiredField(
                      context: context,
                      controller: _postalCodeController,
                      label: 'Postleitzahl',
                      keyboardType: TextInputType.number,
                    ),

                    SpaceWidgets.small,

                    // Stadt
                    buildRequiredField(
                      context: context,
                      controller: _cityController,
                      label: 'Stadt',
                    ),

                    SpaceWidgets.small,

                    // Land
                    buildRequiredField(
                      context: context,
                      controller: _countryController,
                      label: 'Land',
                    ),

                    SpaceWidgets.medium,

                    Text(
                      'Führerscheindaten',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),

                    SpaceWidgets.small,

                    // Führerscheinklasse
                    DropdownButtonFormField<String>(
                      initialValue: _licenseClass,
                      decoration: const InputDecoration(
                        labelText: 'Führerscheinklasse *',
                      ),
                      items: _licenseClasses.map((klasse) {
                        return DropdownMenuItem<String>(
                          value: klasse,
                          child: Text(klasse),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _licenseClass = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Bitte Führerscheinklasse auswählen';
                        }
                        return null;
                      },
                    ),

                    SpaceWidgets.small,

                    // Führerscheinablaufdatum
                    buildRequiredField(
                      context: context,
                      controller: _licenseExpiryDateController,
                      label: 'Führerscheinablaufdatum',
                      keyboardType: TextInputType.datetime,
                    ),

                    Text(
                      'Account',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),

                    SpaceWidgets.small,

                    // E-Mail
                    buildRequiredField(
                      context: context,
                      controller: _emailController,
                      label: 'E-Mail',
                      keyboardType: TextInputType.emailAddress,
                    ),

                    SpaceWidgets.small,

                    // Passwort
                    buildRequiredField(
                      context: context,
                      controller: _passwordController,
                      label: 'Passwort',
                    ),

                    SpaceWidgets.medium,

                    ElevatedButton(
                      onPressed: register,
                      child: Text('Registrieren'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
