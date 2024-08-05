import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:task_app/model/birthday_beat.dart';

const AUTHORIZATION =
    "Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxMjYzODI4MDE1MDE4OTcxMTM2IiwiZXhwIjoxNzM1Mzg0Njk0LCJ0b2tlblR5cGUiOiJhY2Nlc3NUb2tlbiIsImlhdCI6MTcyMjQyNDY5NH0.W5B7_aMhKK2VJiRgqO7IIsGa8vG3554xmAs8xbH6eYM";

class BirthdayBeatService {
  List<BirthdayBeat> parseBirthdayBeats(String responseBody) {
    final Map<String, dynamic> parsed = jsonDecode(responseBody);
    return parsed["results"]
        .map<BirthdayBeat>((json) => BirthdayBeat.fromJson(json))
        .toList();
  }

  Future<List<BirthdayBeat>> fetchBirthdayBeats() async {
    List<BirthdayBeat> birthdayBeatList = [];
    final response = await http.post(
        Uri.parse('http://qa.birthdaybeat.ai:80/birthdaybeat/feed/list'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": AUTHORIZATION
        },
        body: jsonEncode({
          "detailedInfo": true,
          "pagination": {"size": 10, "page": 0}
        }));

    if (response.statusCode == 200) {
      final Map<String, dynamic> parsed = jsonDecode((response.body));
      for (final result in parsed["birthdayPosts"]["results"]) {
        var birthdayBeatsDetail = await this.fetchBirthdayBeatsDetail(result["id"]);
        birthdayBeatList = birthdayBeatList + birthdayBeatsDetail;
      }
    } else {
      throw Exception('Failed to load birthday beats');
    }

    return birthdayBeatList;
  }

  Future<List<BirthdayBeat>> fetchBirthdayBeatsDetail(String postId) async {
    final response = await http.post(
        Uri.parse(
            'http://qa.birthdaybeat.ai:80/birthdaybeat/feedPostMap/beatList'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": AUTHORIZATION
        },
        body: jsonEncode({
          "pagination": {"size": 10, "page": 0},
          "filter": {"postId": postId},
          "detailedInfo": true
        }));

    if (response.statusCode == 200) {
      return this.parseBirthdayBeats(response.body);
    } else {
      throw Exception('Failed to load birthday beats');
    }
  }
}
