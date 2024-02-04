//
//  CharacterCollectionViewCell.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 26/01/24.
//

import UIKit
import RxSwift

class CharacterCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    static let identifier = String(describing: CharacterCollectionViewCell.self)
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        nameLabel.text = nil
        statusLabel.text = nil
    }
    
    public func configure(with character: Character) {
        nameLabel.text = character.name
        statusLabel.text = "Stautus: \(character.status)"
        
        guard let url = URL(string: character.image) else { return }
        RMImageLoader.shared.downloadImage(url) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                }
            case .failure(let error):
                print(String(describing: error))
                break
            }
        }
    }
}
