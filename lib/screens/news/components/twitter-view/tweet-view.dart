import 'package:dart_twitter_api/twitter_api.dart';
import 'package:flutter/material.dart';
import 'package:ticker_tracker/screens/news/components/twitter-view/tweet-body.dart';
import 'package:ticker_tracker/screens/news/components/twitter-view/tweet-header.dart';

class TweetView extends StatelessWidget {
  final Tweet tweet;

  TweetView({
    Key? key,
    required this.tweet,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    tweet.entities?.media?.forEach((media) {
      print(media.mediaUrl);
    });
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TweetHeader(
            userName: tweet.user!.name!,
            userId: tweet.user!.screenName!,
            createdAt: tweet.createdAt!,
            avatar: tweet.user!.profileImageUrlHttps!,
          ),
          TweetBody(
              text: tweet.text ?? tweet.fullText ?? '',
              imageURL: tweet.entities?.media?.first?.mediaUrl),
        ],
      ),
    );
  }
}
