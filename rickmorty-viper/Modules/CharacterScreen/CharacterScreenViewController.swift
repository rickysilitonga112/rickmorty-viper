//
//  CharacterScreenViewController.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 25/01/24.
//

import UIKit

class CharacterScreenViewController: UIViewController {
    var presenter: CharacterScreenPresenter?
    private let characterScreenView = CharacterScreenView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        self.title = "Character"
        
        view.addSubview(characterScreenView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            characterScreenView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            characterScreenView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            characterScreenView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            characterScreenView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
