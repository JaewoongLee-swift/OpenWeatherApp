//
//  DetailWeatherCell.swift
//  OpenWeatherApp
//
//  Created by 이재웅 on 2023/02/14.
//

import UIKit
import SnapKit

final class DetailWeatherCell: UICollectionViewCell {
    static var id: String {
        return NSStringFromClass(Self.self).components(separatedBy: ".").last!
    }
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondarySystemBackground
        label.font = .systemFont(ofSize: 12.0, weight: .light)
        
        return label
    }()
    
    private lazy var degreeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 28.0, weight: .medium)
        
        return label
    }()
    
    private lazy var detailDegreeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondarySystemBackground
        label.font = .systemFont(ofSize: 12.0, weight: .light)
        
        return label
    }()
    
    func configure(_ index: Int, _ degree: Double, _ gustSpeed: Double?) {
        setupLayout()
        setupViewStyle()
        
        switch index {
        case 0:
            statusLabel.text = "습도"
            degreeLabel.text = "\(Int(degree))%"
        case 1:
            statusLabel.text = "구름"
            degreeLabel.text = "\(Int(degree))%"
        case 2:
            statusLabel.text = "바람 속도"
            degreeLabel.text = "\(degree)m/s"
        case 3:
            statusLabel.text = "기압"
            degreeLabel.text = "\(Int(degree).demical3)hpa"
        default:
            return
        }
        
        if let gust = gustSpeed {
            detailDegreeLabel.text = "강풍: \(gust)m/s"
        }
    }
    
    private func setupLayout() {
        [
            statusLabel,
            degreeLabel,
            detailDegreeLabel
        ].forEach { addSubview($0) }
        
        statusLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8.0)
            $0.leading.equalToSuperview().inset(16.0)
        }
        
        degreeLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16.0)
            $0.centerY.equalToSuperview()
        }
        
        detailDegreeLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16.0)
            $0.bottom.equalToSuperview().inset(16.0)
        }
    }
    
    private func setupViewStyle() {
        backgroundColor = .customViewBlue
        layer.cornerRadius = 8.0
    }
}
