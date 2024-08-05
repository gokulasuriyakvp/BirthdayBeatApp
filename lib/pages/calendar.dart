import 'package:flutter/material.dart';

class CalendarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
          'Calendar',
          style: TextStyle(color: Colors.purple),
        )),
      ),
      body: const Center(
        child: Text('Calendar Page'),
      ),
    );
  }
}
