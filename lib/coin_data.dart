import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

const String baseUrl = 'https://rest.coinapi.io/v1';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  // https://rest.coinapi.io/v1/exchangerate/BTC/USD

  Future<dynamic> exchangeRate(String coin1, String coin2) async {
    var apiKey = DotEnv().env['API_KEY'];
    print('we have a key $apiKey');
    var headers = {'X-CoinAPI-Key': apiKey};
    print('exchange rate called');

    String request = '$baseUrl/exchangerate/$coin1/$coin2';
    http.Response response = await http.get(request, headers: headers);

    if (response.statusCode == 200) {
      dynamic decodedData = convert.jsonDecode(response.body);
      String rate = decodedData['rate'].toStringAsFixed(2);
      print('got rate $rate data from api');
      return rate;
    } else {
      print('got null response from api');
      return 'null';
    }
  }
}
