//
//  ActualSocialSitesTableViewCell.swift
//  Shadow
//
//  Created by Aditi on 28/06/17.
//  Copyright © 2017 Atinderjit Kaur. All rights reserved.
//

import UIKit

class ActualSocialSitesTableViewCell: UITableViewCell {
    
    @IBOutlet var img_View_UserSocialSites: UIImageView!
    @IBOutlet var lbl_UserSocialSites: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func DataToCell(dict:NSDictionary){
        lbl_UserSocialSites.text = dict.value(forKey: "name") as? String
    }

}
