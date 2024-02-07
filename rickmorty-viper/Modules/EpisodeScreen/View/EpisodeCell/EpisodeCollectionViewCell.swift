//
//  EpisodeCollectionViewCell.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 05/02/24.
//

import UIKit

class EpisodeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var seasonLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var airDateLabel: UILabel!
    
    static let identifier = String(describing: EpisodeCollectionViewCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayer()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        seasonLabel.text = nil
        nameLabel.text = nil
        airDateLabel.text = nil
    }
    
    private func setupLayer() {
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.secondaryLabel.cgColor
        contentView.layer.cornerRadius = 8
    }

    // MARK: - Public
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    public func configure(with episode: Episode) {
        seasonLabel.text = "Episode \(episode.episode)"
        nameLabel.text = episode.name
        airDateLabel.text = "Aired on \(episode.air_date)"
    }
}
