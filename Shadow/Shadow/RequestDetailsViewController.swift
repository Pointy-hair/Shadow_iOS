//
//  RequestDetailsViewController.swift
//  Shadow
//
//  Created by Aditi on 18/08/17.
//  Copyright © 2017 Atinderjit Kaur. All rights reserved.
//

import UIKit

class RequestDetailsViewController: UIViewController {

    @IBOutlet var scroll_View: UIScrollView!
    @IBOutlet var imgView_UserProfile: UIImageView!
    @IBOutlet var lbl_AverageRating: UILabel!
    @IBOutlet var lbl_RatingPersonCount: UILabel!
    @IBOutlet var view_Location: UIView!
    @IBOutlet var lbl_Location: UILabel!
    @IBOutlet var view_VirtualMedium: UIView!
    @IBOutlet var calender: FSCalendar!
    @IBOutlet var txtView_Message: UITextView!
    @IBOutlet var lbl_TxtView_Placeholder: UILabel!
    @IBOutlet var view_Buttons: UIView!
    @IBOutlet var btn_Accept: UIButton!
    @IBOutlet var btn_Decline: UIButton!
    @IBOutlet var btn_AcceptedRejected: UIButton!
    @IBOutlet var lbl_VirtualMedium: UILabel!
    @IBOutlet var view_LblVirtualMedium: UIView!
    @IBOutlet var view_LblLocation: UIView!
    
    var username:String?
    var request_Id:NSNumber?
    fileprivate var video_url : URL?
    fileprivate var Dict_Info  = NSDictionary()

    
    override func viewDidLayoutSubviews() {
        self.scroll_View.contentSize = CGSize.init(width: self.view.frame.width, height: 800)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.async {
            
           // self.navigationItem.title = self.username!
            self.navigationItem.setHidesBackButton(false, animated:true)
            self.CreateNavigationBackBarButton()
            
            self.imgView_UserProfile.layer.cornerRadius = 60.0
            self.imgView_UserProfile.clipsToBounds = true
            
            self.calender.layer.borderWidth = 1.0
            self.calender.layer.borderColor = UIColor.darkGray.cgColor
            self.calender.layer.cornerRadius = 3.0
            
            self.btn_Accept.layer.cornerRadius = 8.0
            self.btn_Accept.layer.borderWidth = 1.0
            self.btn_Accept.layer.borderColor = Global.macros.themeColor.cgColor
            
            self.btn_Decline.layer.cornerRadius = 5.0
            self.btn_Decline.layer.borderWidth = 1.0
            self.btn_Decline.layer.borderColor = Global.macros.themeColor.cgColor
            
            self.btn_AcceptedRejected.layer.cornerRadius = 8.0
            self.btn_AcceptedRejected.layer.borderWidth = 1.0
            self.btn_AcceptedRejected.layer.borderColor = Global.macros.themeColor.cgColor

            self.txtView_Message.layer.cornerRadius = 5.0
            self.txtView_Message.layer.borderWidth = 1.0
            self.txtView_Message.layer.borderColor = Global.macros.themeColor.cgColor

            self.view_LblLocation.layer.cornerRadius = 5.0
            self.view_LblLocation.layer.borderWidth = 1.0
            self.view_LblLocation.layer.borderColor = Global.macros.themeColor.cgColor
            
            self.view_LblVirtualMedium.layer.cornerRadius = 5.0
            self.view_LblVirtualMedium.layer.borderWidth = 1.0
            self.view_LblVirtualMedium.layer.borderColor = Global.macros.themeColor.cgColor
            
            //nav buttons
            let btn_chat = UIButton(type: .custom)
            btn_chat.setImage(UIImage(named: "chat-icon"), for: .normal)
            btn_chat.frame = CGRect(x: self.view.frame.size.width - 20, y: 0, width: 20, height: 25)
            btn_chat.addTarget(self, action: #selector(self.chatBtnPressed), for: .touchUpInside)
            let item_chat = UIBarButtonItem(customView: btn_chat)
            //Right items
            self.navigationItem.setRightBarButtonItems([item_chat], animated: true)
            
            
        }
        
        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        self.setRequestData()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Button Actions
    @IBAction func action_OpenVideo(_ sender: UIButton) {
        
        if video_url != nil {
            
            bool_PlayFromProfile = true
            let vc = Global.macros.Storyboard.instantiateViewController(withIdentifier: "Upload_Video") as! UploadViewController
            _ = self.navigationController?.pushViewController(vc, animated: true)
        }
        else{
            self.showAlert(Message: "No video to play yet.", vc: self)
        }
    }

    @IBAction func action_Accept(_ sender: UIButton) {
        
        //selected button
        self.btn_Accept.setTitleColor(UIColor.white, for: .normal)
        self.btn_Accept.backgroundColor = UIColor.lightGray
        
        //deselected button
        self.btn_Decline.setTitleColor(UIColor.lightGray, for: .normal)
        self.btn_Decline.backgroundColor = UIColor.white

        self.request_AcceptReject(acceptStatus: "true", rejectStatus: "false")
        
        
        
        
    }
    
    @IBAction func action_Decline(_ sender: UIButton) {
        
        
        //selected button
        self.btn_Decline.setTitleColor(UIColor.white, for: .normal)
        self.btn_Decline.backgroundColor = UIColor.lightGray

        
        //deselected button
        self.btn_Accept.setTitleColor(UIColor.lightGray, for: .normal)
        self.btn_Accept.backgroundColor = UIColor.white
        
        self.request_AcceptReject(acceptStatus: "false", rejectStatus: "true")

    }
    
    
    @IBAction func action_OpenRatings(_ sender: UIButton) {
        
//        bool_UserIdComingFromSearch = true
//        userIdFromSearch = self.Dict_Info.value(forKey: "userId") as? NSNumber
//        //ratingview_name = self.Dict_Info.value(forKey: "userId") as? String
//        
//        let vc = Global.macros.Storyboard.instantiateViewController(withIdentifier: "ratingView") as! RatingViewController
//        _ = self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    //MARK: - Functions
    func setRequestData()  {
        
        let dict = NSMutableDictionary()
        let  user_Id = SavedPreferences.value(forKey: Global.macros.kUserId) as? NSNumber
        dict.setValue(user_Id, forKey: Global.macros.kUserId)
        dict.setValue(self.request_Id!, forKey: "id")
        print(dict)

        if self.checkInternetConnection(){
            
            DispatchQueue.main.async {
                self.pleaseWait()
            }
            
            Requests_API.sharedInstance.viewRequest(completionBlock: { (status, dict_Info) in
              
                DispatchQueue.main.async {
                    self.clearAllNotice()
                }
                
                switch status {
                    
                case 200:
                    
                    DispatchQueue.main.async {
                       
                      self.Dict_Info = dict_Info
                      //Set Info of request
                        //setting location
                        if dict_Info[Global.macros.klocation] != nil {
                            
                            self.view_Location.isHidden = false
                            self.view_VirtualMedium.isHidden = true
                            self.lbl_Location.text = dict_Info.value(forKey: Global.macros.klocation) as? String
                            
                        }
                            //setting virtual medium
                        else if  dict_Info[Global.macros.k_mediumOfCommunication] != nil{
                            
                            self.view_Location.isHidden = true
                            self.view_VirtualMedium.isHidden = false
                            self.lbl_VirtualMedium.text = dict_Info.value(forKey: Global.macros.k_mediumOfCommunication) as? String
                            
                        }
                        
                       //setting message
                        if dict_Info["message"] != nil &&  dict_Info["message"] as? String != ""{
                            
                            self.lbl_TxtView_Placeholder.isHidden = true
                            self.txtView_Message.text = dict_Info.value(forKey: "message") as? String
                        }
                        else{
                            
                            self.lbl_TxtView_Placeholder.isHidden = false
 
                        }
                        
                        //request status(Accepted,Rejected or pending)
                        //pending
                        if dict_Info.value(forKey: "reject") as? NSNumber == 0 &&  dict_Info.value(forKey: "accept") as? NSNumber == 0{
                           
                            self.view_Buttons.isHidden = false
                            self.btn_AcceptedRejected.isHidden = true

                            
                        }
                        //(Accepted)
                        else if dict_Info.value(forKey: "reject") as? NSNumber == 0 &&  dict_Info.value(forKey: "accept") as? NSNumber == 1{
                            
                            self.view_Buttons.isHidden = true
                            self.btn_AcceptedRejected.isHidden = false
                            self.btn_AcceptedRejected.setTitle("Accepted", for: .normal)
                            self.btn_AcceptedRejected.backgroundColor = Global.macros.themeColor_Green
                        }
                            //(Accepted)
                        else if dict_Info.value(forKey: "reject") as? NSNumber == 1 &&  dict_Info.value(forKey: "accept") as? NSNumber == 0{
                            
                            self.view_Buttons.isHidden = true
                            self.btn_AcceptedRejected.isHidden = false
                            self.btn_AcceptedRejected.setTitle("Rejected", for: .normal)
                            self.btn_AcceptedRejected.backgroundColor = Global.macros.themeColor_Red
                            
                        }

                        //set profile image
                        let str_profileImage = (dict_Info.value(forKey: "userDTO")as! NSDictionary).value(forKey: "profileImageUrl") as? String
                        if str_profileImage != nil{
                            
                            self.imgView_UserProfile.sd_setImage(with: URL.init(string: str_profileImage!), placeholderImage: UIImage.init(named: "dummySearch"))
                            
                        }
                        
                        ratingview_imgurl = str_profileImage
                        
                        //setting ratings
                        self.lbl_RatingPersonCount.text = "\((dict_Info.value(forKey: "userDTO")as! NSDictionary).value(forKey: "ratingCount")!)"
                        
                        
                        //setting average rating
                        let str_avgRating = ((dict_Info.value(forKey: "userDTO")as! NSDictionary).value(forKey: "avgRating") as? NSNumber)?.stringValue
                        
                        let dbl = 2.0
                        
                        if  dbl.truncatingRemainder(dividingBy: 1) == 0
                        {
                            self.lbl_AverageRating.text = str_avgRating! + ".0"
                            
                        }
                        else {
                            
                            self.lbl_AverageRating.text = str_avgRating!
                            
                        }

                        //get video url
                        let str_video =  dict_Info.value(forKey: "videoUrl") as? String  //Video url to play video
                        if str_video != nil {
                            self.video_url = NSURL(string: str_video!) as? URL
                        }
                        else{
                            self.video_url = nil
                        }

                        //setting username
                        
                        
                        if  (dict_Info.value(forKey: "userDTO")as! NSDictionary).value(forKey: Global.macros.krole) as? String == "USER"{
                           
                            self.navigationItem.title = ((dict_Info.value(forKey: "userDTO")as! NSDictionary).value(forKey: "userName") as? String)?.capitalizingFirstLetter()
                        }
                        else if (dict_Info.value(forKey: "userDTO")as! NSDictionary).value(forKey: Global.macros.krole) as? String == "SCHOOL"{
                            
                             self.navigationItem.title = ((dict_Info.value(forKey: "userDTO")as! NSDictionary).value(forKey: "schoolDTO") as? NSDictionary)?.value(forKey: "name") as? String
                            
                        }else if (dict_Info.value(forKey: "userDTO")as! NSDictionary).value(forKey: Global.macros.krole) as? String == "COMPANY"{
                            
                             self.navigationItem.title = ((dict_Info.value(forKey: "userDTO")as! NSDictionary).value(forKey: "companyDTO") as? NSDictionary)?.value(forKey: "name") as? String
                            
                        }

                        ratingview_name = self.navigationItem.title
                        
                        
                        
                    }
                    
                    break
                    
                case 404:
                    
                    DispatchQueue.main.async {
                        
                        
                    }
                    
                    
                    
                    
                    break
                default:
                    self.showAlert(Message: Global.macros.kError, vc: self)
                    break
                    
                }
   
                
            }, errorBlock: { (error) in
                DispatchQueue.main.async {
                    self.clearAllNotice()
                    self.showAlert(Message: Global.macros.kInternetConnection, vc: self)
                }
            }, dictionary: dict)
            
            
        }else{
            
            self.showAlert(Message: Global.macros.kInternetConnection, vc: self)
        }
        
        
    }
    
    func request_AcceptReject(acceptStatus:String,rejectStatus:String) {
        
        
        let request_id = (Dict_Info).value(forKey: "id") as? NSNumber
        let dict = NSMutableDictionary()
        let  user_Id = SavedPreferences.value(forKey: Global.macros.kUserId) as? NSNumber
        dict.setValue(user_Id, forKey: Global.macros.kUserId)
        dict.setValue(request_id, forKey: Global.macros.kId)
        dict.setValue(acceptStatus, forKey: Global.macros.kAccept)
        dict.setValue(rejectStatus, forKey: Global.macros.kSmallReject)
        
        print(dict)
        if self.checkInternetConnection(){
            
            DispatchQueue.main.async {
                self.pleaseWait()
            }
            
            Requests_API.sharedInstance.requestAcceptReject(completionBlock: { (status, dict_Info) in
                DispatchQueue.main.async {
                    self.clearAllNotice()
                }
                
                switch status {
                    
                case 200:
                    
                    DispatchQueue.main.async {
                        if acceptStatus == "true"{
                        self.showAlert(Message: "Successfully accepted", vc: self)
                        }else{
                            self.showAlert(Message: "Successfully rejected.", vc: self)
                        }
                        self.setRequestData()
                    }
                    
                    break
                    
                case 404:
                    
                    DispatchQueue.main.async {
                        self.showAlert(Message: Global.macros.kError, vc: self)

                    }
                    
                    break
                default:
                    self.showAlert(Message: Global.macros.kError, vc: self)
                    break
                    
                }
                
                
                
            }, errorBlock: { (error) in
                DispatchQueue.main.async {
                    self.clearAllNotice()
                    self.showAlert(Message: Global.macros.kError, vc: self)
                }
                
            }, dict: dict)
            
        }else{
            self.showAlert(Message: Global.macros.kInternetConnection, vc: self)
        }
        
    }

    func chatBtnPressed(sender: AnyObject){
        self.showAlert(Message: "Coming Soon", vc: self)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
