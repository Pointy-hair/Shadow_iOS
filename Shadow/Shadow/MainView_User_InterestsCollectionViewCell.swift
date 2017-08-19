//
//  MainView_User_InterestsCollectionViewCell.swift
//  Shadow
//
//  Created by Aditi on 03/07/17.
//  Copyright © 2017 Atinderjit Kaur. All rights reserved.
//

import UIKit

class MainView_User_InterestsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var lbl_InterestName: UILabel!
    
    override func awakeFromNib() {
        
        contentView.layer.cornerRadius = 5.0
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = Global.macros.themeColor.cgColor
        contentView.clipsToBounds = true
    }
}
