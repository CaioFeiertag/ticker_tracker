import 'package:dart_twitter_api/twitter_api.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final twitterApi = TwitterApi(
  client: TwitterClient(
      consumerKey: dotenv.get('TWITTER_CONSUMER_KEY'),
      consumerSecret: dotenv.get('TWITTER_CONSUMER_SECRET'),
      token: dotenv.get('TWITTER_BEARER_TOKEN'),
      secret: dotenv.get('TWITTER_BEARER_SECRET')),
);

Future<TweetSearch> searchTweets(String? searchText) async {
  String q =
      searchText != null ? searchText : 'b3 OR bolsa de valores OR economia';
  return twitterApi.tweetSearchService
      .searchTweets(q: q, count: 15, lang: 'pt', resultType: 'popular');
}
