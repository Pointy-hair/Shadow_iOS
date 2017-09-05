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
    
    @IBOutlet weak var lbl_Ratings: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        DispatchQueue.main.async {
            
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
            
            //corner radius profile image
            
            self.imgView_UserProfile.layer.cornerRadius = 30.0
            self.imgView_UserProfile.clipsToBounds = true
            
            
            
            
        }
        
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func DataToCell(dictionary:NSDictionary)  {
        
        DispatchQueue.main.async {
            
            
            if My_Request_Selected_Status == true{//mY request selected
                
                //setting status if my request is selected
                if dictionary.value(forKey: "accept") as? NSNumber == 0 &&  dictionary.value(forKey: "reject") as? NSNumber == 0 {
                    
                    self.lbl_RequestStatus.isHidden = true
                    self.btn_Decline.isHidden = false
                    self.btn_Accept.isHidden = false
                    
                }
            }
                
            else{
                //setting status if shadow request is selected
                if dictionary.value(forKey: "accept") as? NSNumber == 0 &&  dictionary.value(forKey: "reject") as? NSNumber == 0 {
                    
                    self.lbl_RequestStatus.isHidden = false
                    self.lbl_RequestStatus.text = "PENDING"
                    self.lbl_RequestStatus.textColor = UIColor.orange
                    self.btn_Decline.isHidden = true
                    self.btn_Accept.isHidden = true
                }
            }
            
            //if request is accepted
            if dictionary.value(forKey: "accept") as? NSNumber == 1 &&  dictionary.value(forKey: "reject") as? NSNumber == 0{
                self.lbl_RequestStatus.isHidden = false
                self.lbl_RequestStatus.text = "ACCEPTED"
                self.lbl_RequestStatus.textColor = Global.macros.themeColor_Green
                self.btn_Decline.isHidden = true
                self.btn_Accept.isHidden = true
                
            }
                //if request is rejected
            else  if dictionary.value(forKey: "reject") as? NSNumber == 1 &&  dictionary.value(forKey: "accept") as? NSNumber == 0{
                self.lbl_RequestStatus.isHidden = false
                self.lbl_RequestStatus.text = "REJECTED"
                self.lbl_RequestStatus.textColor = Global.macros.themeColor_Red
                self.btn_Decline.isHidden = true
                self.btn_Accept.isHidden = true
                
            }
            
            //setting user info
            let dict_UserInfo = dictionary.value(forKey: "userDTO") as! NSDictionary
            
            if dict_UserInfo.value(forKey: Global.macros.krole) as? String == "USER"{
                self.lbl_UserName.text = (dict_UserInfo.value(forKey: "userName") as? String)?.capitalizingFirstLetter()
            }
            else if dict_UserInfo.value(forKey: Global.macros.krole) as? String == "SCHOOL"{
                
                self.lbl_UserName.text = (dict_UserInfo.value(forKey: "schoolDTO") as? NSDictionary)?.value(forKey: "name") as? String
                
            }else if dict_UserInfo.value(forKey: Global.macros.krole) as? String == "COMPANY"{
                
                self.lbl_UserName.text = (dict_UserInfo.value(forKey: "companyDTO") as? NSDictionary)?.value(forKey: "name") as? String
            }
            
                let str_profileImage = dict_UserInfo.value(forKey: "profileImageUrl") as? String
                if str_profileImage != nil{
                    self.imgView_UserProfile.sd_setImage(with: URL.init(string: str_profileImage!), placeholderImage: UIImage.init(named: "dummySearch"))
                }
                
                self.lbl_TotalRatingCount.text = "\((dict_UserInfo).value(forKey: "ratingCount")!)"
            
            if self.lbl_TotalRatingCount.text == "0" || self.lbl_TotalRatingCount.text == "1" {
                self.lbl_Ratings.text = "rating"
            }
            else {
                 self.lbl_Ratings.text = "ratings"
            }
                
                let str_avgRating = ((dict_UserInfo).value(forKey: "avgRating") as? NSNumber)?.stringValue
                
                let dbl = 2.0
                if  dbl.truncatingRemainder(dividingBy: 1) == 0{
                    self.lbl_AverageRating.text = str_avgRating! + ".0"
                }
                else{
                    self.lbl_AverageRating.text = str_avgRating!
                }
            
            //setting date
            if  dictionary["selectedDate"] != nil{
                let date_String = dictionary.value(forKey: "selectedDate") as? String
                if date_String != nil{
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    let s = dateFormatter.date(from: date_String!)
                    let formatter = DateFormatter()
                    formatter.dateFormat = "MMMM dd,yyyy"
                    self.lbl_Date.text = formatter.string(from: s!).uppercased()
                }
            }
            else{
                self.lbl_Date.text = ""
            }
            
            //Setting time
            if dictionary["timeAgo"] != nil {
                let time : NSString = dictionary["timeAgo"] as! NSString
                
                print(time)
                let delimiter = " "
                var token = time.components(separatedBy: delimiter)
                
                if token[1].contains("m")
                {
                    self.lbl_Time.text = (token[0]) + "m"
                    
                }
                else if token[1].contains("d") {
                    
                    self.lbl_Time.text = (token[0]) + "d"
                    
                }
                else if token[1].contains("h") {
                    
                    self.lbl_Time.text = (token[0]) + "h"
                    
                }
                    
                else {
                    self.lbl_Time.text = "Now"
                    
                }

            }
                
                
            }
        }
}
