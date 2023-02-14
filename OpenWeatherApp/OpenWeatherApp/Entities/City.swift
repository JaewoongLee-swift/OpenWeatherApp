//
//  City.swift
//  OpenWeatherApp
//
//  Created by 이재웅 on 2023/02/14.
//

import Foundation

struct City: Decodable {
    private var id: Int
    private var name: String
    private var coord: CityCoordinates
    private var country: String
    private var population: Int
    private var timezone: Int
    private var sunrize: Int
    private var sunset: Int
}

struct CityCoordinates: Decodable {
    private let lon: Double
    private let lat: Double
}
