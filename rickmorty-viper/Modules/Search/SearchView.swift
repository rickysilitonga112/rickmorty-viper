// 
//  SearchView.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 12/02/24.
//

import UIKit

class SearchView: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var searchResults: [Any] = []
   
    var presenter: SearchPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Search.."
    }

    private func setupView() {
        
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
    }
    
}

// MARK: - SearchViewDelegate
extension SearchView: UICollectionViewDelegate {
    
}

// MARK: - SearchViewDataSource
extension SearchView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "", for: indexPath)
        return cell
    }
}

