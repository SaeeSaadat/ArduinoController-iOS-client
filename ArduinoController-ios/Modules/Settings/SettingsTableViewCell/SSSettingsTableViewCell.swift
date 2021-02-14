//
//  SSSettingsTableViewCell.swift
//  ArduinoController-ios
//
//  Created by Saee Saadat on 2/14/21.
//

import UIKit

class SSSettingsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var separator: UIView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCell(title: String, icon: UIImage?, tint: UIColor = SSColors.accent.color, isLast: Bool = false) {
        
        self.titleLabel.text = title
        self.iconImageView.image = icon
        
        self.titleLabel.textColor = tint
        self.iconImageView.tintColor = tint
        
        self.separator.isHidden = isLast
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
