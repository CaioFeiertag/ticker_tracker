import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ticker_tracker/screens/home/components/ticker-info.dart';
import 'package:ticker_tracker/models/ticker.dart';
import 'package:ticker_tracker/screens/home/ticket-api.dart';
import 'package:ticker_tracker/screens/ticker/index.dart';
import 'package:ticker_tracker/services/Ticker-provider.dart' as Provider;

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Ticker> tickers = [];
  bool isSearching = false;
  final TextEditingController _controller = TextEditingController();
  List<Ticker> searchResults = [];
  Timer? _debounce;
  final tickerProvider = Provider.TickerProvider();

  void removeTicker(ticker) {
    tickerProvider.deleteTicker(ticker);
    tickers.remove(ticker);

    setState(() {});
  }

  void fetchTickers() {
    tickerProvider
        .listTickers()
        .then((tickers) => Future.wait(tickers.map((ticker) {
              return fetchTicker(ticker);
            })).then((updatedTickers) => {
                  setState(() {
                    this.tickers = updatedTickers;
                  })
                }));
  }

  @override
  void initState() {
    super.initState();

    fetchTickers();
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
                      Text("Meu portfólio"),
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

                    return InkWell(
                        child: Dismissible(
                            key: ValueKey<String>(ticker.code),
                            child: TickerInfo(ticker: ticker),
                            background: Container(color: Colors.red),
                            onDismissed: (direction) => removeTicker(ticker)),
                        onTap: () => Navigator.pushNamed(context, '/ticker',
                            arguments: TickerDetailsArguments(ticker)));
                  })),
          isSearching && _controller.text.length > 0
              ? Positioned(
                  left: 0,
                  top: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: new BoxDecoration(color: Colors.white),
                    child: ListView.builder(
                        itemCount: searchResults.length,
                        itemBuilder: (BuildContext context, int index) {
                          Ticker ticker = searchResults[index];

                          return GestureDetector(
                              child: TickerInfo(ticker: ticker),
                              onTap: () => Navigator.of(context)
                                  .pushNamed('/ticker',
                                      arguments: TickerDetailsArguments(ticker))
                                  .then((_) => {
                                        this.isSearching = false,
                                        fetchTickers()
                                      }));
                        }),
                  ))
              : SizedBox.shrink(),
        ]));
  }
}
