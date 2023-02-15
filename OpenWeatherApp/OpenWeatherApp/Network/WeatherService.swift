//
//  WeatherService.swift
//  OpenWeatherApp
//
//  Created by 이재웅 on 2023/02/14.
//

import Foundation
import Alamofire
import RxSwift

class WeatherService {
    /// 위도, 경도를 받아 해당 위치의 날씨정보 Observable을 반환하는 네트워크 메소드
    func requestWeather(at coord: Coordinates) -> Observable<WeatherResponse> {
        let url = "http://api.openweathermap.org/data/2.5/forecast"
        let parameters: [String: Any] = [
            "lat": coord.latitude,
            "lon": coord.longitude,
            "appid": OpenWeatherAPI.key
        ]
        
        return Observable.create { observer in
            let task = AF.request(url, method: .get, parameters: parameters)
                .responseDecodable(of: WeatherResponse.self) { response in
                    switch response.result {
                    case .success(let response):
                        observer.onNext(response)
                    case .failure(let error):
                        observer.onError(error)
                    }
                    
                    observer.onCompleted()
                }
            
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}

typealias Coordinates = (latitude: Double, longitude: Double)
