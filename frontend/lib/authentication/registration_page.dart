import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class RegistrationPage extends StatefulWidget {
  static const routeName = '/registration';

  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
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

    return '${parts[2]}-${parts[1].padLeft(2, '0')}-${parts[0].padLeft(2, '0')}';
  }

  Future<void> register() async {
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
    } catch (e) {
      if (!mounted) return;

      setState(() {
        result = "Error: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Niebelungen-Rent'),
                  const Text('Registrierung'),

                  TextField(
                    controller: _firstNameController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(labelText: 'Vorname'),
                  ),

                  TextField(
                    controller: _lastNameController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(labelText: 'Nachname'),
                  ),

                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(labelText: 'E-Mail'),
                  ),

                  TextField(
                    controller: _passwordController,
                    obscureText: obscurePassword,
                    decoration: InputDecoration(
                      labelText: 'Passwort',
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: toggleObscurePassword,
                      ),
                    ),
                  ),
                  TextField(
                    controller: _phoneNumberController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'Telefonnummer',
                    ),
                  ),

                  TextField(
                    controller: _dateOfBirthController,
                    keyboardType: TextInputType.datetime,
                    decoration: const InputDecoration(
                      labelText: 'Geburtsdatum (1.1.2000)',
                    ),
                  ),

                  DropdownButtonFormField<String>(
                    initialValue: _licenseClass,
                    decoration: const InputDecoration(
                      labelText: 'Führerscheinklasse',
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
                  ),

                  TextField(
                    controller: _licenseExpiryDateController,
                    keyboardType: TextInputType.datetime,
                    decoration: const InputDecoration(
                      labelText: 'Führerscheinablaufdatum',
                    ),
                  ),

                  TextField(
                    controller: _streetController,
                    decoration: const InputDecoration(labelText: 'Straße'),
                  ),

                  TextField(
                    controller: _houseNumberController,
                    decoration: const InputDecoration(labelText: 'Hausnummer'),
                  ),

                  TextField(
                    controller: _postalCodeController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Postleitzahl',
                    ),
                  ),

                  TextField(
                    controller: _cityController,
                    decoration: const InputDecoration(labelText: 'Stadt'),
                  ),

                  TextField(
                    controller: _countryController,
                    decoration: const InputDecoration(labelText: 'Land'),
                  ),

                  ElevatedButton(
                    onPressed: register,
                    child: const Text('Registrieren'),
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
