//
//  MySkillsTableViewCell.swift
//  Shadow
//
//  Created by Aditi on 08/06/17.
//  Copyright © 2017 Atinderjit Kaur. All rights reserved.
//

import UIKit

class MySkillsTableViewCell: UITableViewCell {

    
    @IBOutlet var lbl_MyskillName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func DataOfMySkills(dict:NSDictionary)
    {
         lbl_MyskillName.text = dict.value(forKey: "name") as? String
    }

}
