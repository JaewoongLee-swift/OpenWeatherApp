//
//  City.swift
//  OpenWeatherApp
//
//  Created by 이재웅 on 2023/02/14.
//

import Foundation

struct CityInfo: Decodable {
    private var id: Int
    private var name: String
    private var coord: CityCoordinates
    private var country: String
    private var population: Int
    private var timezone: Int
    private var sunrise: Int
    private var sunset: Int
}

struct City: Decodable {
    private var id: Int
    private var name: String
    private var country: String
    private var coord: CityCoordinates
}

struct CityCoordinates: Decodable {
    private let lon: Double
    private let lat: Double
}
