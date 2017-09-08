//
//  ListingTableViewCell.swift
//  Shadow
//
//  Created by Atinderjit Kaur on 06/09/17.
//  Copyright © 2017 Atinderjit Kaur. All rights reserved.
//

import UIKit

class ListingTableViewCell: UITableViewCell {

    
    @IBOutlet var imgView_Profile: UIImageView!
    @IBOutlet var lbl_username: UILabel!
    @IBOutlet var imgView_Company_loc_school: UIImageView!
    @IBOutlet var lbl_name_loc_com_school: UILabel!
    @IBOutlet var lbl_AvrRatingCount: UILabel!
    @IBOutlet var lbl_ratingUsers: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imgView_Profile.layer.cornerRadius = 25.0
        self.imgView_Profile.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func dataToCell(dictionay:NSDictionary) {
        
        print(dictionay)
        
        DispatchQueue.main.async {
             var user_dict = NSDictionary()
            if dictionay["userDTO"] != nil{
                
                 user_dict = dictionay.value(forKey: "userDTO") as! NSDictionary
            }
            else{
                user_dict = dictionay
            }
            
            let role = user_dict.value(forKey: Global.macros.krole) as? String
            
            if role == "COMPANY" {
                
                //setting name
                if user_dict ["name"] != nil{

                    self.lbl_username.text = (user_dict.value(forKey: "name") as? String)?.capitalized
                }
                else{
                    
                    self.lbl_username.text = (user_dict.value(forKey: "companyName") as? String)?.capitalized

                }
                
            }
            else if role == "USER"{
                
                //setting name
                self.lbl_username.text = (user_dict.value(forKey: "userName") as? String)?.capitalized

                
                
            }
            else if role == "SCHOOL"{
                
                //setting name
                if user_dict ["name"] != nil{
                self.lbl_username.text = (user_dict.value(forKey: "name") as? String)?.capitalized
                }
                else{
                    
                    self.lbl_username.text = (user_dict.value(forKey: "schoolName") as? String)?.capitalized

                }
            }
            
            //setting profile image
            if user_dict["profileImageUrl"] != nil{
                let str_profileImage = user_dict.value(forKey: "profileImageUrl") as? String
                if str_profileImage != nil{
                    
                    self.imgView_Profile.sd_setImage(with: URL.init(string: str_profileImage!), placeholderImage: UIImage.init(named: "dummySearch"))
                }
            }
            
             //setting ratings
            
            
            
            
        }
        
        
        
        
    }

}
