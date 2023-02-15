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
}
