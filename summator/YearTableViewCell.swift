//
//  YearTableViewCell.swift
//  summator
//
//  Created by Alexey Pichukov on 11.02.17.
//  Copyright © 2017 Alexey Pichukov. All rights reserved.
//

import UIKit

class YearTableViewCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sumLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.layer.cornerRadius = mainView.frame.width / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setYear(_ year: Year) {
        nameLabel.text = year.name
        sumLabel.text = String("$ \(year.sum)")
    }
    
}
