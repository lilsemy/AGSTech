import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:app_frontend/app_state.dart';
import 'package:app_frontend/customer/home_page.dart';
import 'package:app_frontend/customer/vehicles_page.dart';
import 'package:app_frontend/customer/bookings_page.dart';
import 'package:app_frontend/customer/settings_page.dart';

import 'package:app_frontend/app_themes.dart';

class MainNavigation extends StatefulWidget {
  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomePage(),
      VehiclesPage(),
      BookingsPage(),
      SettingsPage(),
    ];

    return Scaffold(
      backgroundColor: AppColors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 450) {
            // for small screens
            return Container(
              color: AppColors.white,
              child: Column(
                children: [
                  Expanded(child: pages[selectedIndex]),
                  SafeArea(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        BottomNavigationBar(
                          backgroundColor: AppColors.white,
                          items: const [
                            BottomNavigationBarItem(
                              icon: Icon(Icons.home),
                              label: 'Home',
                            ),
                            BottomNavigationBarItem(
                              icon: Icon(Icons.car_crash),
                              label: 'Fahrzeuge',
                            ),
                            BottomNavigationBarItem(
                              icon: Icon(Icons.car_rental),
                              label: 'Bookings',
                            ),
                            BottomNavigationBarItem(
                              icon: Icon(Icons.settings),
                              label: 'Profile',
                            ),
                          ],
                          currentIndex: selectedIndex,
                          onTap: (value) {
                            setState(() {
                              selectedIndex = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            // desktop view
            return Container(
              color: AppColors.white,
              child: Row(
                children: [
                  SafeArea(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                selectedIndex = 0;
                              });
                            },
                            child: Image.asset(
                              "assets/images/logo.png",
                              width: 100,
                            ),
                          ),
                        ),
                        Expanded(
                          child: NavigationRail(
                            backgroundColor: AppColors.white,
                            extended: constraints.maxWidth >= 600,
                            destinations: const [
                              NavigationRailDestination(
                                icon: Icon(Icons.home),
                                label: Text('Home'),
                              ),
                              NavigationRailDestination(
                                icon: Icon(Icons.car_crash),
                                label: Text('Fahrzeuge'),
                              ),
                              NavigationRailDestination(
                                icon: Icon(Icons.car_rental),
                                label: Text('Bookings'),
                              ),
                              NavigationRailDestination(
                                icon: Icon(Icons.settings),
                                label: Text('Settings'),
                              ),
                            ],
                            selectedIndex: selectedIndex,
                            onDestinationSelected: (value) {
                              setState(() {
                                selectedIndex = value;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton.icon(
                            onPressed: () {
                              context.read<MyAppState>().logout();
                            },
                            icon: const Icon(Icons.logout),
                            label: const Text('Logout'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(child: pages[selectedIndex]),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
