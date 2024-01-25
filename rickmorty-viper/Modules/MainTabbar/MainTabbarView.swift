//
//  MainTabbarView.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 25/01/24.
//

import UIKit

class MainTabbarView: UITabBarController {
    var presenter: MainTabbarPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewControllers = MainTabbarRouter().tabbarController()
    }

}
