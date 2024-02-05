//
//  CharacterScreenView.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 26/01/24.
//

import UIKit
import RxSwift

class CharacterScreenView: UIViewController {
    var bag = DisposeBag()
    
    @IBOutlet weak var characterCollectionView: UICollectionView!
    
    private var presenter: CharacterScreenPresenter?
    private var isLoadingMoreCharacters = false
    public var apiInfo: CharacterEntity.Info? = nil
    private var characters: [Character] = [] {
        didSet {
            characterCollectionView.reloadData()
        }
    }
    
    private var charactersList = PublishSubject<[Character]>()
    public var isShowSpinner: Bool {
        return apiInfo?.next != nil
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Character"
        view.backgroundColor = .systemBackground
        setupCollectionView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupFetchData()
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
    private func setupFetchData() {
        presenter?.fetchInitialCharacter()
            .asObservable()
            .subscribe(onNext: { entity in
                if let characters = entity?.results {
                    self.apiInfo = entity?.info
                    self.characters = characters
                }
            }, onError: { error in
                print(String(describing: error.localizedDescription))
            }).disposed(by: bag)
    }
    
    private func setupCollectionView() {
        let width = (UIScreen.main.bounds.width - 30) / 2
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: width, height: width * 0.3)
        characterCollectionView.collectionViewLayout = layout
        
        characterCollectionView.register(CharacterCollectionViewCell.nib(), forCellWithReuseIdentifier: CharacterCollectionViewCell.identifier)
        // register the loading spinner when load data in footer that used in RMCharacterListView
        
        characterCollectionView.register(RMFooterLoadingCollectionReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: RMFooterLoadingCollectionReusableView.identifier)
        
        characterCollectionView.delegate = self
        characterCollectionView.dataSource = self
    }
    
    private func fetchMoreCharacters() {
        // call the presenter
        guard let nextUrlString = apiInfo?.next,
              let url = URL(string: nextUrlString) else {
            return
        }
        
        presenter?.fetchMoreCharacters(from: url)
            .asObservable()
            .subscribe(onNext: {[weak self] entity in
                guard let self = self else { return }
                
//                print("isLoadingMoreCharacters: \(self.isLoadingMoreCharacters)")
                print("Fetching from: \(url.absoluteString)")
                
                self.apiInfo = entity?.info
                if let newCharacters = entity?.results {
                    self.characters.append(contentsOf: newCharacters)
                    self.isLoadingMoreCharacters = false
                }
            }, onError: { error in
                fatalError("Error fetch more characters with error \(error.localizedDescription)..")
            }).disposed(by: bag)
    }
    
    // MARK: - Public
    
}

// MARK: - CollectionView Delegate
extension CharacterScreenView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO: - goto detail view controller
        collectionView.deselectItem(at: indexPath, animated: true)
        
        guard let presenter = presenter,
              let navigation = navigationController else {
            return
        }
        presenter.navigateToDetailCharacter(from: navigation, with: characters[indexPath.row])
    }
}

// MARK: - CollectionView DataSource
extension CharacterScreenView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.identifier, for: indexPath) as? CharacterCollectionViewCell else {
            fatalError("Error initialize character collection view cell")
        }
        
        cell.configure(with: characters[indexPath.row])
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


// MARK: - ScrollViewDelegate
extension CharacterScreenView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard isShowSpinner,
              !isLoadingMoreCharacters,
              !characters.isEmpty else {
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
            self.isLoadingMoreCharacters = true
            
            Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] t in
                self?.fetchMoreCharacters()
                t.invalidate()
            }
            
        }
    }
}

// MARK: - Footer Spinner
extension CharacterScreenView {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter,
              let footer = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: RMFooterLoadingCollectionReusableView.identifier,
                for: indexPath) as? RMFooterLoadingCollectionReusableView else {
            fatalError("Unsopported")
        }
        
        footer.startAnimating()
        
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard isShowSpinner else {
            return .zero
        }
        
        return CGSize(width: collectionView.frame.width, height: 100)
    }
}
