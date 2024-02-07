// 
//  EpisodeScreenPresenter.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 26/01/24.
//

import Foundation
import RxSwift

class EpisodeScreenPresenter: BasePresenter {
    
    private let interactor: EpisodeScreenInteractor
    private let router = EpisodeScreenRouter()
    
    init(interactor: EpisodeScreenInteractor) {
        self.interactor = interactor
    }
    
    func fetchInitialEpisodes() -> Observable<EpisodeEntity?> {
        return interactor.fetchInitialEpisode()
    }
    
    func fetchMoreEpisodes(from url: URL?) -> Observable<EpisodeEntity?> {
        return interactor.fetchMoreEpisode(from: url)
    }
}
