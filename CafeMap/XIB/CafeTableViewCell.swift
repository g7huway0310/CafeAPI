//
//  TableViewCell.swift
//  PhotowallAPI
//
//  Created by guowei on 2020/8/12.
//  Copyright © 2020 guowei. All rights reserved.
//

import UIKit

class CafeTableViewCell: UITableViewCell {

    @IBOutlet weak var cafeAddress: UILabel!
    @IBOutlet weak var cafeName: UILabel!
    @IBOutlet weak var limitTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
