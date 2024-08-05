import 'dart:convert';

class BirthdayWishes {
  final String id;
  final String postId;
  final String text;
  final String? imageUrl;
  final int emojiCount;
  final String emojiCodes;
  final String? connectionStatus;
  final String? userImageUrl;
  final int replyCount;

  BirthdayWishes({
    required this.id,
    required this.postId,
    required this.text,
    required this.imageUrl,
    required this.emojiCount,
    required this.emojiCodes,
    this.connectionStatus,
    this.userImageUrl,
    required this.replyCount,
  });

  factory BirthdayWishes.fromJson(Map<String, dynamic> json) {
    int replyCount = 0;
    String emojiCodes = "";
    dynamic emojiCountList = json['emojiCount'];
    final hexRegex = RegExp(r'^[A-F0-9]+$');

    if (emojiCountList != null) {
      for (final emoji in emojiCountList) {
        final code = emoji["code"];
        if (hexRegex.hasMatch(code) &&
            !emojiCodes
                .contains(String.fromCharCode(int.parse(code, radix: 16)))) {
          emojiCodes += String.fromCharCode(int.parse(code, radix: 16));
        }
      }
    }

    return BirthdayWishes(
      id: json['id'],
      postId: json['postId'],
      text: json['text'],
      imageUrl: json['imageUrl'],
      emojiCount: json['totalEmojiCount'],
      connectionStatus: json['connectionStatus'],
      userImageUrl: json['userInfo']?['imageUrl'] ?? "",
      replyCount: replyCount,
      emojiCodes: emojiCodes,
    );
  }
}

class BirthdayUser {
  final String id;
  final String firstName;
  final String lastName;
  final String mobileNumber;
  final String imageUrl;
  dynamic connectionStatus;

  BirthdayUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.mobileNumber,
    required this.imageUrl,
    required this.connectionStatus,
  });

  factory BirthdayUser.fromJson(Map<String, dynamic> json) {
    return BirthdayUser(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      mobileNumber: json['mobileNumber'],
      imageUrl: json['imageUrl'],
      connectionStatus: json['connectionStatus'],
    );
  }
}

class BirthdayBeat {
  final String id;
  final String caption;
  final DateTime createdAt;
  BirthdayUser? birthdayUser;
  List<BirthdayWishes>? birthdayWishes;

  BirthdayBeat({
    required this.id,
    required this.caption,
    required this.createdAt,
    this.birthdayUser,
    this.birthdayWishes,
  });

  factory BirthdayBeat.fromJson(Map<String, dynamic> json) {
    return BirthdayBeat(
      id: json['id'],
      caption: json['caption'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt']),
      birthdayUser:
          json["birthdayUserInfo"] == null || json["birthdayUserInfo"] == 'null'
              ? null
              : BirthdayUser.fromJson(json["birthdayUserInfo"]),
      birthdayWishes: json["wishes"] == null || json["wishes"] == 'null'
          ? null
          : json['wishes']
              .map<BirthdayWishes>((json) => BirthdayWishes.fromJson(json))
              .toList(),
    );
  }
}
