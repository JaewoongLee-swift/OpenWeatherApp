//
//  DetailWeatherView.swift
//  OpenWeatherApp
//
//  Created by 이재웅 on 2023/02/14.
//

import UIKit
import RxSwift
import SnapKit

final class DetailWeatherView: UICollectionView {
    private var detailWeather: DetailWeather?
    
    func configure(_ detailWeather: DetailWeather) {
        setupViewStyle()
        
        self.detailWeather = detailWeather
        self.reloadData()
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let layout = UICollectionViewFlowLayout()
        super.init(frame: frame, collectionViewLayout: layout)
        
        delegate = self
        dataSource = self
        isScrollEnabled = false
        register(DetailWeatherCell.self, forCellWithReuseIdentifier: DetailWeatherCell.id)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViewStyle() {
        backgroundColor = .backgroundBlue
        layer.cornerRadius = 8.0
    }
}

extension Reactive where Base: DetailWeatherView {
    var text: Binder<DetailWeather> {
        return Binder(self.base) { view, detailWeather in
            view.configure(detailWeather)
        }
    }
}

extension DetailWeatherView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailWeatherCell.id, for: indexPath) as? DetailWeatherCell
        
        if let weather = detailWeather {
            switch indexPath.row {
            case 0:
                cell?.configure(0, Double(weather.humidity), nil)
            case 1:
                cell?.configure(1, Double(weather.cloudiness), nil)
            case 2:
                cell?.configure(2, weather.windSpeed, weather.gustSpeed)
            case 3:
                cell?.configure(3, Double(weather.pressure), nil)
            default:
                return UICollectionViewCell()
            }
        }
        
        return cell ?? UICollectionViewCell()
    }
}

extension DetailWeatherView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = window?.windowScene?.screen.bounds.width ?? 390.0
        let cellWidth = (screenWidth - 36.0) / 2
        
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0.0, left: 0.0, bottom: 12.0, right: 0.0)
    }
}
