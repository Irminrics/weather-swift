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
    var weather: [CurrentWeatherData]

}

struct TempData: Decodable {
    var min: Double
    var max: Double
}



