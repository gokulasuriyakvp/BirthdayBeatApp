import 'package:flutter/material.dart';

class ConnectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          'Connect',
          style: TextStyle(color: Colors.purple),
        )),
      ),
      body: Center(
        child: Text('Connect Page'),
      ),
    );
  }
}
