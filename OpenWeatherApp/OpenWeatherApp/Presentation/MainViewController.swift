//
//  MainViewController.swift
//  OpenWeatherApp
//
//  Created by 이재웅 on 2023/02/14.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class MainViewController: UIViewController {
    let disposeBag = DisposeBag()
    let viewModel = MainViewModel()
    
    private lazy var scrollView = UIScrollView()
    private lazy var stackView = UIStackView()
    private lazy var contentView = UIView()
    private lazy var currentWeatherView = CurrentWeatherView()
    private lazy var todayWeatherView = TodayWeatherView()
    private lazy var weeklyWeatherView = WeeklyWeatherView()
    private lazy var mapView = MapView()
    private lazy var detailWeatherView = DetailWeatherView()
    private lazy var searchTableView = SearchTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewControlletStyle()
        setNavigationBar()
        setupLayout()
        
        viewModel.currentWeather
            .bind(to: currentWeatherView.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.todayWeather
            .bind(to: todayWeatherView.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.weeklyWeather
            .subscribe(onNext:{
                self.weeklyWeatherView.configure($0)
            })
            .disposed(by: disposeBag)
        
        viewModel.detailWeather
            .subscribe(onNext:{
                self.detailWeatherView.configure($0)
            })
            .disposed(by: disposeBag)
        
        mapView.configure()
        searchTableView.configure()
    }
}

extension MainViewController: UISearchControllerDelegate {
    func presentSearchController(_ searchController: UISearchController) {
        searchTableView.isHidden = false
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        searchTableView.isHidden = true
    }
}

extension MainViewController {
    private func setNavigationBar() {
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "Search"
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.delegate = self
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        navigationController?.navigationBar.standardAppearance = appearance
    }
    
    private func setupViewControlletStyle() {
        view.backgroundColor = UIColor(red: 166/255, green: 190/255, blue: 222/255, alpha: 1.0)
    }
    
    private func setupLayout() {
        setupStackView()
        searchTableView.isHidden = true
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.top.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(12.0)
            $0.trailing.equalToSuperview().inset(12.0)
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalToSuperview()
        }
        
        view.addSubview(searchTableView)
        searchTableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    func setupStackView() {
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 16.0
        
        [
            currentWeatherView,
            todayWeatherView,
            weeklyWeatherView,
            mapView,
            detailWeatherView
        ].forEach { stackView.addArrangedSubview($0) }
        
        currentWeatherView.snp.makeConstraints {
            $0.height.equalTo(200.0)
        }
        
        todayWeatherView.snp.makeConstraints {
            $0.height.equalTo(150.0)
        }
        
        weeklyWeatherView.snp.makeConstraints {
            $0.height.equalTo(290.0)
        }
        
        mapView.snp.makeConstraints {
            $0.height.equalTo(mapView.snp.width)
        }
        
        detailWeatherView.snp.makeConstraints {
            $0.height.equalTo(detailWeatherView.snp.width)
        }
    }
}
