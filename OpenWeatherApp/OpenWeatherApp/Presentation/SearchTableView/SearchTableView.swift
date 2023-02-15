//
//  SearchTableView.swift
//  OpenWeatherApp
//
//  Created by 이재웅 on 2023/02/14.
//

import UIKit
import SnapKit

final class SearchTableView: UITableView {
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        delegate = self
        dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        setupViewStyle()
    }
    
    private func setupViewStyle() {
        backgroundColor = UIColor(red: 166/255, green: 190/255, blue: 222/255, alpha: 1.0)
    }
}

extension SearchTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        cell.backgroundColor = UIColor(red: 166/255, green: 190/255, blue: 222/255, alpha: 1.0)
        cell.textLabel?.text = "Seoul"
        cell.textLabel?.textColor = .white
        cell.detailTextLabel?.text = "KR"
        cell.detailTextLabel?.textColor = .white
        
        return cell
    }
}

extension SearchTableView: UITableViewDelegate {
    
}
