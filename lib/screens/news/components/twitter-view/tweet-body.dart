import 'package:flutter/material.dart';

class TweetBody extends StatelessWidget {
  TweetBody({required this.text, this.imageURL});

  final String text;
  final String? imageURL;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 8.0),
          child: Text(
            this.text,
            overflow: TextOverflow.clip,
          ),
        ),
        if (imageURL != null)
          Container(
            margin: const EdgeInsets.only(top: 6.0),
            child: Image(image: NetworkImage(imageURL!)),
          ),
      ],
    );
  }
}
