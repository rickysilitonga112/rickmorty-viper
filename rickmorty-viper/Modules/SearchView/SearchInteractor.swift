// 
//  SearchInteractor.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 12/02/24.
//

import Foundation
import RxSwift

class SearchInteractor: BaseInteractor {
    
    func createOptions(from type: SearchType) -> [DynamicOption] {
        switch type {
        case .character:
            return [.status, .gender]
        case .location:
            return [.locationType]
        case .episode:
            return []
        }
    }
    
    func createSearchParameter(searchText: String, optionMap: Dictionary<DynamicOption, String>) -> [URLQueryItem] {
        // Build query item
        var queryParams: [URLQueryItem] = [
            URLQueryItem(name: "name", value: searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
        ]
        
        // add options
        queryParams.append(contentsOf: optionMap.enumerated().compactMap { _, element in
            return URLQueryItem(name: element.key.queryArgument, value: element.value)
        })
        
        return queryParams
    }
    
    // fetch data
    func executeFetchCharacter(params: [URLQueryItem]) -> PublishSubject<CharacterEntity?> {
        let subject = PublishSubject<CharacterEntity?>()
        let request = Request(endpoint: .character, queryParameters: params)
        api.requestAPI(request)
            .subscribe { (data: CharacterEntity) in
                subject.onNext(data)
            } onError: { error in
                subject.onError(error)
            }.disposed(by: bag)
        return subject
    }
    
    func executeFetchEpisode(params: [URLQueryItem]) -> PublishSubject<EpisodeEntity?> {
        let subject = PublishSubject<EpisodeEntity?>()
        let request = Request(endpoint: .episode, queryParameters: params)
        api.requestAPI(request)
            .subscribe { (data: EpisodeEntity) in
                subject.onNext(data)
            } onError: { error in
                subject.onError(error)
            }.disposed(by: bag)
        return subject
    }
    
    func executeFetchLocation(params: [URLQueryItem]) -> PublishSubject<LocationEntity?> {
        let subject = PublishSubject<LocationEntity?>()
        let request = Request(endpoint: .location, queryParameters: params)
        api.requestAPI(request)
            .subscribe { (data: LocationEntity) in
                subject.onNext(data)
            } onError: { error in
                subject.onError(error)
            }.disposed(by: bag)
        return subject
    }
}
