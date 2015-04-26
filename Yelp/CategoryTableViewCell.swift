//
//  CategoryTableViewCell.swift
//  Yelp
//
//  Created by Ho-Hsiang Wu on 4/25/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol CategoryTableViewCellDelegate: class {
    optional func categoryCell(categoryCell: CategoryTableViewCell, didChangeSwitchValue value: Bool)
}

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categorySwitch: UISwitch!

    weak var delegate: CategoryTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func switchValueChanged(sender: AnyObject) {
        delegate!.categoryCell?(self, didChangeSwitchValue: categorySwitch.on)
    }
}
