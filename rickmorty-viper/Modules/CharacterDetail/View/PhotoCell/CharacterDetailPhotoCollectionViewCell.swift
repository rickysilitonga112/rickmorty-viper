//
//  CharacterDetailPhotoCollectionViewCell.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 05/02/24.
//

import UIKit
import Kingfisher

class CharacterDetailPhotoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    
    static let identifier = String(describing: CharacterDetailPhotoCollectionViewCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayer()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
    }
    
    private func setupLayer() {
        photoImageView.contentMode = .scaleAspectFill
    }
    
    // MARK: - Public
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    public func configure(with url: URL) {
        print("URL: \(url)")
        photoImageView.kf.setImage(with: url)
    }
}
