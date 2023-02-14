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
    
    func configure() {
        setupLayout()
        setupViewStyle()
        
        dayLabel.text = "오늘"
        tempLabel.text = "최소:-12º  최대:-12º"
    }
    
    private func setupLayout() {
        [
            dayLabel,
            weatherIconView,
            tempLabel
        ].forEach { addSubview($0) }
        
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
