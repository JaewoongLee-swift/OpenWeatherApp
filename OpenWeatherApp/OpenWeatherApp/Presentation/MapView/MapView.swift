//
//  MapView.swift
//  OpenWeatherApp
//
//  Created by 이재웅 on 2023/02/14.
//

import UIKit
import RxSwift
import SnapKit
import MapKit

final class MapView: UIView {
    func configure(_ coordinates: Coordinates) {
        setupLayout()
        setupViewStyle()
        
        let centerCoord = CLLocationCoordinate2D(latitude: coordinates.latitude, longitude: coordinates.longitude)
        mapView.setRegion(MKCoordinateRegion(center: centerCoord, span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)), animated: true)
        addCustomPin(coordinates)
        rainfallLabel.text = "강수량"
    }
    
    private lazy var rainfallLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondarySystemBackground
        label.font = .systemFont(ofSize: 12.0, weight: .light)
        
        return label
    }()
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.delegate = self
        
        return mapView
    }()
    
    private func addCustomPin(_ coordinates: Coordinates) {
        let pin = MKPointAnnotation()
        pin.coordinate = CLLocationCoordinate2D(latitude: coordinates.latitude, longitude: coordinates.longitude)
        mapView.addAnnotation(pin)
    }
    
    private func setupLayout() {
        [
            rainfallLabel,
            mapView
        ].forEach { addSubview($0) }
        
        rainfallLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8.0)
            $0.leading.equalToSuperview().inset(12.0)
        }
        
        mapView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(300.0)
        }
    }
    
    private func setupViewStyle() {
        backgroundColor = .customViewBlue
        layer.cornerRadius = 8.0
    }
    
}

extension MapView: MKMapViewDelegate {

}

extension Reactive where Base: MapView {
    var coordinates: Binder<Coordinates> {
        return Binder(self.base) { view, coord in
            view.configure(coord)
        }
    }
}
