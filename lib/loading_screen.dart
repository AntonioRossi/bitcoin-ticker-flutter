import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:bitcoin_ticker/coin_data.dart';
import 'package:bitcoin_ticker/price_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  final spinkit = SpinKitDoubleBounce(
    color: Colors.black,
    size: 150.0,
  );

  void getDefaultRate() async {
    CoinData coinData = CoinData();
    var initialRate = await coinData.exchangeRate('BTC', 'UDS');
    print(initialRate);
    print('got default rate $initialRate');

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return PriceScreen(
            initialRate: initialRate,
            coinData: coinData,
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      getDefaultRate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: spinkit,
      ),
    );
  }
}
