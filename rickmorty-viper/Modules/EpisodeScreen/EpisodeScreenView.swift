// 
//  EpisodeScreenView.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 26/01/24.
//

import UIKit

class EpisodeScreenView: UIViewController {
    
    private var presenter: EpisodeScreenPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Episode"
        view.backgroundColor = .systemBackground
    }

    static func instance(withPresenter presenter: EpisodeScreenPresenter) -> EpisodeScreenView {
        let storyboardId = String(String(describing: EpisodeScreenView.self))
        let storyboard = UIStoryboard(name: storyboardId, bundle: nil)
        guard let anyView = storyboard.instantiateViewController(withIdentifier: storyboardId) as? EpisodeScreenView else {
            fatalError("Error loading Storyboard")
        }
        anyView.presenter = presenter
        return anyView
    }

}

