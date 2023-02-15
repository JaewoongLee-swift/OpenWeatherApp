//
//  HourlyWeatherCell.swift
//  OpenWeatherApp
//
//  Created by 이재웅 on 2023/02/14.
//

import UIKit
import SnapKit

final class HourlyWeatherCell: UICollectionViewCell {
    static var id: String {
        return NSStringFromClass(Self.self).components(separatedBy: ".").last!
    }
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 12.0)
        
        return label
    }()
    
    private lazy var weatherIconView = UIImageView()
    
    private lazy var tempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 12.0, weight: .medium)
        
        return label
    }()
    
    func configure(_ hourlyWeather: HourlyWeather, _ index: Int) {
        setupLayout()
        setupViewStyle()
        
        var timeText = ""
        
        if index == 0 {
            timeText = "지금"
        } else {
            switch hourlyWeather.time {
            case 0:
                timeText = "오전 12시"
            case 1...11:
                timeText = "오전 \(hourlyWeather.time)시"
            case 12:
                timeText = "오후 \(hourlyWeather.time)시"
            case 13...23:
                timeText = "오후 \(hourlyWeather.time - 12)시"
            default:
                timeText = "오전 0시"
            }
        }
        
        timeLabel.text = timeText
        tempLabel.text = "\(hourlyWeather.temperature)º"
        weatherIconView.image = UIImage(named: hourlyWeather.skyIcon)
    }
    
    private func setupLayout() {
        [
            timeLabel,
            weatherIconView,
            tempLabel
        ].forEach { addSubview($0) }
        
        timeLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        weatherIconView.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom).offset(4.0)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(40.0)
            $0.width.equalTo(40.0)
        }
        
        tempLabel.snp.makeConstraints {
            $0.top.equalTo(weatherIconView.snp.bottom).offset(4.0)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func setupViewStyle() {
        backgroundColor = .customViewBlue
    }
}
