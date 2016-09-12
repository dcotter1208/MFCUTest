//
//  CUBranchLocationCell.swift
//  MFCUTest
//
//  Created by Cotter on 9/9/16.
//  Copyright © 2016 Cotter. All rights reserved.
//

import UIKit

class CUBranchLocationCell: UITableViewCell {
    @IBOutlet weak var branchNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var branchDetailsLabel: UILabel!
    @IBOutlet weak var distance: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
