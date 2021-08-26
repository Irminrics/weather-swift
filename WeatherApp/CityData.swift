//
//  CityData.swift
//  CityData
//
//  Created by Jun Kang on 24/8/21.
//

import Foundation

// MARK: - WelcomeElement
struct WelcomeElement: Codable {
    let id: Int?
    let name, state, country: String?
    let coord: Coord?
}

// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double?
}

typealias Welcome = [WelcomeElement]
