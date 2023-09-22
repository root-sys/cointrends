import 'package:flutter/material.dart';
import 'coininfo.dart';
import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override

  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {





  int rate = 0;

   String? selectedCurr = 'USD';

   bool waiting = false;

   Map<String, String> cryptoprices = {};

void getRate() async{
  waiting = true;
  try {
    var data = await CoinData().getPrice(selectedCurr);
    waiting = false;
    setState(() {
      cryptoprices = data;
    });
  }
  catch(e){
    print(e);
  }
}

Column makeCards() {
  List<CryptoCard> CryptoCards = [];
  for(String crypto in cryptoList){
    CryptoCards.add(
      CryptoCard(rate: waiting? '?' : cryptoprices[crypto], selectedCurr: selectedCurr, currency: crypto),

    );
  }
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: CryptoCards,
  );
 }

   

Widget? getPlatform() {
  if (Platform.isAndroid) {



      List<DropdownMenuItem<String>>? dropdownitems = [];
      for (String i in currenciesList) {
        var newItem = DropdownMenuItem(child: Text(i,

        ),
          value: i,
        );
        dropdownitems.add(
            newItem
        );
      }
      return DropdownButton<String>(

        value: selectedCurr,
        items: dropdownitems,

        onChanged: (value) {
          setState(() {

            selectedCurr = value;
            getRate();
          });
        },
        style: TextStyle(
          color: Colors.deepOrange,
        ),
      );
    }


  else if (Platform.isIOS) {


      List<Text> currency = [];

      for (String i in currenciesList)

        currency.add(Text(i,
          style: TextStyle(
              color: Colors.deepOrange
          ),
        ));

      return CupertinoPicker(
        onSelectedItemChanged: (selectedIndex) {
       selectedCurr = currency[selectedIndex].toString();
        getRate();
        },

        backgroundColor: Color(0xFF253D2F),

        itemExtent: 40.0,
        children: currency,
      );
    }
  }

  @override

  void initState() {
      getRate();
    super.initState();
  }



  @override

  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("COINTRENDS 💸")),
        backgroundColor: Color(0xFF253D2F),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

        makeCards(),


          Container(
            color: Color(0xFF253D2F),
            height: 150.0,

            child: getPlatform(),

          alignment: Alignment.center,
          )
        ],
      ),
    );
  }
}

class CryptoCard extends StatelessWidget {
  const CryptoCard({
    super.key,
    required this.rate,
    required this.selectedCurr,
    required this.currency
  });

  final String? rate;
  final String? selectedCurr;
  final String currency;

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.fromLTRB(15.0, 25.0, 15.0, 0.0),
        child: Card(
          elevation: 5.0,
          color: Color(0xFFEBE9E2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
          ),
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Text("1 $currency = $rate $selectedCurr",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18.0,
                color: Color(0xFF253D2F)
              ),
              textAlign: TextAlign.center,
            ),

          ),

        ),
    );
  }
}

