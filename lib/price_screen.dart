import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'services/price_data.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String? selectedCurrency = 'USD';
  String? bitCoinPrice = '0.0';

  void retrieveCoinData() async {
    CoinModel coinModel = new CoinModel();
    var coinData =
        await coinModel.getCoinData('BTC', selectedCurrency.toString());
    updateUI(coinData);
  }

  @override
  void initState() {
    super.initState();
    retrieveCoinData();
  }

  void updateUI(dynamic coinData) {
    setState(() {
      if (coinData != null) {
        double? t = coinData['rate'];

        if (t != null) {
          bitCoinPrice = t.toStringAsFixed(2);
          print(bitCoinPrice);
        }
      }
    });
  }

  DropdownButton<String> getDropdownButton() {
    List<DropdownMenuItem<String>> menuItems = currenciesList.map((currency) {
      return DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
    }).toList();

    return DropdownButton<String>(
      value: selectedCurrency,
      items: menuItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          retrieveCoinData();
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];

    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }

    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        selectedCurrency = pickerItems[selectedIndex].data;
        retrieveCoinData();
      },
      children: pickerItems,
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
                  '1 BTC = ' +
                      bitCoinPrice.toString() +
                      ' ' +
                      selectedCurrency.toString(),
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
            child: Platform.isIOS ? iOSPicker() : getDropdownButton(),
          ),
        ],
      ),
    );
  }
}
