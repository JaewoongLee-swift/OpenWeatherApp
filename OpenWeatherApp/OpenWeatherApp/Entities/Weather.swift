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
    private var city: CityInfo
    
    func getCurrentWeather() -> CurrentWeather {
        let cityName = city.getName()
        let mainWeather = list.first?.getMainInfo()
        let currentTemp = mainWeather?.getTemp()
        let minTemp = mainWeather?.getTempMin()
        let maxTemp = mainWeather?.getTempMax()
        let skyCondition = list.first?.getWeatherCondition()
        
        return CurrentWeather(
            cityName: cityName,
            currentTemp: currentTemp?.celsiusTemperature ?? 0,
            skyCondition: skyCondition ?? "Clear",
            minTemp: minTemp?.celsiusTemperature ?? 0,
            maxTemp: maxTemp?.celsiusTemperature ?? 0
        )
    }
}

struct WeatherItem: Decodable {
    private var dt: Int
    private var main: MainInfo
    private var weather: [WeatherInfo]
    private var clouds: CloudInfo
    private var wind: WindInfo
    private var snow: SnowInfo?
    private var rain: RainInfo?
    private var visibility: Int
    private var rainfallProbability: Double
    private var dayInfo: DayInfo
    private var dateText: String
    
    func getMainInfo() -> MainInfo {
        return main
    }
    
    func getWeatherCondition() -> String? {
        return weather.first?.getWeatherCondition()
    }
    
    enum CodingKeys: String, CodingKey {
        case dt
        case main
        case weather
        case clouds
        case wind
        case rain
        case snow
        case visibility
        case rainfallProbability = "pop"
        case dayInfo = "sys"
        case dateText = "dt_txt"
    }
}

struct MainInfo: Decodable {
    private var temp: Double
    private var feelsLike: Double
    private var tempMin: Double
    private var tempMax: Double
    private var pressure: Int
    private var seaLevel: Int
    private var grndLevel: Int
    private var humidity: Int
    private var tempKf: Double
    
    func getTemp() -> Double {
        return temp
    }
    
    func getTempMin() -> Double {
        return tempMin
    }
    
    func getTempMax() -> Double {
        return tempMax
    }
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

struct WeatherInfo: Decodable {
    private var id: Int
    private var main: String
    private var description: String
    private var icon: String
    
    func getWeatherCondition() -> String {
        return main
    }
}

struct CloudInfo: Decodable {
    private var cloudiness: Int
    
    enum CodingKeys: String, CodingKey {
        case cloudiness = "all"
    }
}

struct RainInfo: Decodable {
    private var last3Hours: Double
    
    enum CodingKeys: String, CodingKey {
        case last3Hours = "3h"
    }
}

struct SnowInfo: Decodable {
    private var last3Hours: Double
    
    enum CodingKeys: String, CodingKey {
        case last3Hours = "3h"
    }
}

struct WindInfo: Decodable {
    private var speed: Double
    private var deg: Int
    private var gust: Double
}

struct DayInfo: Decodable {
    private var status: String
    
    enum CodingKeys: String, CodingKey {
        case status = "pod"
    }
}
