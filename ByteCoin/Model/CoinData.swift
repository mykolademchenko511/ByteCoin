//
//  CoinData.swift
//  ByteCoin
//
//  Created by User on 11/22/22.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation

struct CoinData: Codable {
    let rate: Double
    let asset_id_quote: String
    var rateString: String {
        return String(format: "%.2f", rate)
    }
//    let main: Main
//    let weather: [Weather]
}

//struct Main: Codable {
//    let temp: Double
//}
//struct Weather: Codable {
//    let id: Int
//}
