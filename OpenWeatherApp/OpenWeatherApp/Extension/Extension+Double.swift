//
//  Extension+Double.swift
//  OpenWeatherApp
//
//  Created by 이재웅 on 2023/02/15.
//

import Foundation

extension Double {
    var celsiusTemperature: Int {
        return Int(self - 273.15)
    }
}
