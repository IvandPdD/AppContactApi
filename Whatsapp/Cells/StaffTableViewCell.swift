//
//  StaffTableViewCell.swift
//  Whatsapp
//
//  Created by user176708 on 3/7/21.
//  Copyright © 2021 alumnos. All rights reserved.
//

import Foundation
import UIKit

class StaffTableViewCell : UITableViewCell{
    
    @IBOutlet weak var labelName: UILabel!
    
    @IBOutlet weak var labelPhone: UILabel!
    
    @IBOutlet weak var labelEmail: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
            // Initialization code
    }
    
    //celda de table view

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

            // Configure the view for the selected state
    }
    
}
