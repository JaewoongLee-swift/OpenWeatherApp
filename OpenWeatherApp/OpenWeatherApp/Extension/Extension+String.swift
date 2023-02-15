//
//  Extension+String.swift
//  OpenWeatherApp
//
//  Created by 이재웅 on 2023/02/15.
//

import Foundation

extension String {
    var timeByString: Int {
        var timeStringArray = self.split(separator: " ")
        let timeString = timeStringArray.popLast() ?? "00:00:00"
        let hourString = timeString.split(separator: ":")[0]
        
        return Int(hourString) ?? 0
    }
    
    var dayInKorea: String {
        //ex: self = 2023-02-15 23:55:55
        let days = (self.split(separator: " ").first ?? "2023-01-01").split(separator: "-").map { Int($0) }
        let times = (self.split(separator: " ").last ?? "00:00:00").split(separator: ":").map { Int($0) }
        let year = days[0]
        let month = days[1]
        let day = days[2]
        let hour = times[0]
        let minute = times[1]
        let second = times[2]
        
        let dateComponenets = DateComponents(year: year, month: month, day: day, hour: hour, minute: minute, second: second)
        let calendar = Calendar.current
        let thisDate = calendar.date(from: dateComponenets)!
        
        let nowDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss E"
        formatter.locale = Locale(identifier: "ko_KR")
        
        let nowDay = formatter.string(from: nowDate).split(separator: " ").last!
        let thisTimeDay = formatter.string(from: thisDate).split(separator: " ").last!
        
        if nowDay == thisTimeDay {
            return "오늘"
        } else {
            return String(thisTimeDay)
        }
    }
}
