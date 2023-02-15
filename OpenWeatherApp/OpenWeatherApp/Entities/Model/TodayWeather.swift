//
//  TodayWeather.swift
//  OpenWeatherApp
//
//  Created by 이재웅 on 2023/02/15.
//

import Foundation

struct TodayWeather {
    var gustSpeed: Int
    var hourlyWeather: [HourlyWeather]
}

struct HourlyWeather {
    var time: Int
    var temperature: Int
    var skyIcon: String
}
