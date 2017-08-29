//
//  RequestsListTableViewCell.swift
//  Shadow
//
//  Created by Aditi on 28/08/17.
//  Copyright © 2017 Atinderjit Kaur. All rights reserved.
//

import UIKit

class RequestsListTableViewCell: UITableViewCell {

    @IBOutlet var imgView_UserProfile: UIImageView!
    @IBOutlet var lbl_UserName: UILabel!
    @IBOutlet var lbl_Date: UILabel!
    @IBOutlet var lbl_Time: UILabel!
    @IBOutlet var lbl_RequestStatus: UILabel!
    @IBOutlet var lbl_AverageRating: UILabel!
    @IBOutlet var lbl_TotalRatingCount: UILabel!
    @IBOutlet var btn_Accept: UIButton!
    @IBOutlet var btn_Decline: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.btn_Accept.layer.borderWidth = 1.0
        self.btn_Accept.layer.borderColor = Global.macros.themeColor_pink.cgColor
        self.btn_Accept.layer.cornerRadius = 5.0
        self.btn_Accept.setTitleColor(UIColor.white, for: .normal)
        self.btn_Accept.backgroundColor = Global.macros.themeColor_pink
        
        
        self.btn_Decline.layer.borderWidth = 1.0
        self.btn_Decline.layer.borderColor = Global.macros.themeColor_pink.cgColor
        self.btn_Decline.setTitleColor(Global.macros.themeColor_pink, for: .normal)
        self.btn_Decline.backgroundColor = UIColor.white
        self.btn_Decline.layer.cornerRadius = 5.0

        
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func DataToCell(dictionary:NSDictionary)  {
        
        if dictionary.value(forKey: "accept") as? NSNumber == 0 &&  dictionary.value(forKey: "reject") as? NSNumber == 0 {
            
            lbl_RequestStatus.isHidden = true
            btn_Decline.isHidden = false
            btn_Accept.isHidden = false
            
        }
        else  if dictionary.value(forKey: "accept") as? NSNumber == 1 &&  dictionary.value(forKey: "reject") as? NSNumber == 0{
            lbl_RequestStatus.isHidden = false
            lbl_RequestStatus.text = "ACCEPTED"
            btn_Decline.isHidden = true
            btn_Accept.isHidden = true

        }
        else  if dictionary.value(forKey: "reject") as? NSNumber == 1 &&  dictionary.value(forKey: "accept") as? NSNumber == 0{
            lbl_RequestStatus.isHidden = false
            lbl_RequestStatus.text = "REJECTED"
            btn_Decline.isHidden = true
            btn_Accept.isHidden = true

        }
    }
    
}
