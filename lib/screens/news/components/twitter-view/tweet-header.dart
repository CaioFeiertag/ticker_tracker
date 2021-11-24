import 'package:flutter/material.dart';

class TweetHeader extends StatelessWidget {
  TweetHeader(
      {required this.userName,
      required this.userId,
      required this.createdAt,
      required this.avatar});

  final String userName;
  final String userId;
  final String avatar;
  final DateTime createdAt;

  getTimeAgo() {
    Duration diff = DateTime.now().difference(createdAt);

    if (diff.inMinutes < 1) {
      return diff.inSeconds.toString() + "s";
    } else if (diff.inHours < 1) {
      return '${diff.inMinutes}m';
    } else if (diff.inDays < 1) {
      return '${diff.inHours}h';
    } else if (diff.inDays > 365) {
      return '${diff.inDays / 365} ano(s)';
    } else {
      return '${diff.inDays}d';
    }
  }

  @override
  Widget build(BuildContext context) {
    String timeAgo = getTimeAgo();

    print(createdAt);
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.all(10.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(this.avatar),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(right: 5.0),
          child: Text(
            this.userName,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Text(
          '@$userId · $timeAgo',
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
