# Adding new token
The JSON schema for the tokens includes: address, name, decimals, symbol, logoURI, official homepage, MarketCap link, existing Markets.

Follow the steps below to add a new token：
1) Fork this repo.
2) change the JSON file `tokenlist.json`, adding such as: (PLEASE DO NOT REMOVE EXISITING TOKENS)
```
{
      "address": "TGz8gG7rn5n129Jci5AvABaEHHJCamLr4B",
      "symbol": "USDT",
      "name": "TETHER TRON USD",
      "decimals": 18,
      "logoURI": "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAQAAAAEACAYAAABccqhmAACTpElEQVR4nOy9d7xlx1Xn+11Ve+8Tbu...
",
      "homepage": "https://tronscan.org/TGz8gG7rn5n129Jci5AvABaEHHJCamLr4B",
      "MarketCapLink": "https://coinmarketcap.com/currencies/tethertronusd/",
      "existingMarkets": [
          {
              "source": "Binance",
              "pairs": [
                  "WIN/USDT",
                  "WIN/BUSD",
                  "WIN/BNB",
                  "WIN/USDC"
              ]
          },
          {
              "source": "Poloniex",
              "pairs": [
                  "WIN/USDT"
              ]
          },
          {
              "source": "KuCoin",
              "pairs": [
                  "WIN/USDT"
              ]
          }
    ]
}
```
* `address`[Required]: TGz8gG7rn5n129Jci5AvABaEHHJCamLr4B
* `symbol`[Required]: USDT.
* `name`[Required]: Tether tron usd.
* `logoURI`[Required]: data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAQAAAAEACAYAAABccqhmAACTpElEQVR4nOy9d7xlx1Xn+11Ve+8Tbu...

* `homepage`[Required]: the home page of your token.
* `MarketCapLink`[Optional]: the coinmarketcap or coingecko link for your token.
* `existingMarkets`[Required]: WEB3.
3) Submit PR with the changed JSON file.


