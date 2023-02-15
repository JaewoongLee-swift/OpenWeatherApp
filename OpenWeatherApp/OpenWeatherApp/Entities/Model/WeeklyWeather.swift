//
//  WeeklyWeather.swift
//  OpenWeatherApp
//
//  Created by 이재웅 on 2023/02/15.
//

import Foundation

struct WeeklyWeather {
    var dayWeather: [DayWeather]
}

struct DayWeather {
    var day: String
    var skyCondition: String
    var minTemp: Int
    var maxTemp: Int
}
