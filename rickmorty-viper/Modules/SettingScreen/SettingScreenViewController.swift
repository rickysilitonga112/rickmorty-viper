//
//  SettingScreenViewController.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 25/01/24.
//

import UIKit

class SettingScreenViewController: UIViewController {
    var presenter: SettingScreenPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        self.title = "Setting"
    }
}
