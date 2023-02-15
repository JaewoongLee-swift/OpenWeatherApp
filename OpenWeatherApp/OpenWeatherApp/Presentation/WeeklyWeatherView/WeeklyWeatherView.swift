//
//  WeeklyWeatherView.swift
//  OpenWeatherApp
//
//  Created by 이재웅 on 2023/02/14.
//

import UIKit
import SnapKit

final class WeeklyWeatherView: UIView {
    private var weeklyWeather: [DayWeather] = []
    
    func configure(_ weeklyWeather: WeeklyWeather) {
        setupLayout()
        setupViewStyle()
        
        infoLabel.text = "5일간의 일기예보"
        self.weeklyWeather = weeklyWeather.dayWeather
    }
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondarySystemBackground
        label.font = .systemFont(ofSize: 12.0, weight: .light)
        
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.backgroundColor = UIColor(red: 105/255, green: 151/255, blue: 191/255, alpha: 1.0)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DailyWeatherCell.self, forCellReuseIdentifier: DailyWeatherCell.id)
        
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        
        return tableView
    }()
    
    private func setupLayout() {
        [
            infoLabel,
            tableView
        ].forEach { addSubview($0) }
        
        infoLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12.0)
            $0.leading.equalToSuperview().inset(12.0)
            $0.trailing.equalToSuperview().inset(12.0)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(infoLabel.snp.bottom).offset(8.0)
            $0.leading.equalToSuperview().inset(12.0)
            $0.trailing.equalToSuperview().inset(12.0)
            $0.bottom.equalToSuperview().inset(12.0)
        }
    }
    
    private func setupViewStyle() {
        backgroundColor = UIColor(red: 105/255, green: 151/255, blue: 191/255, alpha: 1.0)
        layer.cornerRadius = 8.0
    }
}

extension WeeklyWeatherView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        weeklyWeather.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DailyWeatherCell.id, for: indexPath) as? DailyWeatherCell
        cell?.configure(weeklyWeather[indexPath.row])
        cell?.selectionStyle = .none
        
        return cell ?? UITableViewCell()
    }
}

extension WeeklyWeatherView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50.0
    }
}
