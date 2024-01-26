// 
//  SettingScreenView.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 26/01/24.
//

import UIKit

class SettingScreenView: UIViewController {
    
    private var presenter: SettingScreenPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    static func instance(withPresenter presenter: SettingScreenPresenter) -> SettingScreenView {
        let storyboardId = "SettingScreenView"
        let storyboard = UIStoryboard(name: storyboardId, bundle: nil)
        guard let anyView = storyboard.instantiateViewController(withIdentifier: storyboardId) as? SettingScreenView else {
            fatalError("Error loading Storyboard")
        }
        anyView.presenter = presenter
        return anyView
    }

}

