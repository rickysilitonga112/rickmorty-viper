// 
//  LocationScreenView.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 26/01/24.
//

import UIKit
import RxSwift

class LocationScreenView: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    private let bag = DisposeBag()
    private var presenter: LocationScreenPresenter?
    
    private var apiInfo: LocationEntity.Info? = nil
    private var isLoadingMoreLocations = false
    
    private var locations: [Location] = [] {
        didSet {
            spinner.stopAnimating()
            tableView.reloadData()
            tableView.isHidden = false
            
            UIView.animate(withDuration: 0.4) {
                self.tableView.alpha = 1
            }
        }
    }
    
    var isShowSpinner: Bool {
        return apiInfo != nil
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Location"
        view.backgroundColor = .systemBackground
        
        setupView()
        setupTableView()
        setupFetchData()
    }
    
    static func instance(withPresenter presenter: LocationScreenPresenter) -> LocationScreenView {
        let storyboardId = String(describing: LocationScreenView.self)
        let storyboard = UIStoryboard(name: storyboardId, bundle: nil)
        guard let anyView = storyboard.instantiateViewController(withIdentifier: storyboardId) as? LocationScreenView else {
            fatalError("Error loading Storyboard")
        }
        anyView.presenter = presenter
        return anyView
    }

    
    // MARK: - Private
    private func setupView() {
        tableView.alpha = 0
        tableView.isHidden = true
        
        // spinner
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        spinner.style = .large
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupFetchData() {
        presenter?.fetchInitialLocations()
            .asObservable()
            .subscribe(onNext: {[weak self] entity in
                if let entity = entity {
                    self?.apiInfo = entity.info
                    self?.locations = entity.results
                }
            }, onError: { error in
                print(String(describing: error))
            }).disposed(by: bag)
    }
    
    private func fetchMoreLocations() {
        print("Should fetch more locations....")
    }
}

// MARK: - TableViewDelegate
extension LocationScreenView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // todo: goto detail vc
    }
    
}

// MARK: - TableViewDataSource
extension LocationScreenView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath)
        return cell
    }
}

// MARK: - ScrollViewDelegate
extension LocationScreenView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard isShowSpinner,
              !isLoadingMoreLocations,
              !locations.isEmpty else {
            return
        }
        
        let offset = scrollView.contentOffset.y
        let totalContentHeight = scrollView.contentSize.height
        let totalScrollViewFixedHeight = scrollView.frame.size.height
        
        /// this code to fix redundant fetching a more character
        guard offset > 0 else {
            return
        }
        
        if offset >= (totalContentHeight - totalScrollViewFixedHeight - 120) {
            self.isLoadingMoreLocations = true
            
            Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] t in
                self?.fetchMoreLocations()
                t.invalidate()
            }
            
        }
    }
}

// MARK: - Spinner
extension LocationScreenView {
    
}



