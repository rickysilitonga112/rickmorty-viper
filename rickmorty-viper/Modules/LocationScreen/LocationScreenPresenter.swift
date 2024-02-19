// 
//  LocationScreenPresenter.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 26/01/24.
//

import Foundation
import RxSwift

class LocationScreenPresenter: BasePresenter {
    
    private let interactor: LocationScreenInteractor
    private let router = LocationScreenRouter()
    
    init(interactor: LocationScreenInteractor) {
        self.interactor = interactor
    }
    
    func fetchInitialLocations() -> Observable<LocationEntity?> {
        return interactor.fetchInitialLocations()
    }
    
    func fetchMoreLocations(from url: URL?) -> Observable<LocationEntity?> {
        return interactor.fetchMoreLocations(from: url)
    }
    
    func navigateToLocationDetail(from navigation: UINavigationController,
                                   with data: Location) {
        router.navigateToLocationDetail(from: navigation, with: data)
    }
    
    func navigateToSearch(from navigation: UINavigationController,
                          with data: SearchType) {
        router.navigateToSearch(from: navigation, with: data)
    }
    
}
