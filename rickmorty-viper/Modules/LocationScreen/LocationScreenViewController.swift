//
//  LocationScreenViewController.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 25/01/24.
//

import UIKit

class LocationScreenViewController: UIViewController {
    var presenter: LocationScreenPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        self.title = "Location"
    }

}
