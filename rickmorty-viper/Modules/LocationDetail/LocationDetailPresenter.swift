// 
//  LocationDetailPresenter.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 11/02/24.
//

import Foundation
import RxSwift

class LocationDetailPresenter: BasePresenter {
    
    private let interactor: LocationDetailInteractor
    private let router = LocationDetailRouter()
    
    init(interactor: LocationDetailInteractor) {
        self.interactor = interactor
    }
    
    func fetchCharacter(with url: URL?) -> Observable<Character?> {
        return interactor.fetchCharacter(with: url)
    }
    
    func navigateToDetailCharacter(from navigation: UINavigationController,
                                   with data: Character) {
        router.navigateToDetailCharacter(from: navigation, with: data)
    }
    
}
