//
//  CharacterScreenView.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 26/01/24.
//

import UIKit

class CharacterScreenView: UIViewController {
    
    private var presenter: CharacterScreenPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    static func instance(withPresenter presenter: CharacterScreenPresenter) -> CharacterScreenView {
        let storyboardId = "CharacterScreenView"
        let storyboard = UIStoryboard(name: storyboardId, bundle: nil)
        guard let anyView = storyboard.instantiateViewController(withIdentifier: storyboardId) as? CharacterScreenView else {
            fatalError("Error loading Storyboard")
        }
        anyView.presenter = presenter
        return anyView
    }

class CharacterScreenView: UIView {
    
    
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - private function
    private func setupConstraints() {
        NSLayoutConstraint.activate([
        
        ])
    }
}

