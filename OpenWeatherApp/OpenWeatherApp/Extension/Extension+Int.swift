//
//  Extension+Int.swift
//  OpenWeatherApp
//
//  Created by 이재웅 on 2023/02/16.
//

import Foundation

extension Int {
    /// Int타입의 값을 천의 자리마다 구분점을 만들어 String타입으로 반환하는 변수
    var demical3: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let result = numberFormatter.string(from: NSNumber(value: self))!
        
        return result
    }
}
