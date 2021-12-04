//
//  ForecastData.swift
//  ForecastData
//
//  Created by Jun Kang on 4/12/21.
//

import Foundation

struct ForecastData: Decodable {
    var daily: [WeatherForecastData]
}

struct WeatherForecastData: Decodable {
    var temp: TempData
    var weather: [ForecastWeatherData]

}

struct TempData: Decodable {
    var min: Double
    var max: Double
}

struct ForecastWeatherData: Decodable, Hashable  {
    var mainWeather: String
    var description: String
    var icon: String
    
    enum CodingKeys: String, CodingKey {
        case mainWeather = "main"
        case description
        case icon
    }
}


