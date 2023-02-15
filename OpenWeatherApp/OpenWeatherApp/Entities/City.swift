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
    
    func getName() -> String {
        return name
    }
}

struct City: Decodable {
    private var id: Int
    private var name: String
    private var country: String
    private var coord: CityCoordinates
    
    func getCityName() -> String {
        return name
    }
    
    func getCountry() -> String {
        return country
    }
    
    func getCityCoord() -> Coordinates {
        return coord.getCoord()
    }
    
    static func parseCityData() -> [City] {
        let data = JsonLoader.data(fileName: "citylist")!
        
        var cityArray: [City] = []
        do {
            cityArray = try JSONDecoder().decode([City].self, from: data)
        } catch {
            print(error.localizedDescription)
        }
        
        return cityArray
        
    }
}

struct CityCoordinates: Decodable {
    private let lon: Double
    private let lat: Double
    
    func getCoord() -> Coordinates {
        return Coordinates(lat, lon)
    }
}
