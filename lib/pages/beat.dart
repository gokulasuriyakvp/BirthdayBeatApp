import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:task_app/model/birthday_beat.dart';
import 'package:task_app/services/birthday_beat.dart';
import 'package:task_app/widgets/beat/birthday_feed.dart';

class BeatPage extends StatefulWidget {
  @override
  State<BeatPage> createState() => _BeatPageState();
}

class _BeatPageState extends State<BeatPage> {
  late Future<List<BirthdayBeat>> futureBirthdayBeats;
  BirthdayBeatService birthdayBeatService = BirthdayBeatService();

  @override
  void initState() {
    super.initState();
    futureBirthdayBeats = birthdayBeatService.fetchBirthdayBeats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
              'Beat',
              style: TextStyle(color: Colors.purple),
            )),
      ),
      body: FutureBuilder<List<BirthdayBeat>>(
        future: futureBirthdayBeats,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return BirthdayFeed(birthdayBeat: snapshot.data![index]);
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
