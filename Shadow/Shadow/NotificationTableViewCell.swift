//
//  NotificationTableViewCell.swift
//  Shadow
//
//  Created by Aditi on 24/08/17.
//  Copyright © 2017 Atinderjit Kaur. All rights reserved.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {

    
    @IBOutlet var imgView_Notification: UIImageView!
    @IBOutlet var lbl_Notification: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func dataToCell(dict:NSDictionary){
        
        DispatchQueue.main.async {
            
            let dict_UserInfo = (dict.value(forKey: "requestDTO") as! NSDictionary).value(forKey: "userDTO") as! NSDictionary
         
            let str_profileImage = dict_UserInfo.value(forKey: "profileImageUrl") as? String
            if str_profileImage != nil{
                
                self.imgView_Notification.sd_setImage(with: URL.init(string: str_profileImage!), placeholderImage: UIImage.init(named: "dummySearch"))
                
            }
            
            //setting user info
            if dict_UserInfo.value(forKey: Global.macros.krole) as? String == "USER"{
                
                if dict.value(forKey: Global.macros.kAccept) as? NSNumber == 1 && dict.value(forKey: Global.macros.kAccept) as? NSNumber == 0{
                    
                }
                else if dict.value(forKey: Global.macros.kAccept) as? NSNumber == 0 && dict.value(forKey: Global.macros.kAccept) as? NSNumber == 1{
                    
                }
                else{
                    
                }
               
            }
            else if dict_UserInfo.value(forKey: Global.macros.krole) as? String == "SCHOOL"{
                
                let school_name = dict_UserInfo.value(forKey: Global.macros.kschoolName) as? String
                
                if dict.value(forKey: Global.macros.kAccept) as? NSNumber == 1 && dict.value(forKey: Global.macros.kAccept) as? NSNumber == 0{
                    self.lbl_Notification.text = "\(school_name) has accepted your request."
                }
                else if dict.value(forKey: Global.macros.kAccept) as? NSNumber == 0 && dict.value(forKey: Global.macros.kAccept) as? NSNumber == 1{
                    self.lbl_Notification.text = "\(school_name) has rejected your request."
                }
                else{
                    
                }
                
            }else if dict_UserInfo.value(forKey: Global.macros.krole) as? String == "COMPANY"{
                
                let company_name = dict_UserInfo.value(forKey: Global.macros.kcompanyName) as? String

                if dict.value(forKey: Global.macros.kAccept) as? NSNumber == 1 && dict.value(forKey: Global.macros.kAccept) as? NSNumber == 0{
                    self.lbl_Notification.text = "\(company_name) has accepted your request."

                }
                else if dict.value(forKey: Global.macros.kAccept) as? NSNumber == 0 && dict.value(forKey: Global.macros.kAccept) as? NSNumber == 1{
                    self.lbl_Notification.text = "\(company_name) has rejected your request."

                }
                else{
                    
                }
                
            }
            
            
            
        }
        
        
        
    }
    
    
}
