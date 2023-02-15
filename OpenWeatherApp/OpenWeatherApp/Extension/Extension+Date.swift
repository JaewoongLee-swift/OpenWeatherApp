//
//  Extension+Date.swift
//  OpenWeatherApp
//
//  Created by 이재웅 on 2023/02/16.
//

import Foundation

extension Date {
    var currentDayByInt: Int {
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "ko_KR")
        
        let nowInt = Int(formatter.string(from: now).split(separator: "-").reduce("") { $0 + $1 })!
        
        return nowInt
    }
    
    var currentTimeByString: Int {
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH"
        formatter.locale = Locale(identifier: "ko_KR")
        
        let hour = Int(formatter.string(from: now))!
        
        return hour
    }
}
