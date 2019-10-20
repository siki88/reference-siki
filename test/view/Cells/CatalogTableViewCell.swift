//
//  CatalogTableViewCell.swift
//  test
//
//  Created by Lukáš Spurný on 19/10/2019.
//  Copyright © 2019 sikisift. All rights reserved.
//

import UIKit

class CatalogTableViewCell: UITableViewCell {
    
    @IBOutlet weak var backdrop_path: UIImageView!
    @IBOutlet weak var original_title: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
