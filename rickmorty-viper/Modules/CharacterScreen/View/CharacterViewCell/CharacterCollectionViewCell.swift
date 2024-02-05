//
//  CharacterCollectionViewCell.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 26/01/24.
//

import UIKit
import Kingfisher

class CharacterCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    static let identifier = String(describing: CharacterCollectionViewCell.self)
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = .systemBackground
        containerView.backgroundColor = .systemBackground
        
        setupLayer()
    }
    
    private func setupLayer() {
       contentView.layer.cornerRadius = 4.0
       contentView.layer.masksToBounds = true
       layer.shadowColor = UIColor.lightGray.cgColor
       layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
       layer.shadowOpacity = 0.3
       layer.masksToBounds = false
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        nameLabel.text = nil
        statusLabel.text = nil
    }
    
    // MARK: - private
    
    // MARK: - public
    public func configure(with character: Character) {
        nameLabel.text = character.name
        statusLabel.text = "Status: \(character.status)"
        
        guard let url = URL(string: character.image) else { return }
        imageView.kf.setImage(with: url)
    }
}
