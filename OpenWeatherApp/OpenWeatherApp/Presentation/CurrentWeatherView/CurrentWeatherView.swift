//
//  CurrentWeatherView.swift
//  OpenWeatherApp
//
//  Created by 이재웅 on 2023/02/14.
//

import UIKit
import SnapKit

final class CurrentWeatherView: UIView {
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28.0, weight: .medium)
        label.textColor = .white
        
        return label
    }()
    
    private lazy var currentTempLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 40.0, weight: .medium)
        label.textColor = .white
        
        return label
    }()
    
    private lazy var skyConditionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24.0, weight: .medium)
        label.textColor = .white
        
        return label
    }()
    
    private lazy var maxMinLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20.0, weight: .regular)
        label.textColor = .white
        
        return label
    }()
    
    func configure(_ currentWeather: CurrentWeather) {
        setupLayout()
        
        cityLabel.text = currentWeather.cityName
        currentTempLabel.text = "\(currentWeather.currentTemp)℃"
        skyConditionLabel.text = currentWeather.skyCondition
        maxMinLabel.text = "최고: \(currentWeather.maxTemp)º  |  최저: \(currentWeather.minTemp)º"
    }
    
    private func setupLayout() {
        [
            cityLabel,
            currentTempLabel,
            skyConditionLabel,
            maxMinLabel
        ].forEach { addSubview($0) }
        
        cityLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16.0)
            $0.centerX.equalToSuperview()
        }
        
        currentTempLabel.snp.makeConstraints {
            $0.top.equalTo(cityLabel.snp.bottom).offset(16.0)
            $0.centerX.equalToSuperview()
        }
        
        skyConditionLabel.snp.makeConstraints {
            $0.top.equalTo(currentTempLabel.snp.bottom).offset(16.0)
            $0.centerX.equalToSuperview()
        }
        
        maxMinLabel.snp.makeConstraints {
            $0.top.equalTo(skyConditionLabel.snp.bottom).offset(16.0)
            $0.centerX.equalToSuperview()
        }
    }
}
