//
//  ProductsTableViewCell.swift
//  eCommerceAppTask
//
//  Created by Sierra 4 on 15/02/17.
//  Copyright © 2017 Sierra 4. All rights reserved.
//

import UIKit

class ProductsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblProductNameOutlet: UILabel!
    
    @IBOutlet weak var lblProductDescriptionNameOutlet: UILabel!
    
    @IBOutlet weak var lblProductPriceOutlet: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
