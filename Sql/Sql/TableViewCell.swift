//
//  TableViewCell.swift
//  Sql
//
//  Created by Jay Vasdewani on 27/06/18.
//  Copyright © 2018 Jay Vasdewani. All rights reserved.
//

import UIKit

protocol cellDelegate {
    func didTapDelete(tag: Int)
}

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblFName: UILabel!
    @IBOutlet weak var lblLname: UILabel!
    @IBOutlet weak var lblNumber: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    
    var delegate : cellDelegate? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func btnDelete(sender : UIButton){
        delegate?.didTapDelete(tag: tag)
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
