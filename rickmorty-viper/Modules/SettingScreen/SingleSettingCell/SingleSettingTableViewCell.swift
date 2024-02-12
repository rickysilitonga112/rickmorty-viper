//
//  SingleSettingTableViewCell.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 12/02/24.
//

import UIKit

class SingleSettingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var iconContainerView: UIView!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    static let identifier = String(describing: SingleSettingTableViewCell.self)
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayer()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconView.image = nil
        titleLabel.text = nil
    }
    
    private func setupLayer() {
        iconContainerView.clipsToBounds = true
        iconContainerView.layer.cornerRadius = 6
        
        iconView.tintColor = .white
        iconView.contentMode = .scaleAspectFit
    }
    
    func configure(with section: SettingSectionType) {
        iconView.image = section.iconImage
        titleLabel.text = section.title
        iconContainerView.backgroundColor = section.containerColor
    }
    
}
