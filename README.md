# bitcoin_ticker

An app to view the latest Bitcoin price in various fiat currencies.

If you wish to clone this repo you will need to obtain an API key from https://www.coinapi.io

Add a file CoinAPIKey.dart to the lib folder and insert the code as follows, relplacing the key string with your API key. This file has been omitted from the repo for obvious reasons.

```
class CoinAPIKey {
  static String key = 'INSERT-YOUR-API-KEY-HERE';

  static String getAPIkey() {
    return key;
  }
}
```