import 'dart:async';

import 'package:dart_twitter_api/twitter_api.dart';
import 'package:flutter/material.dart';
import 'package:ticker_tracker/screens/news/components/twitter-view/tweet-view.dart';
import 'package:ticker_tracker/screens/news/twitter-api.dart';
import 'package:ticker_tracker/shared/components/bottom-navigator.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class News extends StatefulWidget {
  @override
  _News createState() => _News();
}

class _News extends State<News> {
  TweetSearch? tweets;
  Timer? _debounce;
  SpeechToText _speechToText = SpeechToText();
  final TextEditingController _controller = TextEditingController();
  bool isListening = false;
  bool isSpeechEnabled = false;

  void initState() {
    super.initState();

    searchTweets(null).then((tweets) {
      setState(() {
        this.tweets = tweets;
      });
    });

    _speechToText.initialize().then((success) {
      setState(() {
        this.isSpeechEnabled = success;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigator("/news"),
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.news),
        ),
        body: Column(children: [
          Padding(
              padding: EdgeInsets.all(8),
              child: Row(children: [
                Expanded(
                    child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.searchText,
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (String query) {
                    if (_debounce?.isActive ?? false) {
                      _debounce!.cancel();
                    }
                    _debounce = Timer(const Duration(milliseconds: 500), () {
                      searchTweets(query).then((tweets) {
                        setState(() {
                          this.tweets = tweets;
                        });
                      });
                    });
                  },
                  onSubmitted: (value) {
                    setState(() {
                      // Searc
                    });
                  },
                )),
                if (isSpeechEnabled)
                  IconButton(
                    icon: const Icon(Icons.mic),
                    color: isListening
                        ? Colors.red
                        : Theme.of(context).primaryColor,
                    tooltip: AppLocalizations.of(context)!.voiceSearch,
                    onPressed: () {
                      setState(() {
                        isListening = true;
                        _speechToText.listen(
                          onResult: (result) {
                            print(result.toJson());
                            _controller.text = result.recognizedWords;
                            if (result.finalResult) {
                              searchTweets(_controller.text).then((tweets) {
                                setState(() {
                                  this.tweets = tweets;
                                  this.isListening = false;
                                });
                              });
                            }
                          },
                          listenFor: Duration(seconds: 5),
                          partialResults: true,
                          onSoundLevelChange: (level) {
                            print("Sound level: $level");
                          },
                          onDevice: true,
                          cancelOnError: true,
                        );
                      });
                    },
                  ),
              ])),
          Expanded(
              child: Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.white,
                  child: ListView.separated(
                    itemBuilder: (BuildContext context, int index) {
                      return TweetView(tweet: tweets!.statuses![index]);
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(
                      height: 10,
                    ),
                    itemCount: tweets?.statuses?.length ?? 0,
                  )))
        ]));
  }
}
