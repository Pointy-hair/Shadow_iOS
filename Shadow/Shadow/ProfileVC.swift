//
//  ProfileVC.swift
//  Shadow
//
//  Created by Sahil Arora on 5/31/17.
//  Copyright © 2017 Atinderjit Kaur. All rights reserved.
//

import UIKit



var video_url : URL?
var bool_PlayFromProfile : Bool?

public var bool_UserIdComingFromSearch : Bool? = false//When we come from search screen
public var userIdFromSearch : NSNumber?
public var dic_DataOfProfileForOtherUser : NSMutableDictionary = NSMutableDictionary()
public var array_public_UserSocialSites = [[String:Any]]()

class ProfileVC: UIViewController {
    
    
    
    @IBOutlet var btn_OverSchool: UIButton!
    @IBOutlet var btn_overCompany: UIButton!
    @IBOutlet var imgView_Company: UIImageView!
    @IBOutlet var imgView_School: UIImageView!
    @IBOutlet var k_Constraint_ViewDescHeight: NSLayoutConstraint!
    @IBOutlet var k_Constraint_TopImageViewSchool: NSLayoutConstraint!
    @IBOutlet var k_Constraint_TopLblSchool: NSLayoutConstraint!
    @IBOutlet var lbl_RatingCount: UILabel!
    @IBOutlet var menu_btn: UIBarButtonItem!
    @IBOutlet weak var lbl_Placeholder: UILabel!
    @IBOutlet var btn_VideoIcon: UIButton!
    @IBOutlet var collectionView_Skills: UICollectionView!
    @IBOutlet var lbl_shadowedTo: UILabel!
    @IBOutlet var lbl_ShadowedBy: UILabel!
    @IBOutlet var lbl_School: UILabel!
    @IBOutlet var lbl_ProfileName: UILabel!
    @IBOutlet var imageView_ProfilePic: UIImageView!
    @IBOutlet var scrollbar:UIScrollView!
    @IBOutlet var lbl_Company: UILabel!
    @IBOutlet var collectionView_Interests: UICollectionView!
    @IBOutlet var lbl_NoOccupationsYet: UILabel!
    @IBOutlet var lbl_NoInterestsYet: UILabel!
    @IBOutlet var btn_SocialSite1: UIButton!
    @IBOutlet var btn_SocialSite2: UIButton!
    @IBOutlet var btn_SocialSite3: UIButton!
    @IBOutlet weak var view_BehindImageView: UIView!
    @IBOutlet weak var view_BehindNumValues: UIView!
    @IBOutlet weak var view_BehindOccupation: UIView!
    @IBOutlet weak var view_BehindInterest: UIView!
    @IBOutlet weak var view_BehindDescription: UIView!
    @IBOutlet var tblView_SocialSites: UITableView!
    @IBOutlet var k_Constraint_tblViewTop: NSLayoutConstraint!
    @IBOutlet var k_Constraint_Height_TableView: NSLayoutConstraint!
    @IBOutlet var txtView_Description: UITextView!
    @IBOutlet weak var lbl_NoOfRating: UILabel!
    @IBOutlet weak var kheightViewBehindInterest: NSLayoutConstraint!
    @IBOutlet weak var kheightViewBehindSkill: NSLayoutConstraint!
    
    @IBOutlet weak var kheightCollectionViewOccupation: NSLayoutConstraint!
    @IBOutlet weak var kheightCollectionViewInterestHeight: NSLayoutConstraint!
    
    var imageView1 : UIImageView?
    var imageView2 : UIImageView?
    var imageView3 : UIImageView?
    var imageView4 : UIImageView?
    var imageView5 : UIImageView?
    var linkForOpenWebsite : String?
    var rating_number  : String?
    fileprivate  var user_IdMyProfile :NSNumber?

    var dicUrl: NSMutableDictionary = NSMutableDictionary()
    let array_URL = ["facebookUrl","linkedInUrl","instagramUrl","googlePlusUrl","gitHubUrl","twitterUrl"]
    
    fileprivate var array_ActualSocialSites = [
        ["name":"Facebook","name_url":"facebookUrl","image":UIImage(named: "facebookUrl")!],
        ["name":"LinkedIn","name_url":"linkedInUrl","image":UIImage(named: "linkedInUrl")!],
        ["name":"Twitter","name_url":"twitterUrl","image":UIImage(named: "twitterUrl")!],
        ["name":"gitHub","name_url":"gitHubUrl","image":UIImage(named: "gitHubUrl")!],
        ["name":"Google+","name_url":"googlePlusUrl","image":UIImage(named: "googlePlusUrl")!],
        ["name":"Instagram","name_url":"instagramUrl","image":UIImage(named: "instagramUrl")!]]

  
    //Array that stores actual list of skills
    fileprivate var array_UserSkills:NSMutableArray =  NSMutableArray()
    fileprivate var array_UserInterests:NSMutableArray = NSMutableArray()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        DispatchQueue.main.async {
            
            if self.revealViewController() != nil {
                self.menu_btn.target = self.revealViewController()
                self.menu_btn.action = #selector(SWRevealViewController.revealToggle(_:))
                self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
                self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
            }
            
            self.imageView_ProfilePic.layer.cornerRadius = 60.0
            self.imageView_ProfilePic.clipsToBounds = true
            
            self.customView(view: self.view_BehindImageView)
            self.customView(view: self.view_BehindNumValues)
            self.customView(view: self.view_BehindOccupation)
            self.customView(view: self.view_BehindInterest)
            self.customView(view: self.view_BehindDescription)

        }
    }
   
    override func viewWillAppear(_ animated: Bool) {
        
        
        self.navigationController?.navigationBar.isTranslucent = false

        if bool_UserIdComingFromSearch == true {
            
            DispatchQueue.main.async {
                
                if self.revealViewController() != nil {
                    
                    self.revealViewController().panGestureRecognizer().isEnabled = false
                
                }
                self.scrollbar.contentInset = UIEdgeInsets(top: 44, left: 0, bottom: 0, right: 0)
                self.automaticallyAdjustsScrollViewInsets = false
                self.scrollbar.setContentOffset(CGPoint.init(x: 0, y: -30), animated: false)
                
                self.navigationController?.setNavigationBarHidden(false, animated: false)
                self.view.endEditing(true)
                self.CreateNavigationBackBarButton() //Create custom back button
                
                
                self.user_IdMyProfile = userIdFromSearch
                let btn2 = UIButton(type: .custom)
                btn2.setImage(UIImage(named: "chat-icon"), for: .normal)
                btn2.frame = CGRect(x: self.view.frame.size.width - 70, y: 0, width: 25, height: 25)
                btn2.addTarget(self, action: #selector(self.chatBtnPressed), for: .touchUpInside)
                let item2 = UIBarButtonItem(customView: btn2)
                
                let btn3 = UIButton(type: .custom)
                btn3.setImage(UIImage(named: "calendar"), for: .normal)//shadow-icon-1
                btn3.frame = CGRect(x: self.view.frame.size.width - 25, y: 0, width: 25, height: 25)
                btn3.addTarget(self, action: #selector(self.Calender_SearchBtnPressed(sender:)), for: .touchUpInside)
                let item3 = UIBarButtonItem(customView: btn3)
                
                self.navigationItem.setRightBarButtonItems([item2,item3], animated: true)
                
                DispatchQueue.global(qos: .background).async {
                    self.GetUserProfile()
                }
            }
        }
        else {
            
            DispatchQueue.main.async {
                

                let btn2 = UIButton(type: .custom)
                btn2.setImage(UIImage(named: "chat-icon"), for: .normal)
                btn2.frame = CGRect(x: self.view.frame.size.width - 20, y: 0, width: 20, height: 25)
                btn2.addTarget(self, action: #selector(self.chatBtnPressed), for: .touchUpInside)
                let item2 = UIBarButtonItem(customView: btn2)
                
                let btn4 = UIButton(type: .custom)
                btn4.setImage(UIImage(named: "notifications-button"), for: .normal)
                btn4.frame = CGRect(x:self.view.frame.size.width - 40, y: 0, width: 25, height: 25)
                btn4.addTarget(self, action: #selector(self.notificationBtnPressed), for: .touchUpInside)
                let item4 = UIBarButtonItem(customView: btn4)
                
                
                let btn3 = UIButton(type: .custom)
                btn3.setImage(UIImage(named: "calendar"), for: .normal)//shadow-icon-1
                btn3.frame = CGRect(x: self.view.frame.size.width - 60, y: 0, width: 25, height: 25)
                btn3.addTarget(self, action: #selector(self.calenderBtnPressed), for: .touchUpInside)
                let item3 = UIBarButtonItem(customView: btn3)

                
                
                
                
                
                //Right items
                self.navigationItem.setRightBarButtonItems([item2,item4,item3], animated: true)
 
                 self.user_IdMyProfile = SavedPreferences.value(forKey: Global.macros.kUserId) as? NSNumber
              
                self.tabBarController?.tabBar.isHidden = false
                self.navigationController?.setNavigationBarHidden(false, animated: false)
                self.navigationItem.setHidesBackButton(false, animated:true)
                
                DispatchQueue.global(qos: .background).async {
                    
                    self.GetUserProfile()
                    
                }
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
       
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationItem.setHidesBackButton(false, animated:true)

        
        dicUrl.removeAllObjects()
        ratingview_ratingNumber = ""
    }
    
    
    //MARK: - Functions
    
    func GetUserProfile() //ratingCount
    {
        let dict =  NSMutableDictionary()
        dict.setValue(SavedPreferences.value(forKey: Global.macros.kUserId) as? NSNumber, forKey: Global.macros.kUserId)
        dict.setValue(user_IdMyProfile, forKey:Global.macros.kotherUserId)
        
        
        if self.checkInternetConnection()
        {
            DispatchQueue.main.async {
                self.pleaseWait()
            }
            
            ProfileAPI.sharedInstance.RetrieveUserProfile(dict: dict, completion: { (response) in
                
                
                switch response.0
                {
                case 200:
                    DispatchQueue.main.async {
                        
                        dictionary_user_Info = response.1
                        
                        let shadow_Status = (response.1).value(forKey: "otherUsersShadowYou") as? NSNumber
                        SavedPreferences.set(shadow_Status, forKey: Global.macros.kotherUsersShadowYou)
                        
                        
                        self.lbl_shadowedTo.text = (((response.1).value(forKey: "shadowersVerified") as? NSDictionary)?.value(forKey: Global.macros.kcount) as? NSNumber)?.stringValue
                        self.lbl_ShadowedBy.text = (((response.1).value(forKey: "shadowedByShadowUser") as? NSDictionary)?.value(forKey: Global.macros.kcount) as? NSNumber)?.stringValue
                        
                        
                        
                        self.lbl_NoOfRating.text = "\((response.1).value(forKey: "ratingCount")!)"
                        
                        
                         array_public_UserSocialSites.removeAll()
                        //getting social sites urls from response
                        for v in self.array_ActualSocialSites
                        {
                            let value = v["name_url"] as? String
                            if (response.1[value!] != nil && response.1.value(forKey: value!) as? String != "")
                            {
                                
                                var dic = v
                                dic["url"] = (response.1).value(forKey: value!)!
                                array_public_UserSocialSites.append(dic)
                             
                            }
                        }
                        
                        print(array_public_UserSocialSites)
                        
                        
                        self.rating_number = "\((response.1).value(forKey: "avgRating")!)"
                        
                        let dbl = 2.0

                        if  dbl.truncatingRemainder(dividingBy: 1) == 0
                        {
                            self.lbl_RatingCount.text = self.rating_number! + ".0"
                            
                        }
                        else {
                            
                            self.lbl_RatingCount.text = self.rating_number!
                            
                        }
                        
                        ratingview_name = (response.1).value(forKey: Global.macros.kUserName) as? String
                        
                         self.navigationItem.title = ((response.1).value(forKey: Global.macros.kUserName) as? String)?.capitalizingFirstLetter()
                        
                        //  profileImageUrl
                        var profileurl = (response.1).value(forKey: "profileImageUrl")as? String
                        profileurl = profileurl?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                        ratingview_imgurl = profileurl?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                        
                        if profileurl != nil {
                            self.imageView_ProfilePic.sd_setImage(with: URL(string:profileurl!), placeholderImage: UIImage(named: "profile-icon-1"))//image
                        }
                        
                        let str =  (response.1).value(forKey: "videoUrl") as? String
                        if str != nil {
                            video_url = NSURL(string: str!) as URL?
                        }
                        else{
                            video_url = nil
                        }
                        
                        
                        //setting company name
                        if (response.1).value(forKey: "companyName")as? String != ""  &&  (response.1).value(forKey: "companyName") != nil{
                            
                            self.lbl_Company.text = (response.1).value(forKey: "companyName")as? String
                        }
                       
                        
                        //setting school name
                        if (response.1).value(forKey: "schoolName")as? String != "" &&  (response.1).value(forKey: "schoolName") != nil {
                            
                            self.lbl_School.text = (response.1).value(forKey: "schoolName")as? String
                        }
                        
                        //setting constraints
                        //if company is not nil
                        if (response.1).value(forKey: "companyName")as? String != ""  &&  (response.1).value(forKey: "companyName") != nil && (response.1).value(forKey: "companyName")as? String != " " {
                            
                            self.lbl_Company.isHidden = false
                            self.imgView_Company.isHidden = false
                            self.btn_overCompany.isUserInteractionEnabled = true
                            
                            
                             if (response.1).value(forKey: "schoolName")as? String != "" &&  (response.1).value(forKey: "schoolName") != nil && (response.1).value(forKey: "schoolName")as? String != " "{
                                
                                self.lbl_School.isHidden = false
                                self.imgView_School.isHidden = false
                                self.btn_OverSchool.isUserInteractionEnabled = true

                                
                                
                                
                                if array_public_UserSocialSites.count > 0 {
                                    
                                    self.tblView_SocialSites.isHidden = false
                                    if array_public_UserSocialSites.count == 1 {//social site count 1
                                        
                                        self.k_Constraint_Height_TableView.constant = 50.0
                                        self.k_Constraint_ViewDescHeight.constant = 190.0
                                        
                                        
                                    }
                                    else  if array_public_UserSocialSites.count == 2{//social site count 2
                                        
                                        self.k_Constraint_Height_TableView.constant = 100.0
                                        self.k_Constraint_ViewDescHeight.constant = 215.0
                                        
                                    }
                                    else{//social site count 3
                                        
                                        self.k_Constraint_Height_TableView.constant = 150.0
                                        self.k_Constraint_ViewDescHeight.constant = 240.0
                                    }
                                    self.tblView_SocialSites.reloadData()
                                    
                                }else{
                                   
                                    self.tblView_SocialSites.isHidden = true
                                    self.k_Constraint_ViewDescHeight.constant = 160.0

                                }
                                
                            }
                             else{
                                
                                self.lbl_School.isHidden = true
                                self.imgView_School.isHidden = true
                                self.btn_OverSchool.isUserInteractionEnabled = false

                                
                                
                                if array_public_UserSocialSites.count > 0 {//social site nil
                                    
                                    self.tblView_SocialSites.isHidden = false
                                    self.k_Constraint_tblViewTop.constant = -25.0
                                    
                                    if array_public_UserSocialSites.count == 1 {//social site count 1
                                        
                                        self.k_Constraint_Height_TableView.constant = 50.0
                                        self.k_Constraint_ViewDescHeight.constant = 150.0
                                        
                                        
                                    }
                                    else  if array_public_UserSocialSites.count == 2{//social site count 2
                                        
                                        self.k_Constraint_Height_TableView.constant = 100.0
                                        self.k_Constraint_ViewDescHeight.constant = 180.0
                                        
                                    }
                                    else{//social site count 3
                                        
                                        self.k_Constraint_Height_TableView.constant = 150.0
                                        self.k_Constraint_ViewDescHeight.constant = 210.0
                                    }
                                    self.tblView_SocialSites.reloadData()
                                    
                                }
                                else{//social site nil
                                    
                                    self.tblView_SocialSites.isHidden = true
                                    self.k_Constraint_ViewDescHeight.constant = 130.0
                                    
                                }
                            }
                            
                        }
                        else{//if company is nil
                            
                            self.lbl_Company.isHidden = true
                            self.imgView_Company.isHidden = true
                            self.btn_overCompany.isUserInteractionEnabled = false

                            
                            if (response.1).value(forKey: "schoolName")as? String != "" &&  (response.1).value(forKey: "schoolName") != nil &&  (response.1).value(forKey: "schoolName")as? String != " "{
                                
                                self.lbl_School.isHidden = false
                                self.imgView_School.isHidden = false
                                self.k_Constraint_TopLblSchool.constant = -28.0
                                self.k_Constraint_TopImageViewSchool.constant = -23.0
                                self.btn_OverSchool.isUserInteractionEnabled = true


                                 if array_public_UserSocialSites.count > 0 {//social site not nil
                                    
                                    self.tblView_SocialSites.isHidden = false
                                    if array_public_UserSocialSites.count == 1 {//social site count 1
                                        
                                        self.k_Constraint_Height_TableView.constant = 50.0
                                        self.k_Constraint_ViewDescHeight.constant = 150.0
                                        
                                        
                                    }
                                    else  if array_public_UserSocialSites.count == 2{//social site count 2
                                        
                                        self.k_Constraint_Height_TableView.constant = 100.0
                                        self.k_Constraint_ViewDescHeight.constant = 180.0
                                        
                                    }
                                    else{//social site count 3
                                        
                                        self.k_Constraint_Height_TableView.constant = 150.0
                                        self.k_Constraint_ViewDescHeight.constant = 210.0
                                    }
                                    self.tblView_SocialSites.reloadData()
                                    
                                 }else{//social site nil
                                    
                                    self.tblView_SocialSites.isHidden = true
                                    self.k_Constraint_ViewDescHeight.constant = 130.0
                                    
                                }
                            }
                            else{
                                
                                self.lbl_School.isHidden = true
                                self.imgView_School.isHidden = true
                                self.btn_OverSchool.isUserInteractionEnabled = false

                                
                                if array_public_UserSocialSites.count > 0 {//social sites not nil
                                    
                                    self.tblView_SocialSites.isHidden = false
                                    self.k_Constraint_tblViewTop.constant = -50.0
                                    
                                    
                                    if array_public_UserSocialSites.count == 1 {//social site count 1
                                        
                                        self.k_Constraint_Height_TableView.constant = 50.0
                                        self.k_Constraint_ViewDescHeight.constant = 130.0
                                        
                                        
                                    }
                                    else  if array_public_UserSocialSites.count == 2{//social site count 2
                                        
                                        self.k_Constraint_Height_TableView.constant = 100.0
                                        self.k_Constraint_ViewDescHeight.constant = 160.0
                                        
                                    }
                                    else{//social site count 3
                                        
                                        self.k_Constraint_Height_TableView.constant = 150.0
                                        self.k_Constraint_ViewDescHeight.constant = 190.0
                                    }
                                    self.tblView_SocialSites.reloadData()
                                    
                                }
                                else{//everything nil
                                    
                                    self.tblView_SocialSites.isHidden = true
                                    self.k_Constraint_ViewDescHeight.constant = 100.0
                                    
                                }
                            }
                            
                        }
                        
                        
                        
                        
                        //setting description
                        if (response.1).value(forKey: Global.macros.kbio) as? String != nil {
                        
                            self.txtView_Description.text = "\((response.1).value(forKey: Global.macros.kbio) as! String)"
                            self.lbl_Placeholder.isHidden = true
                        }
                        else {
                            self.lbl_Placeholder.isHidden = false
                            
                        }
                        
                        if (response.1).value(forKey: "occupations")as? NSArray != nil {
                            
                            self.array_UserSkills.removeAllObjects()
                            let tmp_arr_occ = ((response.1).value(forKey:  Global.macros.koccupation) as? NSArray)?.mutableCopy() as! NSMutableArray
                            
                            //deleting duplicacy of occupations if occur
                            
                            for value in tmp_arr_occ{
                                
                                let name = (value as! NSDictionary).value(forKey: "name") as? String
                              //  let id = (value as! NSDictionary).value(forKey: "id") as? NSNumber
                                let dict = NSMutableDictionary()
                                dict.setValue(name, forKey: "name")
                             //   dict.setValue(id, forKey: "id")
                                 print(dict)
                                if self.array_UserSkills.contains(dict) {
                                    break
                                }
                                else{
                                    self.array_UserSkills.add(dict)
                                    
                                }
                            }
                            
                            if self.array_UserSkills.count > 0{
                                
                                self.collectionView_Skills.isHidden = false
                                self.lbl_NoOccupationsYet.isHidden = true
                                self.collectionView_Skills.reloadData()
                                
                            }
                            else{
                                
                                self.collectionView_Skills.isHidden = true
                                self.lbl_NoOccupationsYet.isHidden = false
                                
                            }
                        }
                        else {
                            self.collectionView_Skills.isHidden = true
                            self.lbl_NoOccupationsYet.isHidden = false
                            
                        }
                        
                        if (response.1).value(forKey: "interest")as? NSArray != nil {
                            
                            self.array_UserInterests.removeAllObjects()
                            let tmp_arr_occ = ((response.1).value(forKey:  Global.macros.kinterest) as? NSArray)?.mutableCopy() as! NSMutableArray
                            
                            //deleting duplicacy of interests if occur
                            for value in tmp_arr_occ{
                                
                                let name = (value as! NSDictionary).value(forKey: "name") as? String
                                let dict = NSMutableDictionary()
                                dict.setValue(name, forKey: "name")
                                if self.array_UserInterests.contains(dict) {
                                    break
                                }
                                else{
                                    self.array_UserInterests.add(dict)
                                    
                                }
                            }
                            
                            
                            if self.array_UserInterests.count > 0{
                                
                                self.collectionView_Interests.isHidden = false
                                self.lbl_NoInterestsYet.isHidden = true
                                self.collectionView_Interests.reloadData()
                                
                            }
                            else{
                                self.collectionView_Interests.isHidden = true
                                self.lbl_NoInterestsYet.isHidden = false
                            }
                        }
                        else {
                            self.collectionView_Interests.isHidden = true
                            self.lbl_NoInterestsYet.isHidden = false
                            
                        }
                    }
                    
                case 401:
                    self.AlertSessionExpire()
                    
                    
                    
                default:
                    break
                    
                }
                DispatchQueue.main.async {
                    self.clearAllNotice()
                }
            }, errorBlock: {(err) in
                
                DispatchQueue.main.async
                    {
                        self.clearAllNotice()
                        self.showAlert(Message: Global.macros.kError ,vc: self)
                }
            })
        }
        else{
            self.showAlert(Message: Global.macros.kInternetConnection, vc: self)
            
        }
    }

    
    //custom view to set borders of views
    func customView(view : UIView) {
        
        view.layer.cornerRadius = 4
        view.clipsToBounds = true
        view.layer.borderColor = UIColor.init(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 0.5).cgColor
        view.layer.borderWidth = 1.0
        
    }
    
    // Rating stars on navigation bar
    func custom_StarView () {
        
        let view_stars = UIView()
        view_stars.frame = CGRect(x: 0, y: 10, width: 110, height: 25)
        view_stars.backgroundColor = UIColor.clear
        self.view.addSubview(view_stars)
        
        let imageName = "StarEmpty"
        let image = UIImage(named: imageName)
        
        imageView1 = UIImageView(image: image!)
        imageView1?.frame = CGRect(x: 5, y: 0, width: 20, height: 20)
        
        imageView2 = UIImageView(image: image!)
        imageView2?.frame = CGRect(x: 25, y: 0, width: 20, height: 20)
        
        imageView3 = UIImageView(image: image!)
        imageView3?.frame = CGRect(x: 45, y: 0, width: 20, height: 20)
        
        
        imageView4 = UIImageView(image: image!)
        imageView4?.frame = CGRect(x: 65, y: 0, width: 20, height: 20)
        
        
        imageView5 = UIImageView(image: image!)
        imageView5?.frame = CGRect(x: 85, y: 0, width: 20, height: 20)
        
        
        let  btn_actionRating = UIButton(type: .custom)
        btn_actionRating.frame = CGRect(x: 0, y: 0, width: 110, height: 25)
        btn_actionRating.addTarget(self, action: #selector(ratingBtnPressed), for: .touchUpInside)
        
        view_stars.addSubview(imageView1!)
        view_stars.addSubview(imageView2!)
        view_stars.addSubview(imageView3!)
        view_stars.addSubview(imageView4!)
        view_stars.addSubview(imageView5!)
        view_stars.addSubview(btn_actionRating)
        
        self.navigationItem.titleView = view_stars
        
    }
    
    func ratingBtnPressed(sender: AnyObject){
        
        
    }
    
    
    func SetRatingView (Number:String) {
        
        switch Number {
            
        case "0":
            imageView1?.image = UIImage(named: "StarEmpty")
            imageView2?.image = UIImage(named: "StarEmpty")
            imageView3?.image = UIImage(named: "StarEmpty")
            imageView4?.image = UIImage(named: "StarEmpty")
            imageView5?.image = UIImage(named: "StarEmpty")
            
        case "1":
            imageView1?.image = UIImage(named: "StarFull")
            imageView2?.image = UIImage(named: "StarEmpty")
            imageView3?.image = UIImage(named: "StarEmpty")
            imageView4?.image = UIImage(named: "StarEmpty")
            imageView5?.image = UIImage(named: "StarEmpty")
            
        case "2":
            imageView1?.image = UIImage(named: "StarFull")
            imageView2?.image = UIImage(named: "StarFull")
            imageView3?.image = UIImage(named: "StarEmpty")
            imageView4?.image = UIImage(named: "StarEmpty")
            imageView5?.image = UIImage(named: "StarEmpty")
            
        case "3":
            imageView1?.image = UIImage(named: "StarFull")
            imageView2?.image = UIImage(named: "StarFull")
            imageView3?.image = UIImage(named: "StarFull")
            imageView4?.image = UIImage(named: "StarEmpty")
            imageView5?.image = UIImage(named: "StarEmpty")
            
        case "4":
            imageView1?.image = UIImage(named: "StarFull")
            imageView2?.image = UIImage(named: "StarFull")
            imageView3?.image = UIImage(named: "StarFull")
            imageView4?.image = UIImage(named: "StarFull")
            imageView5?.image = UIImage(named: "StarEmpty")
            
        case "5":
            imageView1?.image = UIImage(named: "StarFull")
            imageView2?.image = UIImage(named: "StarFull")
            imageView3?.image = UIImage(named: "StarFull")
            imageView4?.image = UIImage(named: "StarFull")
            imageView5?.image = UIImage(named: "StarFull")
            
            
            
        default:
            break
        }
        
        
        
    }
    
    
    func notificationBtnPressed(sender: AnyObject){
        
        let vc = Global.macros.Storyboard.instantiateViewController(withIdentifier: "Notifications") as! NotificationsViewController
        _ = self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    func chatBtnPressed(sender: AnyObject){
        self.showAlert(Message: "Coming Soon", vc: self)
        
    }
    
    func Calender_SearchBtnPressed(sender: AnyObject){
        
        let vc = Global.macros.Storyboard.instantiateViewController(withIdentifier: "send_request") as! SendRequestViewController
        vc.user_Name =  self.navigationItem.title
        //userIdFromSearch
        _ = self.navigationController?.pushViewController(vc, animated: true)

    }
    
    func calenderBtnPressed(sender: AnyObject){
        
        let vc = Global.macros.Storyboard.instantiateViewController(withIdentifier: "MyRequests") as! RequestsListViewController
        vc.user_Name =  self.navigationItem.title
        _ = self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    func menuBtnPressed(sender: AnyObject){
        
        let dict = NSMutableDictionary()
        let  user_Id = SavedPreferences.value(forKey: Global.macros.kUserId) as? NSNumber
        dict.setValue(user_Id, forKey: Global.macros.kUserId)
        
        
        let TitleString = NSAttributedString(string: "Shadow", attributes: [
            NSFontAttributeName : UIFont.systemFont(ofSize: 18),
            NSForegroundColorAttributeName : Global.macros.themeColor
            ])
        let MessageString = NSAttributedString(string: "Are you sure you want to log Out?", attributes: [
            NSFontAttributeName : UIFont.systemFont(ofSize: 15),
            NSForegroundColorAttributeName : Global.macros.themeColor
            ])
        
        DispatchQueue.main.async {
            self.clearAllNotice()
            
            let alert = UIAlertController(title: "Shadow", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: "Yes", style: .default, handler: { (alert) in
                
                if self.checkInternetConnection()
                {
                    DispatchQueue.main.async {
                        self.pleaseWait()
                    }
                    AuthenticationAPI.sharedInstance.LogOut(dict: dict, completion: {(response) in
                        
                        DispatchQueue.main.async {
                            self.clearAllNotice()
                            
                            
                            bool_fromMobile = false
                            bool_NotVerified = false
                            bool_LocationFilter = false
                            bool_PlayFromProfile = false
                            bool_AllTypeOfSearches = false
                            bool_CompanySchoolTrends = false
                            bool_fromVerificationMobile = false
                            bool_UserIdComingFromSearch = false
                            
                            SavedPreferences.set(nil, forKey: "user_verified")
                            SavedPreferences.set(nil, forKey: "sessionToken")
                            SavedPreferences.removeObject(forKey: Global.macros.kUserId)
                            let vc = Global.macros.Storyboard.instantiateViewController(withIdentifier: "Login")
                            Global.macros.kAppDelegate.window?.rootViewController = vc
                            
                        }
                    }, errorBlock: {(err) in
                        DispatchQueue.main.async {
                            self.clearAllNotice()
                            self.showAlert(Message: Global.macros.kError, vc: self)
                        }
                    })
                }
                else{
                    
                    self.showAlert(Message: Global.macros.kInternetConnection, vc: self)
                }
            }))
            
            alert.addAction(UIAlertAction.init(title: "No", style: .default, handler:nil))
            alert.view.layer.cornerRadius = 10.0
            alert.view.clipsToBounds = true
            alert.view.backgroundColor = UIColor.white
            alert.view.tintColor = Global.macros.themeColor
            
            alert.setValue(TitleString, forKey: "attributedTitle")
            alert.setValue(MessageString, forKey: "attributedMessage")
            self.present(alert, animated: true, completion: nil)
            
        }

    }
    
    
    
    //MARK: - Button Actions
    
    
    @IBAction func Action_OpenRatingView(_ sender: Any) {
        
        DispatchQueue.main.async {
            
            if bool_UserIdComingFromSearch == true{
                
                let vc = Global.macros.Storyboard.instantiateViewController(withIdentifier: "ratingView") as! RatingViewController
                _ = self.navigationController?.pushViewController(vc, animated: true)
                
            }else{
                if self.lbl_NoOfRating.text != "0"{
                    
                    let vc = Global.macros.Storyboard.instantiateViewController(withIdentifier: "ratingView") as! RatingViewController
                    _ = self.navigationController?.pushViewController(vc, animated: true)
                    
                }else{
                    self.showAlert(Message: "No ratings yet.", vc: self)
                }
            }
        }
    }
    
    
    @IBAction func Open_ProfileImage(_ sender: UIButton) {
        
        Global.macros.statusBar.isHidden = true
        let imgdata = UIImageJPEGRepresentation(imageView_ProfilePic.image!, 0.5)
        let photos = self.ArrayOfPhotos(data: imgdata!)
        let vc: NYTPhotosViewController = NYTPhotosViewController(photos: photos as? [NYTPhoto])
        vc.rightBarButtonItem = nil
        self.present(vc, animated: true, completion: nil)
       
        
    }
    
    
    func ArrayOfPhotos(data:Data)->(NSArray)
    {
        self.scrollbar.contentInset = UIEdgeInsets.init(top: 10, left: 0, bottom: 0, right: 0)
        let photos:NSMutableArray = NSMutableArray()
        let photo:NYTExamplePhoto = NYTExamplePhoto()
        photo.imageData = data
        photos.add(photo)
        return photos
        /*NSMutableArray *photos = [NSMutableArray array];
         
         NYTExamplePhoto *photo = [[NYTExamplePhoto alloc] init];
         photo.imageData = data;
         [photos addObject:photo];
         return photos;*/
        
    }
    
    @IBAction func Action_LogOut(_ sender: UIButton) {
        
           }
    
    @IBAction func Action_SelectSocialIcons(_ sender: UIButton) {
        
//        LISDKSessionManager.createSession(withAuth: [LISDK_BASIC_PROFILE_PERMISSION], state: nil, showGoToAppStoreDialog: true, successBlock: { (returnState) -> Void in
//            print("success called!")
//            
//        }) { (error) -> Void in
//            print("Error: \(error)")
//        }
        
        /* linkedinHelper.authorizeSuccess({ (token) in
         
         print(token)
         self.linkedinHelper.requestURL("https://api.linkedin.com/v1/people/~:(id,first-name,last-name,email-address,picture-url,picture-urls::(original),positions,date-of-birth,phone-numbers,location)?format=json", requestType: LinkedinSwiftRequestGet, success: { (response) -> Void in
         
         print(response)
         //parse this response which is in the JSON format
         }) {(error) -> Void in
         
         print(error.localizedDescription)
         //handle the error
         }
         
         
         //This token is useful for fetching profile info from LinkedIn server
         }, error: { (error) in
         
         print(error.localizedDescription)
         //show respective error
         }) {
         //show sign in cancelled event
         } */
        
    }
    
    @IBAction func Action_PlayVideo(_ sender: UIButton) {
        if video_url != nil {

        bool_PlayFromProfile = true

            let vc = Global.macros.Storyboard.instantiateViewController(withIdentifier: "Upload_Video") as! UploadViewController
            _ = self.navigationController?.present(vc, animated: true, completion: nil)
        }
        else {
            
            self.showAlert(Message: "No video to play yet.", vc: self)

        }
    }
    
    @IBAction func ActionSocialMedia1(_ sender: Any) {
        SetWebViewUrl (index: 0)
        
    }
    
    @IBAction func ActionSocialMedia2(_ sender: Any) {
        
        SetWebViewUrl (index: 1)
        
    }
    
    
    @IBAction func Action_openSchoolCompany(_ sender: UIButton) {
        
        if sender.tag == 0{
            
           idFromProfileVC = ((dictionary_user_Info.value(forKey: "companyDTO") as? NSDictionary)?.value(forKey: "id") as? NSNumber)!
            
        }
        else if sender.tag == 1{
            idFromProfileVC = ((dictionary_user_Info.value(forKey: "schoolDTO") as? NSDictionary)?.value(forKey: "id") as? NSNumber)!

        }
        
        print(idFromProfileVC!)
        let vc = Global.macros.Storyboard.instantiateViewController(withIdentifier: "company") as! ComapanySchoolViewController//UINavigationController
        check_for_previousview = "FromProfileVC"
        _ = self.navigationController?.pushViewController(vc, animated: true)

    }
    
    
    
    
    
    
    func SetWebViewUrl (index:Int) {
        
        
        let tempArray = self.dicUrl.allKeys as! [String]
        
        
        let socialStr:String = tempArray[index]
        
        switch socialStr {
        case "facebookUrl":
            linkForOpenWebsite = self.dicUrl.value(forKey: "facebookUrl") as? String
        case "linkedInUrl":
            linkForOpenWebsite = self.dicUrl.value(forKey: "linkedInUrl") as? String
            
        case "twitterUrl":
            linkForOpenWebsite = self.dicUrl.value(forKey: "twitterUrl") as? String
            
        case "googlePlusUrl":
            linkForOpenWebsite = self.dicUrl.value(forKey: "googlePlusUrl") as? String
            
            
        case "instagramUrl":
            linkForOpenWebsite = self.dicUrl.value(forKey: "instagramUrl") as? String
            
        case "gitHubUrl":
            linkForOpenWebsite = self.dicUrl.value(forKey: "gitHubUrl") as? String
            
        default: break
            
        }
        
        
        if let checkURL = NSURL(string: linkForOpenWebsite!) {
            if  UIApplication.shared.openURL(checkURL as URL){
                print("URL Successfully Opened")
                linkForOpenWebsite = ""
            }
            else {
                print("Invalid URL")
            }
        } else {
            print("Invalid URL")
        }
        
    }

    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "userProfile_to_usereditProfile"{
            
            let vc = segue.destination as! UserEditProfileViewController
            vc.dict_Url = self.dicUrl
            
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
extension ProfileVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 8
        let size:CGSize?
        if Global.DeviceType.IS_IPHONE_6 || Global.DeviceType.IS_IPHONE_6P{
            size = CGSize(width: ((collectionView.frame.width/3 - 5) ), height: 45)
        }
        else{
            size = CGSize(width: ((collectionView.frame.width/2 - 5) ), height: 45)
            
        }
        return size!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        var cell = UICollectionViewCell()
        
        if collectionView == collectionView_Skills{
            let skills_cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "skill", for: indexPath)as! SkillsNInterestCollectionViewCell
            
            if array_UserSkills.count > 0 {
                
                skills_cell.lbl_Skill.text = (array_UserSkills[indexPath.row]as! NSDictionary).value(forKey: "name")as? String
            }
            
            cell = skills_cell
            
        }
        
        if collectionView == collectionView_Interests{
            let interest_cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "interest_cell", for: indexPath)as! Profile_UserInterestsCollectionViewCell
            
            if array_UserInterests.count > 0 {
                
                interest_cell.lbl_InterestName.text = (array_UserInterests[indexPath.row]as! NSDictionary).value(forKey: "name")as? String
                
            }
            
            cell = interest_cell
            
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        var count:Int?
        
        if collectionView == collectionView_Skills{
            
            count = array_UserSkills.count
            if count! <= 2 {
                self.kheightViewBehindSkill.constant = 100

            }
                
                
            else if count == 4 {
                self.kheightViewBehindSkill.constant = 150
                
            }
            else {
                
                
                DispatchQueue.main.async {
                    
                    self.kheightCollectionViewOccupation.constant = self.collectionView_Skills.contentSize.height
                    
                    self.kheightViewBehindSkill.constant = self.collectionView_Skills.contentSize.height + 30
                }
              

            }
            
            if Global.DeviceType.IS_IPHONE_5 {
                
                if count == 3 {
                    self.kheightViewBehindSkill.constant = 150
                    
                }
                
                
            }


        }
        
        if collectionView == collectionView_Interests{
            
            count = array_UserInterests.count
            
            if count! <= 2 {
                self.kheightViewBehindInterest.constant = 100
            }
            else if count == 4 {
                self.kheightViewBehindInterest.constant = 150

            }
            else {
                DispatchQueue.main.async {
                self.kheightCollectionViewInterestHeight.constant = self.collectionView_Interests.contentSize.height
                self.kheightViewBehindInterest.constant = self.collectionView_Interests.contentSize.height + 35
                }
            }
            
            if Global.DeviceType.IS_IPHONE_5 {
                
                if count == 3 {
                    self.kheightViewBehindInterest.constant = 150
                    
                }
                
                
            }
    
        }
         DispatchQueue.main.async {
       self.scrollbar.contentSize = CGSize(width: self.view.frame.size.width, height: 300 + self.k_Constraint_ViewDescHeight.constant + self.kheightViewBehindSkill.constant + self.kheightViewBehindInterest.constant)
        }
        
        return count!
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        
//        if collectionView == collectionView_Skills {
//        let vc = Global.macros.Storyboard.instantiateViewController(withIdentifier: "OccupationDetail") as! OccupationDetailViewController
//        vc.occupationId = (array_UserSkills[indexPath.row] as! NSDictionary)["id"]! as? NSNumber
//        _ = self.navigationController?.pushViewController(vc, animated: true)
//        }
//       
//    }
    
    
}

extension ProfileVC:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array_public_UserSocialSites.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UserProfileSocialSiteTableViewCell
        cell.imgView_UserSocialSite.image = (array_public_UserSocialSites[indexPath.row] as NSDictionary).value(forKey: "image") as? UIImage
        let site_url = (array_public_UserSocialSites[indexPath.row] as NSDictionary).value(forKey: "url") as? String
        let site = (array_public_UserSocialSites[indexPath.row] as NSDictionary).value(forKey: "name_url") as? String
        switch (site!){
        case "facebookUrl":
            //https://www.facebook.com/ 25
            let index = site_url?.index((site_url?.startIndex)!, offsetBy: 25)
            cell.lbl_UserSocialSite.text = site_url?.substring(from: index!)
            
            break
        
        case "linkedInUrl":
            //https://www.linkedin.com/ 25
            
            let index = site_url?.index((site_url?.startIndex)!, offsetBy: 25)
            cell.lbl_UserSocialSite.text = site_url?.substring(from: index!)
            break
            
            
        case "instagramUrl":
            //https://www.instagram.com/ 26
            let index = site_url?.index((site_url?.startIndex)!, offsetBy: 26)
            cell.lbl_UserSocialSite.text = site_url?.substring(from: index!)

            break
            
            
        case "googlePlusUrl":
            //https://www.googleplus.com/ 27
            let index = site_url?.index((site_url?.startIndex)!, offsetBy: 27)
            cell.lbl_UserSocialSite.text = site_url?.substring(from: index!)

            break
            
            
        case "gitHubUrl":
            //https://www.github.com/ 23
            
            let index = site_url?.index((site_url?.startIndex)!, offsetBy: 23)
            cell.lbl_UserSocialSite.text = site_url?.substring(from: index!)

            break
            
            
        case "twitterUrl":
            //https://www.twitter.com/ 24
            let index = site_url?.index((site_url?.startIndex)!, offsetBy: 24)
            cell.lbl_UserSocialSite.text = site_url?.substring(from: index!)
            
            break
        
        default:
            break
        }

        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        let site_url = (array_public_UserSocialSites[indexPath.row] as NSDictionary).value(forKey: "url") as? String
        print(site_url!)
        
        DispatchQueue.main.async {
            if let checkURL = NSURL(string: site_url!) {
                
                if  UIApplication.shared.openURL(checkURL as URL){
                    print("URL Successfully Opened")
                }
                else {
                    print("Invalid URL")
                }
            } else {
                print("Invalid URL")
            }
        }
        
        
    }
    
    
}

