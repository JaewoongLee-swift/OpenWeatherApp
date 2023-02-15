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
    let viewModel: MainViewModel
    
    //MARK: MainUI
    private lazy var scrollView = UIScrollView()
    private lazy var stackView = UIStackView()
    private lazy var contentView = UIView()
    private lazy var searchController = UISearchController()
    private lazy var currentWeatherView = CurrentWeatherView()
    private lazy var todayWeatherView = TodayWeatherView()
    private lazy var weeklyWeatherView = WeeklyWeatherView()
    private lazy var mapView = MapView()
    private lazy var detailWeatherView = DetailWeatherView()
    private lazy var searchTableView = SearchTableView()
    
    init(viewModel: MainViewModel = MainViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Bind views
    func bind() {
        bindSearch()
        
        viewModel.currentWeather
            .bind(to: currentWeatherView.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.todayWeather
            .bind(to: todayWeatherView.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.weeklyWeather
            .bind(to: weeklyWeatherView.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.detailWeather
            .bind(to: detailWeatherView.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.coordinates
            .bind(to: mapView.rx.coordinates)
            .disposed(by: disposeBag)
        
        viewModel.cities
            .bind(to: searchTableView.rx.text)
            .disposed(by: disposeBag)
    }
    
    //MARK: Bind SearchController and SearchBar
    func bindSearch() {
        searchController.searchBar.rx.text
            .orEmpty
            .debounce(RxTimeInterval.microseconds(10), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .map { text in
                let cities = self.viewModel.cityData.filter { $0.getCityName().lowercased().hasPrefix(text.lowercased()) }
                self.viewModel.filteredCities.onNext(cities)
                return cities
            }
            .bind(to: searchTableView.rx.text)
            .disposed(by: disposeBag)
        
        searchTableView.rx.itemSelected
            .map {
                self.searchController.searchBar.resignFirstResponder()
                self.searchController.dismiss(animated: true)
                self.searchController.searchBar.text = nil
                self.animateHideSearchTableView(true)
                return $0.row
            }
            .withLatestFrom(viewModel.filteredCities) {index, cities in
                return cities[index]
            }
            .subscribe(onNext:{ city in
                self.viewModel.coordinates.onNext(city.getCityCoord())
            })
            .disposed(by: disposeBag)
    }
    
    //MARK: ViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attribute()
        setupLayout()
        searchTableView.alpha = 0.0
    }
    
    func attribute() {
        setupViewControlletStyle()
        setNavigationBar()
    }
}

//MARK: SearchControllerDelegate
extension MainViewController: UISearchControllerDelegate {
    func presentSearchController(_ searchController: UISearchController) {
        animateHideSearchTableView(false)
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        animateHideSearchTableView(true)
    }
}

//MARK: Layout and ViewStyle methods
extension MainViewController {
    private func setNavigationBar() {
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
        view.backgroundColor = .backgroundBlue
    }
    
    private func animateHideSearchTableView(_ isHidden: Bool) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear) { [weak self] in
            guard let self = self else { return }
            if isHidden {
                self.searchTableView.alpha = 0.0
            } else {
                self.searchTableView.alpha = 1.0
                self.searchTableView.isHidden = isHidden
            }
        }
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
