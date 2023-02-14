//
//  DetailWeatherView.swift
//  OpenWeatherApp
//
//  Created by 이재웅 on 2023/02/14.
//

import UIKit
import SnapKit

final class DetailWeatherView: UICollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let layout = UICollectionViewFlowLayout()
        super.init(frame: frame, collectionViewLayout: layout)
        
        delegate = self
        dataSource = self
        register(DetailWeatherCell.self, forCellWithReuseIdentifier: DetailWeatherCell.id)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        setupViewStyle()
    }
    
    private func setupViewStyle() {
        backgroundColor = UIColor(red: 166/255, green: 190/255, blue: 222/255, alpha: 1.0)
        layer.cornerRadius = 8.0
    }
}

extension DetailWeatherView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailWeatherCell.id, for: indexPath) as? DetailWeatherCell
        cell?.configure()
        
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
