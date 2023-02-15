//
//  MainViewModel.swift
//  OpenWeatherApp
//
//  Created by 이재웅 on 2023/02/15.
//

import Foundation
import RxSwift

class MainViewModel {
    lazy var currentWeather = PublishSubject<CurrentWeather>()
    lazy var todayWeather = PublishSubject<TodayWeather>()
    lazy var weeklyWeather = PublishSubject<WeeklyWeather>()
    lazy var detailWeather = PublishSubject<DetailWeather>()
    
    init(weatherDomain: WeatherService = WeatherService(), cityDomain: CityStore = CityStore()) {
        let seoulCoord: Coordinates = (37.5683, 126.9778)
        let weatherObservable = weatherDomain.requestWeather(at: seoulCoord)
        
        _ = weatherObservable
            .map { $0.getCurrentWeather() }
            .bind(to: currentWeather)
        
        _ = weatherObservable
            .map{ $0.getTodayWeather() }
            .bind(to: todayWeather)
        
        _ = weatherObservable
            .map{ $0.getWeeklyWeather() }
            .bind(to: weeklyWeather)
        
        _ = weatherObservable
            .map{ $0.getDeatilWeather() }
            .bind(to: detailWeather)
    }
}
