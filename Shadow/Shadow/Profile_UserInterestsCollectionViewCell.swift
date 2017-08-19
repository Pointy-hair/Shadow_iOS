//
//  Profile_UserInterestsCollectionViewCell.swift
//  Shadow
//
//  Created by Aditi on 03/07/17.
//  Copyright © 2017 Atinderjit Kaur. All rights reserved.
//

import UIKit

class Profile_UserInterestsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var lbl_InterestName: UILabel!
    
    
    override func awakeFromNib() {
        
        
        contentView.layer.cornerRadius = 5.0
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.init(red: 153.0/255.0, green: 143.0/255.0, blue: 189.0/255.0, alpha: 1.0).cgColor
        contentView.clipsToBounds = true
        
    }

}
