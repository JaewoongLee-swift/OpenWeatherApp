//
//  DailyWeatherCell.swift
//  OpenWeatherApp
//
//  Created by 이재웅 on 2023/02/14.
//

import UIKit
import SnapKit

final class DailyWeatherCell: UITableViewCell {
    static var id: String {
        return NSStringFromClass(Self.self).components(separatedBy: ".").last!
    }
    
    func configure(_ dayWeather: DayWeather) {
        setupLayout()
        setupViewStyle()
        
        dayLabel.text = dayWeather.day
        tempLabel.text = "최소:\(dayWeather.minTemp)º  최대:\(dayWeather.maxTemp)º"
    }
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    
    private lazy var dayLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18.0, weight: .light)
        label.textColor = .white
        
        return label
    }()
    
    private lazy var weatherIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .brown
        
        return imageView
    }()
    
    private lazy var tempLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18.0, weight: .light)
        label.textColor = .white
        
        return label
    }()
    
    private func setupLayout() {
        [
            separatorView,
            dayLabel,
            weatherIconView,
            tempLabel
        ].forEach { addSubview($0) }
        
        separatorView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(1.0)
        }
        
        dayLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.equalTo(40.0)
        }
        
        weatherIconView.snp.makeConstraints {
            $0.leading.equalTo(dayLabel.snp.trailing).offset(70.0)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(40.0)
            $0.height.equalTo(40.0)
        }
        
        tempLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
    
    private func setupViewStyle() {
        backgroundColor = UIColor(red: 105/255, green: 151/255, blue: 191/255, alpha: 1.0)
    }

}
