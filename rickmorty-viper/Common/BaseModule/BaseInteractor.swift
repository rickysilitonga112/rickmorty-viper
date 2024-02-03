//
//  BaseInteractor.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 02/02/24.
//

import Foundation
import RxSwift

class BaseInteractor: NSObject {
    open var api = ApiManager.shared
    open var bag = DisposeBag()
    
}
