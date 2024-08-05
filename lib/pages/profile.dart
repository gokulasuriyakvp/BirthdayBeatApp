import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          'Profile',
          style: TextStyle(color: Colors.purple),
        )),
      ),
      body: Center(
        child: Text('Profile Page'),
      ),
    );
  }
}
