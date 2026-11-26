import 'package:app_frontend/customer/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:app_frontend/app_state.dart';
import 'package:app_frontend/authentication/login_page.dart';
import 'package:app_frontend/authentication/registration_page.dart';
import 'package:app_frontend/customer/main_navigation.dart';
import 'package:app_frontend/customer/vehicle_details.dart';

import 'package:app_frontend/app_themes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Nibelungen-Rent',
        theme: AppTheme.customer,
        routes: {
          RegistrationPage.routeName: (context) => RegistrationPage(),
          LoginPage.routeName: (context) => LoginPage(),
          HomePage.routeName: (context) => HomePage(),
          VehicleDetails.routeName: (context) {
            final vin = ModalRoute.of(context)!.settings.arguments as String;

            return VehicleDetails(vin: vin);
          },
        },
        home: Consumer<MyAppState>(
          builder: (context, appState, child) {
            return appState.isLoggedIn ? MainNavigation() : LoginPage();
          },
        ),
      ),
    );
  }
}
