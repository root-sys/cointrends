import 'dart:convert';

import 'package:http/http.dart' as http;

const APIKEY = 'F519D562-643F-40E4-83C2-BC5969CA904A';

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


 Future<dynamic> getPrice(String? curr) async{

   Map<String, String> cryptoprices = {};

   for(String name in cryptoList){
     var response = await http.get(Uri.parse("https://rest.coinapi.io/v1/exchangerate/$name/$curr"),headers: {'X-CoinAPI-Key': '$APIKEY'}) ;

     if(response.statusCode==200){
        var data = jsonDecode(response.body);
        double price = data['rate'];
        cryptoprices[name] = price.toStringAsFixed(0);
     }
     else{
       print(response.statusCode);
     }

   }

   return cryptoprices;



  }

}