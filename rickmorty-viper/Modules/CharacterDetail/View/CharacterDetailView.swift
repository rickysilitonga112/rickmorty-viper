//
//  CharacterDetailView.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 02/02/24.
//

import UIKit
import RxSwift

class CharacterDetailView: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let bag = DisposeBag()
    
    var character: Character?
    var presenter: CharacterDetailPresenter?
    private var sections: [CharacterDetailSection] = []
    private var episodes: [Episode] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        if let character = character {
            title = character.name
        } else {
            title = "Character Detail"
        }
        
        setupFetchData()
        setupSections()
        setupCollectionView()
    }
    
    
    // MARK: - Private
    
    private func setupFetchData() {
        guard let presenter = presenter,
              let character = character else {
            return
        }
        
        for urlString in character.episode {
            if let url = URL(string: urlString) {
                presenter.fetchEpisode(from: url)
                    .asObservable()
                    .subscribe(onNext: { [weak self] episode in
                        if let episode = episode {
                            self?.episodes.append(episode)
                        }
                    }, onError: { error in
                        print(error)
                    }).disposed(by: bag)
            }
        }
        
        print(String(describing: episodes.count))
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            return self.createSection(for: sectionIndex)
        }
        collectionView.collectionViewLayout = layout
        
        // register character phtoto cell
        collectionView.register(CharacterDetailPhotoCollectionViewCell.nib(), forCellWithReuseIdentifier: CharacterDetailPhotoCollectionViewCell.identifier)
        
        // register character info cell
        collectionView.register(CharacterInfoCollectionViewCell.nib(), forCellWithReuseIdentifier: CharacterInfoCollectionViewCell.identifier)
        
        // register episode cell
        collectionView.register(CharacterDetailEpisodeCollectionViewCell.nib(), forCellWithReuseIdentifier: CharacterDetailEpisodeCollectionViewCell.identifier)
    }
    
    /// setup a section for the character detail view
    private func setupSections() {
        guard let character = character,
              let url = URL(string: character.image) else { return }
        
        sections = [
            .photo(url: url),
            .info(data: [
                .init(type: .status, value: character.status.text),
                .init(type: .gender, value: character.gender.rawValue),
                .init(type: .type, value: character.type),
                .init(type: .species, value: character.species),
                .init(type: .origin, value: character.origin.name),
                .init(type: .location, value: character.location.name),
                .init(type: .created, value: character.created),
                .init(type: .episodeCount, value: "\(character.episode.count)"),
            ]),
            .episodes(urlStrings: character.episode)
        ]
    }
    
    /// Create a section layout based on the section type
    /// - Parameter sectionIndex: index of the section
    /// - Returns: collection layout based on the section
    private func createSection(for sectionIndex: Int) -> NSCollectionLayoutSection {
        let section = sections[sectionIndex]
        
        switch section {
        case .photo:
            return createPhotoSectionLayout()
        case .info:
            return createInfoSectionLayout()
        case .episodes:
            return createEpisodesSectionLayout()
        }
    }
    
    // MARK: - Public
}


// MARK: - CollectionViewDelegate
extension CharacterDetailView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

// MARK: - CollectionViewDataSource
extension CharacterDetailView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = sections[section]
        
        switch section {
        case .photo:
            return 1
        case .info(let infoSections):
            return infoSections.count
        case .episodes(let urls):
            return urls.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = sections[indexPath.section]
        
        switch section {
        case .photo(let url):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterDetailPhotoCollectionViewCell.identifier, for: indexPath) as? CharacterDetailPhotoCollectionViewCell else {
                fatalError("Error cast CharacterDetailPhotoCollectionViewCell")
            }
           
            cell.configure(with: url)
            return cell
        case .info(let characterInfo):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterInfoCollectionViewCell.identifier, for: indexPath) as? CharacterInfoCollectionViewCell else {
                fatalError("Error cast CharacterInfoCollectionViewCell")
            }
            cell.configure(with: characterInfo[indexPath.row])
            return cell
        case .episodes:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterDetailEpisodeCollectionViewCell.identifier, for: indexPath) as? CharacterDetailEpisodeCollectionViewCell else {
                fatalError("Error cast CharacterDetailEpisodeCollectionViewCell")
            }
            
            cell.configure(with: episodes[indexPath.row])
            
            return cell
        }
    }
    
}

// MARK: - CollectionViewFlowLayout
extension CharacterDetailView: UICollectionViewDelegateFlowLayout {

}

// MARK: - SECTION LAYOUT
// setup layout for every collection section on the character detail view
extension CharacterDetailView {
    private func createPhotoSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 0,
            bottom: 10,
            trailing: 0
        )
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(0.5)
            ),
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    private func createInfoSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 2,
            leading: 2,
            bottom: 2,
            trailing: 2
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(150)
            ),
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    private func createEpisodesSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 10,
            leading: 5,
            bottom: 10,
            trailing: 8
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.8),
                heightDimension: .absolute(150)
            ),
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
}

