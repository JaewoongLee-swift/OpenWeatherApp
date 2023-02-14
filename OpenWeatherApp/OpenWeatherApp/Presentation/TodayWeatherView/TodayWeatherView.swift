//
//  TodayWeatherView.swift
//  OpenWeatherApp
//
//  Created by 이재웅 on 2023/02/14.
//

import UIKit
import SnapKit

final class TodayWeatherView: UIView {
    private lazy var windSpeedLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16.0)
        label.textColor = .white
        
        return label
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HourlyWeatherCell.self, forCellWithReuseIdentifier: HourlyWeatherCell.id)
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor(red: 105/255, green: 151/255, blue: 191/255, alpha: 1.0)
        
        return collectionView
    }()
    
    func configure() {
        setupLayout()
        setupViewStyle()
        
        windSpeedLabel.text = "돌풍의 풍속은 최대 4m/s입니다."
    }
    
    private func setupLayout() {
        [
            windSpeedLabel,
            separatorView,
            collectionView
        ].forEach { addSubview($0) }
        
        windSpeedLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12.0)
            $0.leading.equalToSuperview().inset(16.0)
            $0.trailing.equalToSuperview().inset(16.0)
        }
        
        separatorView.snp.makeConstraints {
            $0.top.equalTo(windSpeedLabel.snp.bottom).offset(12.0)
            $0.leading.equalToSuperview().inset(8.0)
            $0.trailing.equalToSuperview().inset(8.0)
            $0.height.equalTo(1.0)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(separatorView.snp.bottom).offset(12.0)
            $0.leading.equalToSuperview().inset(8.0)
            $0.trailing.equalToSuperview().inset(8.0)
            $0.bottom.equalToSuperview()
        }
    }
    
    private func setupViewStyle() {
        backgroundColor = UIColor(red: 105/255, green: 151/255, blue: 191/255, alpha: 1.0)
        layer.cornerRadius = 8.0
    }
}

extension TodayWeatherView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyWeatherCell.id, for: indexPath) as? HourlyWeatherCell
        cell?.configure()
        
        return cell ?? UICollectionViewCell()
    }
}

extension TodayWeatherView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 60.0, height: 80.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20.0)
    }
}
