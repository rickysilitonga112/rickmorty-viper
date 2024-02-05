//
//  BaseViewController.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 26/01/24.
//

import UIKit
import RxSwift

class BaseViewController: UITabBarController {
    open var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        preload()
    }
    
    func preload() {
        
    }

}
