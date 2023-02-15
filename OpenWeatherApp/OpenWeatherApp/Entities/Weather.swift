//
//  Weather.swift
//  OpenWeatherApp
//
//  Created by 이재웅 on 2023/02/14.
//

import Foundation

//MARK: WeatherResponse
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
            for i in 0..<list.count {
                if hourlyWeatherArray.count == 16 {
                    break
                }
                
                let weather = list[i]
                let now = Date()
                let currentDay = now.currentDayByInt
                let weatherDay = Int(weather.getDateText().split(separator: " ")[0].split(separator: "-").reduce("") { $0 + $1 })!
                
                if currentDay <= weatherDay {
                    if currentDay < weatherDay {
                        hourlyWeatherArray.append(weather.getHourlyWeather())
                        continue
                    }
                    
                    let weatherHour = Int(weather.getDateText().split(separator: " ")[1].split(separator: ":")[0])!
                    let currentHour = now.currentTimeByString
                    
                    if (weatherHour / 3) >= (currentHour / 3) {
                        hourlyWeatherArray.append(weather.getHourlyWeather())
                    }
                }
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

//MARK: WeatherItem
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
    
    func getWeatherIcon() -> String {
        var icon = weather.first?.getWeatherDayIcon()
        _ = icon?.removeLast()
        let iconID = (icon ?? "01") + "d"
        
        return iconID
    }
    
    func getGustSpeed() -> Double {
        return wind.getGustSpeed()
    }
    
    func getWindSpeed() -> Double {
        return wind.getWindSpeed()
    }
    
    func getDateText() -> String {
        return dateText
    }
    
    func getDayWeather() -> DayWeather {
        let skyCondition = getWeatherIcon()
        let minTemp = main.getTempMin().celsiusTemperature
        let maxTemp = main.getTempMax().celsiusTemperature
        let day = dateText.dayInKorea
        
        return DayWeather(day: day, skyIcon: skyCondition, minTemp: minTemp, maxTemp: maxTemp)
    }
    
    func getHourlyWeather() -> HourlyWeather {
        let hour = dateText.timeByString
        let temp = main.getTemp().celsiusTemperature
        let weatherIcon = getWeatherIcon()
        
        return HourlyWeather(
            time: hour,
            temperature: temp,
            skyIcon: weatherIcon
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

//MARK: MainInfo
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

//MARK: WeatherInfo
struct WeatherInfo: Decodable {
    private var id: Int
    private var main: String
    private var description: String
    private var icon: String
    
    func getWeatherCondition() -> String {
        return main
    }
    
    func getWeatherDayIcon() -> String {
        return icon
    }
}

//MARK: CloudInfo
struct CloudInfo: Decodable {
    private var cloudiness: Int
    
    func getCloudiness() -> Int {
        return cloudiness
    }
    
    enum CodingKeys: String, CodingKey {
        case cloudiness = "all"
    }
}

//MARK: RainInfo
struct RainInfo: Decodable {
    private var last3Hours: Double
    
    enum CodingKeys: String, CodingKey {
        case last3Hours = "3h"
    }
}

//MARK: SnowInfo
struct SnowInfo: Decodable {
    private var last3Hours: Double
    
    enum CodingKeys: String, CodingKey {
        case last3Hours = "3h"
    }
}

//MARK: WindInfo
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

//MARK: DayInfo
struct DayInfo: Decodable {
    private var status: String
    
    enum CodingKeys: String, CodingKey {
        case status = "pod"
    }
}
