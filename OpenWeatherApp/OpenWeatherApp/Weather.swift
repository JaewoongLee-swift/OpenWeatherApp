//
//  Weather.swift
//  OpenWeatherApp
//
//  Created by 이재웅 on 2023/02/14.
//

import Foundation

struct WeatherResponse: Decodable {
    private var cod: String
    private var message: Int
    private var cnt: Int
    private var list: [WeatherItem]
    private var city: City
}

struct WeatherItem: Decodable {
    private var dt: Int
    private var main: MainInfo
    private var weather: [WeatherInfo]
    private var clouds: CloudInfo
    private var wind: WindInfo
    private var visibility: Int
    private var pop: Int
    private var sys: DayInfo
    private var dt_txt: String
}

struct MainInfo: Decodable {
    private var temp: Double
    private var feels_like: Double
    private var temp_min: Double
    private var temp_max: Double
    private var pressure: Int
    private var sea_level: Int
    private var grnd_level: Int
    private var humidity: Int
    private var temp_kf: Double
}

struct WeatherInfo: Decodable {
    private var id: Int
    private var main: String
    private var description: String
    private var icon: String
}

struct CloudInfo: Decodable {
    private var all: Int
}

struct WindInfo: Decodable {
    private var speed: Double
    private var deg: Int
    private var gust: Double
}

struct DayInfo: Decodable {
    private var pod: String
}
