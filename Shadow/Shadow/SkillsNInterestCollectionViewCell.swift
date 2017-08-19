

//
//  SkillsNInterestCollectionViewCell.swift
//  Shadow
//
//  Created by Atinderjit Kaur on 09/06/17.
//  Copyright © 2017 Atinderjit Kaur. All rights reserved.
//

import UIKit

class SkillsNInterestCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var lbl_Skill: UILabel!
    
    override func awakeFromNib() {
        
        contentView.layer.cornerRadius = 5.0
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.init(red: 153.0/255.0, green: 143.0/255.0, blue: 189.0/255.0, alpha: 1.0).cgColor
        contentView.clipsToBounds = true
        
    }

}
