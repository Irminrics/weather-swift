//
//  WeatherData.swift
//  JSONTest
//
//  Created by Jun Kang on 3/8/21.
//

import Foundation

struct WeatherData: Decodable {
    var main: MainData
    var name: String
    var weather: [CurrentWeatherData]
    var timezone: Int
    
}

struct MainData: Decodable {
    var temp: Double
    var feels_like: Double
    var temp_min: Double
    var temp_max: Double
}

struct CurrentWeatherData: Decodable, Hashable  {
    var mainWeather: String
    var description: String
    var icon: String
    
    enum CodingKeys: String, CodingKey {
        case mainWeather = "main"
        case description
        case icon
    }
}



