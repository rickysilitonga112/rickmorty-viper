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
    var presenter: LocationScreenPresenter?
    
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
        setupFetchData()
    }
    
    // MARK: - Private
    private func setupView() {
        tableView.alpha = 0
        tableView.isHidden = true
        
        // spinner
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        spinner.style = .large
        
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(LocationTableViewCell.nib(), forCellReuseIdentifier: LocationTableViewCell.identifier)
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
        guard let urlString = apiInfo?.next else {
            return
        }
        let nextUrl = URL(string: urlString)
        presenter?.fetchMoreLocations(from: nextUrl)
            .asObservable()
            .subscribe(onNext: {[weak self] entity in
                guard let self = self,
                      let entity = entity else {
                    return
                }
                self.isLoadingMoreLocations = false
                self.apiInfo = entity.info
                self.locations.append(contentsOf: entity.results)
                
            }, onError: { error in
                fatalError("Error fetch more characters with error \(error.localizedDescription)..")
            }).disposed(by: bag)
        
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LocationTableViewCell.identifier, for: indexPath) as? LocationTableViewCell else {
            fatalError("Error parse LocationTableViewCell")
        }
        cell.configure(with: locations[indexPath.row])
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



