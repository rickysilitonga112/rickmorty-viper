// 
//  SearchPresenter.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 12/02/24.
//

import Foundation
import RxSwift

class SearchPresenter: BasePresenter {
    
    private let interactor: SearchInteractor
    private let router = SearchRouter()
    
    init(interactor: SearchInteractor) {
        self.interactor = interactor
    }
    
    func createOptions(from type: SearchType) -> [DynamicOption] {
        interactor.createOptions(from: type)
    }   
    
    func createSearchParameter(searchText: String, optionMap: Dictionary<DynamicOption, String>) -> [URLQueryItem] {
        return interactor.createSearchParameter(searchText: searchText, optionMap: optionMap)
    }
    
    // fetch data
    func executeFetchCharacter(params: [URLQueryItem]) -> Observable<CharacterEntity?> {
        interactor.executeFetchCharacter(params: params)
    }
    
    func executeFetchEpisode(params: [URLQueryItem]) -> Observable<EpisodeEntity?> {
        interactor.executeFetchEpisode(params: params)
    }
    
    func executeFetchLocation(params: [URLQueryItem]) -> Observable<LocationEntity?> {
        interactor.executeFetchLocation(params: params)
    }
    
    func showBottomSheetOptionChoices(on parent: UINavigationController,  with option: DynamicOption, delegation: SearchViewDelegation) {
        router.showBottomSheetOptionChoices(on: parent, with: option, delegation: delegation)
    }
}
