//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdateRate(_ coinManager: CoinManager, coin: CoinData)
    func didFailWithError(error: Error)
}

struct CoinManager {
    var delegate: CoinManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "C9A35F8B-F0FE-49EF-976C-B1D5E09E2854"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCoinPrice(for currency: String) {
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        print(urlString)
        performRequest(with: urlString)
    }
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            //        2. Create a URLSession
            let session = URLSession(configuration: .default)
            //        3.Give the session a Task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    //                    delegate?.didFailWithError(error: error!)
                    print(error)
                    return
                }
                if let safeData = data {
                    let encodedData = String(data: safeData, encoding: String.Encoding.utf8)
                    //                    print(encodedData)
                    if let rate = parseJSON(safeData) {
                        self.delegate?.didUpdateRate(self, coin: rate)
                        //                        self.delegate?.didUpdateWeather(self, weather: weather)
                    } 
                }
            }
            //        4.Start the Task
            task.resume()
            
        }
    }
    
    func parseJSON(_ coinData: Data) -> CoinData? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: coinData)
            let rate = decodedData.rate
            let asset_id_quote = decodedData.asset_id_quote
            let exchangeRate = CoinData(rate: rate, asset_id_quote: asset_id_quote)
            //            return exchangeRate
            return exchangeRate
            //            print(exchangeRate.rate)
            //            print(exchangeRate.currency)
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
