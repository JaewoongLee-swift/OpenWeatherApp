//
//  MainViewModel.swift
//  OpenWeatherApp
//
//  Created by 이재웅 on 2023/02/15.
//

import Foundation
import RxSwift

class MainViewModel {
    private var currentWeatherData = CurrentWeather(cityName: "Seoul", currentTemp: -10, skyCondition: "맑음", minTemp: -12, maxTemp: -11)
    
    private var todayWeatherData = TodayWeather(gustSpeed: 4, hourlyWeather: [
        HourlyWeather(time: 11, temperature: -11, skyCondition: "맑음"),
        HourlyWeather(time: 12, temperature: -11, skyCondition: "맑음"),
        HourlyWeather(time: 13, temperature: -11, skyCondition: "맑음"),
        HourlyWeather(time: 14, temperature: -11, skyCondition: "맑음"),
        HourlyWeather(time: 15, temperature: -11, skyCondition: "맑음"),
        HourlyWeather(time: 16, temperature: -11, skyCondition: "맑음"),
        HourlyWeather(time: 17, temperature: -11, skyCondition: "맑음"),
        HourlyWeather(time: 18, temperature: -11, skyCondition: "맑음"),
        HourlyWeather(time: 19, temperature: -11, skyCondition: "맑음")
    ])
    private var weeklyWeatherData = WeeklyWeather(dayWeather: [
        DayWeather(day: "오늘", skyCondition: "맑음", minTemp: -12, maxTemp: -11),
        DayWeather(day: "목", skyCondition: "맑음", minTemp: -12, maxTemp: -11),
        DayWeather(day: "금", skyCondition: "맑음", minTemp: -12, maxTemp: -11),
        DayWeather(day: "토", skyCondition: "맑음", minTemp: -12, maxTemp: -11),
        DayWeather(day: "일", skyCondition: "맑음", minTemp: -12, maxTemp: -11)
    ])
    private var detailWeatherData = DetailWeather(humadity: 56, cloudiness: 50, windSpped: 1.97, gustSpeed: 3.39, pressure: 1030)
    
    lazy var currentWeather = Observable.just(currentWeatherData)
    lazy var todayWeather = Observable.just(todayWeatherData)
    lazy var weeklyWeather = Observable.just(weeklyWeatherData)
    lazy var detailWeather = Observable.just(detailWeatherData)
}
