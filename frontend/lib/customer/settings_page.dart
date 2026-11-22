import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:app_frontend/app_state.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      // scrollable
      children: [
        Text("Profile", style: Theme.of(context).textTheme.headlineLarge),
        ElevatedButton.icon(
          onPressed: () {
            context.read<MyAppState>().logout();
          },
          icon: Icon(Icons.logout),
          label: Text("logout"),
        ),
      ],
    );
  }
}
