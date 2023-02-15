//
//  Extension+Date.swift
//  OpenWeatherApp
//
//  Created by 이재웅 on 2023/02/16.
//

import Foundation

extension Date {
    /// 현재날짜를 Int타입의 날짜로 반환하는 변수(ex: 20230101)
    var currentDayByInt: Int {
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "ko_KR")
        
        let nowInt = Int(formatter.string(from: now).split(separator: "-").reduce("") { $0 + $1 })!
        
        return nowInt
    }
    
    /// 현재시간을 Int타입의 시간으로 반환하는 변수 (ex: 현재 오전 7시 -> return 7)
    var currentTimeByString: Int {
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH"
        formatter.locale = Locale(identifier: "ko_KR")
        
        let hour = Int(formatter.string(from: now))!
        
        return hour
    }
}
