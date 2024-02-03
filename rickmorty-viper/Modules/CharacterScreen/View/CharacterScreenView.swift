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
    private var characterImages: [UIImage?] = [] {
        didSet {
            loadCharacterCollection()
        }
    }
    
    private var characters: [Character] = [] {
        didSet {
            presenter?.fetchCharacterImages(from: characters)
                .subscribe(onNext: { characterImages in
                    self.characterImages = characterImages
                }, onError: { _ in
                    fatalError()
                }).disposed(by: bag)
        }
    }
    public var isShowSpinner: Bool {
        return apiInfo?.next != nil
//        return true
    }
    
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
    
    private func loadCharacterCollection() {
        DispatchQueue.main.async {
            self.characterCollectionView.reloadData()
        }
    }
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
        return characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.identifier, for: indexPath) as? CharacterCollectionViewCell else {
            fatalError("Error initialize character collection view cell")
        }
        // MOCK CHARACTER
        let character = characters[indexPath.row]
        let image = characterImages[indexPath.row]
        cell.configure(with: character, image: image)
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
            print("Load more characters with url: \(String(describing: apiInfo?.next))")
//            fetchAdditionalCharacters(url: url)
        }
    }
}
