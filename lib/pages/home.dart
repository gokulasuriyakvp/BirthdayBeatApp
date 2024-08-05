import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          'Home',
          style: TextStyle(color: Colors.purple),
        )),
      ),
      body: Center(
        child: Text('Home Page'),
      ),
    );
  }
}
