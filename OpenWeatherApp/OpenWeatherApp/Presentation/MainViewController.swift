//
//  MainViewController.swift
//  OpenWeatherApp
//
//  Created by 이재웅 on 2023/02/14.
//

import UIKit
import RxSwift

class MainViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControlletStyle()
        setNavigationBar()
    }
}

extension MainViewController: UISearchBarDelegate {
    
}

extension MainViewController {
    private func setNavigationBar() {
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "Search"
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        
        navigationItem.searchController = searchController
    }
    
    private func setupViewControlletStyle() {
        view.backgroundColor = UIColor(red: 166/255, green: 190/255, blue: 222/255, alpha: 1.0)
    }
}
