// 
//  EpisodeScreenInteractor.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 26/01/24.
//

import Foundation
import RxSwift

class EpisodeScreenInteractor: BaseInteractor {
    
    func fetchInitialEpisode() -> PublishSubject<EpisodeEntity?> {
        let subject = PublishSubject<EpisodeEntity?>()
        api.requestAPI(.listEpisodesRequests)
            .subscribe { (data: EpisodeEntity) in
                subject.onNext(data)
            } onError: { error in
                subject.onError(error)
            }
            .disposed(by: bag)
        return subject
    }
    
    func fetchMoreEpisode(from url: URL?) -> PublishSubject<Episode?> {
        let subject = PublishSubject<Episode?>()
        
        guard let url = url else {
            subject.onError(ServiceError.invalidUrl)
            return subject
        }
        
        guard let request = Request(url: url) else {
            subject.onError(ServiceError.failedToCreateRequest)
            return subject
        }
        api.requestAPI(request)
            .subscribe { (data: Episode) in
                subject.onNext(data)
            } onError: { error in
                subject.onError(error)
            }
            .disposed(by: bag)
        return subject
    }
}
