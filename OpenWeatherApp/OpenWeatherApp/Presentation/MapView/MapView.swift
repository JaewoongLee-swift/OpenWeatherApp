//
//  MapView.swift
//  OpenWeatherApp
//
//  Created by 이재웅 on 2023/02/14.
//

import UIKit
import SnapKit

final class MapView: UIView {
    private lazy var rainfallLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondarySystemBackground
        label.font = .systemFont(ofSize: 12.0, weight: .light)
        
        return label
    }()
    
    func configure() {
        setupLayout()
        setupViewStyle()
        
        rainfallLabel.text = "강수량"
    }
    
    private func setupLayout() {
        [
            rainfallLabel
        ].forEach { addSubview($0) }
        
        rainfallLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8.0)
            $0.leading.equalToSuperview().inset(12.0)
        }
    }
    
    private func setupViewStyle() {
        backgroundColor = UIColor(red: 105/255, green: 151/255, blue: 191/255, alpha: 1.0)
        layer.cornerRadius = 8.0
    }
    
}
