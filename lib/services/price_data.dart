import '../CoinAPIKey.dart';
import 'networking.dart';

String apiKey = CoinAPIKey.getAPIkey();
const baseCoinAPIURL = 'https://rest.coinapi.io/v1/exchangerate/';

class CoinModel {
  Future<dynamic> getCoinData(String crypto, String fiat) async {
    NetworkHelper networkHelper =
        NetworkHelper('$baseCoinAPIURL$crypto/$fiat?apikey=$apiKey');

    var coinData = await networkHelper.getData();
    return coinData;
  }
}
