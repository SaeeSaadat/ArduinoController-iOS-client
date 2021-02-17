//
//  SSAddArduinoTableViewCell.swift
//  ArduinoController-ios
//
//  Created by Saee Saadat on 2/17/21.
//

import UIKit

class SSAddArduinoTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var bottomLineHeight: NSLayoutConstraint!
    @IBOutlet weak var topLineHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        let scale: CGFloat = highlighted ? 0.5 : 1.0
        UIView.transition(with: label, duration: 0.2, options: [], animations: {
            self.label.transform = CGAffineTransform(scaleX: scale, y: scale)
        }, completion: nil)
        
        let height: CGFloat = highlighted ? 20 : 1
        UIView.animate(withDuration: 0.2, animations: {
            self.bottomLineHeight.constant = height
            self.topLineHeight.constant = height
            self.contentView.layoutIfNeeded()
        })
    }

}
