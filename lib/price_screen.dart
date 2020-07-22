import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:bitcoin_ticker/coin_data.dart';

class PriceScreen extends StatefulWidget {
  final String initialRate;
  final CoinData coinData;

  @override
  _PriceScreenState createState() => _PriceScreenState();

  PriceScreen({this.initialRate, this.coinData});
}

class _PriceScreenState extends State<PriceScreen> {
  String _selectedCurrency = 'USD';
  String _selectedCrypto = 'BTC';
  CoinData coinData;
  String rate;

  @override
  void initState() {
    super.initState();
    updateUI();
  }

  void updateUI() {
    setState(() {
      rate = widget.initialRate;
      coinData = widget.coinData;
    });
  }

  DropdownButton dropDownList() {
    List<DropdownMenuItem<String>> list = [];

    for (String currency in currenciesList) {
      var item = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );

      list.add(item);
    }

    return DropdownButton<String>(
      value: _selectedCurrency,
      items: list,
      onChanged: (value) async {
        String newRate = await coinData.exchangeRate(_selectedCrypto, value);
        setState(
          () {
            rate = newRate;
            _selectedCurrency = value;
            print('rate we have: $rate');
          },
        );
      },
    );
  }

  CupertinoPicker cupertinoFiat() {
    List<Text> list = [];

    for (String currency in currenciesList) {
      var item = Text(currency);

      list.add(item);
    }

    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (itemSelected) async {
        String value = itemSelected.toString();
        var newRate = await coinData.exchangeRate(_selectedCrypto, value);
        setState(() {
          rate = newRate;
          _selectedCurrency = value;
        });
      },
      children: list,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 $_selectedCrypto = $rate $_selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? cupertinoFiat() : dropDownList(),
          ),
        ],
      ),
    );
  }
}
