// 
//  CharacterDetailView.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 02/02/24.
//

import UIKit

class CharacterDetailView: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var character: Character?
    var presenter: CharacterDetailPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Character Detail"
       
        if let character = character {
            print("Debug: Character detail with data..")
            print(String(describing: character))
        }
    }

}

