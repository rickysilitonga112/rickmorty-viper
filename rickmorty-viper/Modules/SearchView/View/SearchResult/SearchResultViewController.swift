//
//  SearchResultViewController.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 19/02/24.
//

import UIKit

class SearchResultViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!

    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    
    // MARK: -Private
    private func setupCollectionView() {
        tableView.isHidden = true
        collectionView.isHidden = false
    }
    
    private func setupTableView() {
        
    }
    
}

// MARK: CollectionViewDelegate & DataSource

// MARK: - TableViewDelegate & DataSource
