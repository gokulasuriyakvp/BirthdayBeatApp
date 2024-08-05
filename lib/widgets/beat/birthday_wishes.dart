import 'package:flutter/material.dart';

class BirthdayWishesCard extends StatelessWidget {
  final String imageUrl;
  final String userImageUrl;
  final String connectionStatus;
  final int emojiCount;
  final String emojiCodes;
  final int replyCount;
  final String text;

  const BirthdayWishesCard({
    super.key,
    required this.imageUrl,
    required this.userImageUrl,
    required this.connectionStatus,
    required this.emojiCount,
    required this.emojiCodes,
    required this.replyCount,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 450,
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5,
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                imageUrl,
                fit: BoxFit.fill,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                userImageUrl == "" ? Icon(Icons.person_2): CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(userImageUrl),
                  backgroundColor: Colors.transparent,
                ),
                Text(text),
                Visibility(
                  child: Icon(Icons.person_add),
                  visible: connectionStatus == "NOT_CONNECTED",
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Text(emojiCodes),
                    SizedBox(width: 5),
                    Text('${emojiCount}'),
                  ],
                ),
                SizedBox(width: 20),
                Row(
                  children: [
                    Icon(Icons.comment),
                    SizedBox(width: 5),
                    Text('${replyCount} Replies'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
