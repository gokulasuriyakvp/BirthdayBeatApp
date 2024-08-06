import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_app/widgets/beat/birthday_wishes.dart';
import '../../model/birthday_beat.dart';

class BirthdayFeed extends StatefulWidget {
  final BirthdayBeat birthdayBeat;

  BirthdayFeed({required this.birthdayBeat});

  @override
  State<BirthdayFeed> createState() => _BirthdayFeedState();
}

class _BirthdayFeedState extends State<BirthdayFeed> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF9E2AA7), Color(0xFF223347)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: ListTile(
              leading: widget.birthdayBeat.birthdayUser == null
                  ? Icon(Icons.person)
                  : CircleAvatar(
                      backgroundImage: NetworkImage(
                          widget.birthdayBeat.birthdayUser?.imageUrl ?? ""),
                    ),
              title: Text(
                (widget.birthdayBeat.birthdayUser?.firstName ?? "") + "'s Birthday Beat",
                style: TextStyle(color: Colors.white,fontSize: 20),
              ),
              subtitle: Text(
                '${DateFormat('MMM dd, yyyy').format(widget.birthdayBeat.createdAt)} | ${widget.birthdayBeat.birthdayWishes?.length ?? 0} peoples posted',
                style: TextStyle(color: Colors.white70,fontSize: 15),
              ),
              trailing: CircleAvatar(
                backgroundImage: AssetImage('assets/images/Button 3.png'), // Replace with your image asset
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: widget.birthdayBeat.birthdayWishes
                      ?.map<Widget>(
                        (BirthdayWishes birthdayWishes) => BirthdayWishesCard(
                          imageUrl: birthdayWishes.imageUrl ?? "",
                          connectionStatus:
                              birthdayWishes.connectionStatus ?? "",
                          emojiCodes: birthdayWishes.emojiCodes,
                          emojiCount: birthdayWishes.emojiCount,
                          replyCount: birthdayWishes.replyCount,
                          text: birthdayWishes.text,
                          userImageUrl: birthdayWishes.userImageUrl ?? "",
                        ),
                      )
                      .toList() ??
                  <Widget>[Container()],
            ),
          ),
          Visibility(
            child: Row(
              children: [
                Icon(Icons.person_add,size: 25,),
                Text(
                  'Connect with ${widget.birthdayBeat.birthdayUser?.firstName ?? ""} to comment',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            visible: widget.birthdayBeat.birthdayUser != null &&
                (widget.birthdayBeat.birthdayUser?.connectionStatus ==
                        "NOT_CONNECTED" ||
                    widget.birthdayBeat.birthdayUser?.connectionStatus == null),
          ),
        ],
      ),
    );
  }
}
