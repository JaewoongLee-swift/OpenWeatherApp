//
//  Extension+Int.swift
//  OpenWeatherApp
//
//  Created by 이재웅 on 2023/02/16.
//

import Foundation

extension Int {
    var demical3: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let result = numberFormatter.string(from: NSNumber(value: self))!
        
        return result
    }
}
