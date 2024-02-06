// 
//  EpisodeScreenView.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 26/01/24.
//

import UIKit
import RxSwift

class EpisodeScreenView: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var presenter: EpisodeScreenPresenter?
    
    let bag = DisposeBag()
    private var isLoadingMoreEpisodes = false
    public var apiInfo: EpisodeEntity.Info? = nil
    private var episodes: [Episode] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
//    private var charactersList = PublishSubject<[Character]>()
    public var isShowSpinner: Bool {
        return apiInfo?.next != nil
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Episode"
        view.backgroundColor = .systemBackground
        
        setupCollectionView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchInitialEpisodes()
    }
    
    // MARK: - Private
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let bounds = UIScreen.main.bounds
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: bounds.width - 20, height: 100)
        
        collectionView.collectionViewLayout = layout
        
        
        collectionView.register(EpisodeCollectionViewCell.nib(),
                                forCellWithReuseIdentifier: EpisodeCollectionViewCell.identifier)
        
        // register the loading spinner when load data in footer that used in RMCharacterListView
        collectionView.register(RMFooterLoadingCollectionReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: RMFooterLoadingCollectionReusableView.identifier)
    }
    
    private func fetchInitialEpisodes() {
        guard let presenter = presenter else {
            return
        }
        presenter.fetchInitialEpisodes()
            .asObservable()
            .subscribe {[weak self] entity in
                if let entity = entity {
                    self?.apiInfo = entity.info
                    self?.episodes = entity.results
                }
            } onError: { error in
                fatalError(error.localizedDescription)
            }
            .disposed(by: bag)
    }
    
    private func fetchMoreEpisodes() {
        
    }
}

// MARK: - CollectionView Delegate
extension EpisodeScreenView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        // TODO: Go to detail vc
    }
}

// MARK: - CollectionView DataSource
extension EpisodeScreenView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return episodes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EpisodeCollectionViewCell.identifier, for: indexPath) as? EpisodeCollectionViewCell else {
            fatalError("Failed to cast EpisodeCollectionViewCell")
        }
        cell.configure(with: episodes[indexPath.row])
        return cell
    }
}

// MARK: - CollectionView DataSource
extension EpisodeScreenView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard isShowSpinner,
              !isLoadingMoreEpisodes,
              !episodes.isEmpty else {
            return
        }
        
        let offset = scrollView.contentOffset.y
        let totalContentHeight = scrollView.contentSize.height
        let totalScrollViewFixedHeight = scrollView.frame.size.height
        
        /// this code to fix redundant fetching a more character
        guard offset > 0 else {
            return
        }
        
        if offset >= (totalContentHeight - totalScrollViewFixedHeight - 120) {
            self.isLoadingMoreEpisodes = true
            
            Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] t in
//                self?.fetchMoreEpisodes()
                t.invalidate()
            }
            
        }
    }
}


// MARK: - Footer spinner
extension EpisodeScreenView {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard isShowSpinner else {
            return .zero
        }
        
        return CGSize(
            width: collectionView.frame.width - 20,
            height: 100
        )
    }
}
