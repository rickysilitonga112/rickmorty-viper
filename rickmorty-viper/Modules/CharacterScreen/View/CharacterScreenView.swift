//
//  CharacterScreenView.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 26/01/24.
//

import UIKit

class CharacterScreenView: UIViewController {
    
    private var presenter: CharacterScreenPresenter?
    
    @IBOutlet weak var characterCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Character"
        view.backgroundColor = .systemBackground
        setupCollectionView()
    }
    
    static func instance(withPresenter presenter: CharacterScreenPresenter) -> CharacterScreenView {
        let storyboardId = String(describing: CharacterScreenView.self)
        let storyboard = UIStoryboard(name: storyboardId, bundle: nil)
        guard let anyView = storyboard.instantiateViewController(withIdentifier: storyboardId) as? CharacterScreenView else {
            fatalError("Error loading Storyboard")
        }
        anyView.presenter = presenter
        return anyView
    }
    
    // MARK: - Private
    private func setupCollectionView() {
        let width = (UIScreen.main.bounds.width - 30) / 2
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: width, height: width * 0.3)
        characterCollectionView.collectionViewLayout = layout
        
        characterCollectionView.register(CharacterCollectionViewCell.nib(), forCellWithReuseIdentifier: CharacterCollectionViewCell.identifier)
        
        characterCollectionView.delegate = self
        characterCollectionView.dataSource = self
    }
    
    
    // MARK: - Public
}

// MARK: - CollectionView Delegate
extension CharacterScreenView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO: - goto detail view controller
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

// MARK: - CollectionView DataSource
extension CharacterScreenView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.identifier, for: indexPath) as? CharacterCollectionViewCell else {
            fatalError("Error initialize character collection view cell")
        }
        cell.configure(with: UIImage(systemName: "person")!)
        
        return cell
    }
}

// MARK: - CollectionView Delegate Flow Layout
extension CharacterScreenView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 30) / 2
        return CGSize(width: width , height: width * 1.5)
    }
}
