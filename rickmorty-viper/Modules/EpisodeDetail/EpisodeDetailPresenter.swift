// 
//  EpisodeDetailPresenter.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 07/02/24.
//

import Foundation
import RxSwift

class EpisodeDetailPresenter: BasePresenter {
    
    private let interactor: EpisodeDetailInteractor
    private let router = EpisodeDetailRouter()
    
    init(interactor: EpisodeDetailInteractor) {
        self.interactor = interactor
    }
    
    func fetchCharacter(from url: URL?) -> Observable<Character?> {
        return interactor.fetchCharacter(from: url)
    }
    
    func navigateToDetailCharacter(from navigation: UINavigationController,
                                   with data: Character) {
        router.navigateToDetailCharacter(from: navigation, with: data)
    }
    
//    func navigateToDetailEpisode(from navigation: UINavigationController,
//                                   with data: Episode) {
//        router.navigateToDetailEpisode(from: navigation, with: data)
//    }
    
}
