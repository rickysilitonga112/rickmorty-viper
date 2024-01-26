// 
//  LocationScreenView.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 26/01/24.
//

import UIKit

class LocationScreenView: UIViewController {
    
    private var presenter: LocationScreenPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    static func instance(withPresenter presenter: LocationScreenPresenter) -> LocationScreenView {
        let storyboardId = "LocationScreenView"
        let storyboard = UIStoryboard(name: storyboardId, bundle: nil)
        guard let anyView = storyboard.instantiateViewController(withIdentifier: storyboardId) as? LocationScreenView else {
            fatalError("Error loading Storyboard")
        }
        anyView.presenter = presenter
        return anyView
    }

}

