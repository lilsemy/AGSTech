import 'package:flutter/material.dart';

class BookingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      // scrollable
      children: [
        Text("Bookings", style: Theme.of(context).textTheme.headlineLarge),
      ],
    );
  }
}
