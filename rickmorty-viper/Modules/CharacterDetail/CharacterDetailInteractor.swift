// 
//  CharacterDetailInteractor.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 02/02/24.
//

import Foundation
import RxSwift

class CharacterDetailInteractor: BaseInteractor {
    
    func fetchEpisode(from url: URL) -> PublishSubject<Episode?> {
        let subject = PublishSubject<Episode?>()
        
        guard let request = Request(url: url) else {
            subject.onError(ServiceError.failedToCreateRequest)
            return subject
        }
        
        api.requestAPI(request)
            .subscribe { (data: Episode) in
                subject.onNext(data)
            } onError: { error in
                subject.onError(error)
            }.disposed(by: bag)
        
        return subject
    }
}
