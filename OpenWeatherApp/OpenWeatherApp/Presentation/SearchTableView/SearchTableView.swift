//
//  SearchTableView.swift
//  OpenWeatherApp
//
//  Created by 이재웅 on 2023/02/14.
//

import UIKit
import SnapKit

final class SearchTableView: UITableView {
    private var cities: [City] = []
    
    func configure(_ cities: [City]) {
        setupViewStyle()
        
        self.cities = cities
        self.reloadData()
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        delegate = self
        dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViewStyle() {
        backgroundColor = UIColor(red: 166/255, green: 190/255, blue: 222/255, alpha: 1.0)
    }
}

extension SearchTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        let city = cities[indexPath.row]
        
        cell.backgroundColor = UIColor(red: 166/255, green: 190/255, blue: 222/255, alpha: 1.0)
        cell.textLabel?.text = city.getCityName()
        cell.textLabel?.textColor = .white
        cell.detailTextLabel?.text = city.getCountry()
        cell.detailTextLabel?.textColor = .white
        
        return cell
    }
}

extension SearchTableView: UITableViewDelegate {
    
}
