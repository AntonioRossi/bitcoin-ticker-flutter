import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bitcoin_ticker/coin_data.dart';

class PriceScreen extends StatefulWidget {
  static List<DropdownMenuItem<String>> dropDownList() {
    List<DropdownMenuItem<String>> list = [];

    for (String currency in currenciesList) {
      var item = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );

      list.add(item);
    }
    return list;
  }

  static List<Text> cupertinoFiat() {
    List<Text> list = [];

    for (String currency in currenciesList) {
      var item = Text(currency);

      list.add(item);
    }
    return list;
  }

  final List<DropdownMenuItem<String>> dropDownChoices = dropDownList();
  final List<Text> cupertinoList = cupertinoFiat();

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String _selectedCurrency = 'USD';

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
                  '1 BTC = ? USD',
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
            child: CupertinoPicker(
              itemExtent: 32.0,
              onSelectedItemChanged: (itemSelected) {
                print(itemSelected);
              },
              children: widget.cupertinoList,
            ),
          ),
        ],
      ),
    );
  }
}

//DropdownButton<String>(
//value: _selectedCurrency,
//items: widget.dropDownChoices,
//onChanged: (value) {
//print(value);
//setState(() {
//_selectedCurrency = value;
//});
//},
//)
