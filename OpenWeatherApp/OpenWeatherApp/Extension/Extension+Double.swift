//
//  Extension+Double.swift
//  OpenWeatherApp
//
//  Created by 이재웅 on 2023/02/15.
//

import Foundation

extension Double {
    /// Double타입인 절대온도를 Int타입의 섭씨온도로 반환하는 변수
    var celsiusTemperature: Int {
        return Int(self - 273.15)
    }
}
