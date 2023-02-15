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
        let currentTemp = mainWeather?.getTemp().celsiusTemperature
        let minTemp = mainWeather?.getTempMin().celsiusTemperature
        let maxTemp = mainWeather?.getTempMax().celsiusTemperature
        let skyCondition = list.first?.getWeatherCondition()
        
        return CurrentWeather(
            cityName: cityName,
            currentTemp: currentTemp ?? 0,
            skyCondition: skyCondition ?? "Clear",
            minTemp: minTemp ?? 0,
            maxTemp: maxTemp ?? 0
        )
    }
    
    func getTodayWeather() -> TodayWeather {
        let gustSpeed = list.first?.getGustSpeed() ?? 0.0
        var hourlyWeatherArray: [HourlyWeather] = []
        
        if !list.isEmpty {
            for i in 0...15 {
                hourlyWeatherArray.append(list[i].getHourlyWeather())
            }
        }
        
        return TodayWeather(
            gustSpeed: Int(gustSpeed),
            hourlyWeather: hourlyWeatherArray
        )
    }
    
    func getWeeklyWeather() -> WeeklyWeather {
        var dayWeatherArray: [DayWeather] = []
        var weatherItems: [WeatherItem] = []
        
        if !list.isEmpty {
            for i in stride(from: 0, through: 40, by: 7) {
                weatherItems.append(list[i])
            }
        }
        
        for weatherItem in weatherItems {
            let dayWeather = weatherItem.getDayWeather()
            dayWeatherArray.append(dayWeather)
        }
        
        return WeeklyWeather(dayWeather: dayWeatherArray)
    }
    
    func getDeatilWeather() -> DetailWeather {
        let weatherItem = list.first
        let mainInfo = weatherItem?.getMainInfo()
        let humadity = mainInfo?.getHumidity() ?? 0
        let pressure = mainInfo?.getPressure() ?? 1000
        let cloudiness = weatherItem?.getCloudiness() ?? 0
        let windSpeed = weatherItem?.getWindSpeed() ?? 0.0
        let gustSpeed = weatherItem?.getGustSpeed() ?? 0.0
        
        return DetailWeather(humidity: humadity, cloudiness: cloudiness, windSpeed: windSpeed, gustSpeed: gustSpeed, pressure: pressure)
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
    
    func getGustSpeed() -> Double {
        return wind.getGustSpeed()
    }
    
    func getWindSpeed() -> Double {
        return wind.getWindSpeed()
    }
    
    func getDayWeather() -> DayWeather {
        let skyCondition = getWeatherCondition() ?? "Clear"
        let minTemp = main.getTempMin().celsiusTemperature
        let maxTemp = main.getTempMax().celsiusTemperature
        let day = dateText.dayInKorea
        
        return DayWeather(day: day, skyCondition: skyCondition, minTemp: minTemp, maxTemp: maxTemp)
    }
    
    func getHourlyWeather() -> HourlyWeather {
        let hour = dateText.timeByString
        let temp = main.getTemp().celsiusTemperature
        let condition = getWeatherCondition() ?? "Clear"
        
        return HourlyWeather(
            time: hour,
            temperature: temp,
            skyCondition: condition
        )
    }
    
    func getCloudiness() -> Int {
        return clouds.getCloudiness()
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
    
    func getHumidity() -> Int {
        return humidity
    }
    
    func getPressure() -> Int {
        return pressure
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
    
    func getCloudiness() -> Int {
        return cloudiness
    }
    
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
    
    func getGustSpeed() -> Double {
        return gust
    }
    
    func getWindSpeed() -> Double {
        return speed
    }
}

struct DayInfo: Decodable {
    private var status: String
    
    enum CodingKeys: String, CodingKey {
        case status = "pod"
    }
}
