//
//  SSAddArduinoFunctionTableViewCell.swift
//  ArduinoController-ios
//
//  Created by Saee Saadat on 2/18/21.
//

import UIKit

class SSAddArduinoFunctionTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var signalLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCell(model: SSArduinoFunction) {
        nameLabel.text = model.name
        signalLabel.text = model.signalCode
    }

    override func setSelected(_ selected: Bool, animated: Bool) {}
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {}
    
}
