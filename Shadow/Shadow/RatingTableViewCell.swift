//
//  RatingTableViewCell.swift
//  Shadow
//
//  Created by Atinderjit Kaur on 19/06/17.
//  Copyright © 2017 Atinderjit Kaur. All rights reserved.
//

import UIKit

class RatingTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var imgview_Profile: UIImageView!
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var txtView_Comment: UITextView!
    @IBOutlet weak var imgView_Rating1: UIImageView!
    @IBOutlet weak var imgView_Rating2: UIImageView!
    @IBOutlet weak var imgView_Rating3: UIImageView!
    @IBOutlet weak var imgView_Rating4: UIImageView!
    @IBOutlet weak var imgView_Rating5: UIImageView!
    @IBOutlet weak var lbl_time: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        DispatchQueue.main.async {
            self.imgview_Profile.layer.cornerRadius = 20.0
            self.imgview_Profile.clipsToBounds = true
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
