//
//  TableViewCell.swift
//  SQltask
//
//  Created by agile on 5/14/18.
//  Copyright © 2018 agile. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet var lblStudentName:UILabel!
    @IBOutlet var lblStudentPer:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
