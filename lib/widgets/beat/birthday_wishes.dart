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
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                userImageUrl == "" ? Icon(Icons.person_2,): CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(userImageUrl),
                  backgroundColor: Colors.transparent,
                ),
                SizedBox(height: 18,),
                Text(text,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                Visibility(
                  child: Icon(Icons.person_add,color: Colors.blue,),
                  visible: connectionStatus == "NOT_CONNECTED",
                )
              ],
            ),
            SizedBox(height: 18,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Text(emojiCodes),
                    SizedBox(width: 8),
                    Text('${emojiCount}',style: TextStyle(color: Colors.blue),),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Icon(Icons.comment,color: Colors.blue,),
                    SizedBox(width: 5),
                    Text('${replyCount} Replies',style:TextStyle(color: Colors.blue),),
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
