//
//  EpisodeScreenViewController.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 25/01/24.
//

import UIKit

class EpisodeScreenViewController: UIViewController {
    var presenter: EpisodeScreenPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        self.title = "Episode"
    }

}
