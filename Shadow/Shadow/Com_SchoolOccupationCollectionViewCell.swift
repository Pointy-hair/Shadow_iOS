//
//  Com_SchoolOccupationCollectionViewCell.swift
//  Shadow
//
//  Created by Aditi on 27/06/17.
//  Copyright © 2017 Atinderjit Kaur. All rights reserved.
//

import UIKit

class Com_SchoolOccupationCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var lbl_Occupationname: UILabel!
    
    override func awakeFromNib() {
        
        
//        lbl_Occupationname.layer.cornerRadius = 8.0
//        lbl_Occupationname.layer.borderWidth = 1.0
//        lbl_Occupationname.layer.borderColor = Global.macros.themeColor.cgColor
//        lbl_Occupationname.clipsToBounds = true
        
        
        contentView.layer.cornerRadius = 5.0
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.init(red: 153.0/255.0, green: 143.0/255.0, blue: 189.0/255.0, alpha: 1.0).cgColor
        contentView.clipsToBounds = true
        
        
        
        
    }
    
    
}
