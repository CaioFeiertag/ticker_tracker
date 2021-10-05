import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ticker_tracker/screens/home/components/ticker-info.dart';
import 'package:ticker_tracker/screens/home/ticker.dart';
import 'package:ticker_tracker/screens/home/ticketApi.dart';
import 'package:ticker_tracker/screens/ticker-details/index.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Ticker> tickers = mostValuableTickers;
  bool isSearching = false;
  final TextEditingController _controller = TextEditingController();
  List<Ticker> searchResults = [];
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    Future.wait(tickers.map((ticker) {
      return fetchTicker(ticker);
    })).then((updatedTickers) => {setState(() {})});
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: isSearching
                  ? [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        tooltip: 'Voltar',
                        onPressed: () {
                          setState(() {
                            isSearching = false;
                          });
                        },
                      ),
                      Expanded(
                          child: TextField(
                              controller: _controller,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintStyle: TextStyle(color: Colors.white70),
                                hintText: 'Buscar',
                                border: InputBorder.none,
                              ),
                              onSubmitted: (value) {
                                setState(() {
                                  // Searc
                                });
                              },
                              onChanged: (String query) {
                                if (_debounce?.isActive ?? false) {
                                  _debounce!.cancel();
                                }
                                _debounce = Timer(
                                    const Duration(milliseconds: 500), () {
                                  searchTicker(query).then((tickers) {
                                    setState(() {
                                      searchResults = tickers;
                                    });
                                  });
                                });
                              })),
                    ]
                  : [
                      Text("Meu portifólio"),
                      Spacer(),
                      IconButton(
                        icon: const Icon(Icons.search),
                        tooltip: 'Pressione para começar a pesquisar',
                        onPressed: () {
                          setState(() {
                            isSearching = true;
                          });
                        },
                      ),
                    ]),
        ),
        body: Stack(children: [
          Expanded(
              child: ListView.builder(
                  itemCount: tickers.length,
                  itemBuilder: (BuildContext context, int index) {
                    Ticker ticker = tickers[index];

                    return GestureDetector(
                        child: TickerInfo(ticker: ticker),
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    TickerDetails(ticker: ticker))));
                  })),
          isSearching && _controller.text.length > 0
              ? Positioned(
                  left: 0,
                  top: 0,
                  child: new Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: new BoxDecoration(color: Colors.white),
                    child: ListView.builder(
                        itemCount: searchResults.length,
                        itemBuilder: (BuildContext context, int index) {
                          Ticker ticker = searchResults[index];

                          return GestureDetector(
                              child: TickerInfo(ticker: ticker),
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          TickerDetails(ticker: ticker))));
                        }),
                  ))
              : SizedBox.shrink(),
        ]));
  }
}
