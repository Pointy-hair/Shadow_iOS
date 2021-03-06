//
//  ComapanySchoolViewController.swift
//  Shadow
//
//  Created by Atinderjit Kaur on 28/06/17.
//  Copyright © 2017 Atinderjit Kaur. All rights reserved.
//

import UIKit

var idFromProfileVC:NSNumber?
var bool_ComingRatingList : Bool = false

class ComapanySchoolViewController: UIViewController, UIGestureRecognizerDelegate {
    
    
    @IBOutlet weak var kTopLinkOpenSchoolCompany: NSLayoutConstraint!
    @IBOutlet weak var btn_LinkOpenSchoolCompany: UIButton!
    
    @IBOutlet var tblView_SocialSites: UITableView!
    @IBOutlet var k_Constraint_Height_tblView: NSLayoutConstraint!
    @IBOutlet var k_Constraint_Top_yblView: NSLayoutConstraint!
    @IBOutlet var k_Constraint_Top_imgViewUrl: NSLayoutConstraint!
    @IBOutlet var k_Constraint_Top_lblUrl: NSLayoutConstraint!
    @IBOutlet var imgView_Url: UIImageView!
    @IBOutlet var imgView_Location: UIImageView!
    @IBOutlet var lbl_Rating: UILabel!
    @IBOutlet var lbl_RatingCount: UILabel!
    @IBOutlet var k_Constraint_ViewDescriptionHeight: NSLayoutConstraint!
    @IBOutlet var menuButton: UIBarButtonItem!
    @IBOutlet var Scroll_View: UIScrollView!
    @IBOutlet var imgView_ProfilePic: UIImageView!
    @IBOutlet var btn_SocialSite1: UIButton!
    @IBOutlet var btn_SocialSite2: UIButton!
    @IBOutlet var btn_SocialSite3: UIButton!
    @IBOutlet var lbl_company_schoolName: UILabel!
    @IBOutlet var lbl_company_schoolLocation: UILabel!
    @IBOutlet var lbl_company_schoolUrl: UILabel!
    @IBOutlet var lbl_CountverifiedShadowers: UILabel!
    @IBOutlet var lbl_CountshadowedYou: UILabel!
    @IBOutlet var lbl_Count_cmpnyschool_withthesesoccupation: UILabel!
    @IBOutlet var lbl_Count_Users: UILabel!
    @IBOutlet var lbl_title__cmpnyschool_withthesesoccupation: UILabel!
    @IBOutlet var lbl_title_Users: UILabel!
    @IBOutlet var lbl_description: UILabel!
    @IBOutlet var lbl_Placeholder_description: UILabel!
    @IBOutlet var lbl_NoOccupationYet: UILabel!
    @IBOutlet var collection_View: UICollectionView!
    @IBOutlet weak var view_BehindProfile: UIView!
    @IBOutlet weak var view_BehindNumValues: UIView!
    @IBOutlet weak var view_BehindDescription: UIView!
    @IBOutlet weak var view_BehindOccupation: UIView!
    @IBOutlet var txtView_Description: UITextView!
    @IBOutlet var lbl_totalRatingCount: UILabel!
    @IBOutlet weak var kheightViewBehindOccupation: NSLayoutConstraint!
    var check_for_previousview : String?

    @IBOutlet weak var kHeightCollectionView: NSLayoutConstraint!
    
    //MARK: - Variables
    var linkForOpenWebsite : String?
    var rating_number  : String?
    var user_IdMyProfile :NSNumber?
    fileprivate var item1 = UIBarButtonItem()
    fileprivate var array_UserOccupations:NSMutableArray = NSMutableArray()
    
    
    var dicUrl: NSMutableDictionary = NSMutableDictionary()
    let array_URL = ["facebookUrl","linkedInUrl","instagramUrl","googlePlusUrl","gitHubUrl","twitterUrl"]
    
    fileprivate var array_ActualSocialSites = [
        ["name":"Facebook","name_url":"facebookUrl","image":UIImage(named: "facebookUrl")!],
        ["name":"LinkedIn","name_url":"linkedInUrl","image":UIImage(named: "linkedInUrl")!],
        ["name":"Twitter","name_url":"twitterUrl","image":UIImage(named: "twitterUrl")!],
        ["name":"gitHub","name_url":"gitHubUrl","image":UIImage(named: "gitHubUrl")!],
        ["name":"Google+","name_url":"googlePlusUrl","image":UIImage(named: "googlePlusUrl")!],
        ["name":"Instagram","name_url":"instagramUrl","image":UIImage(named: "instagramUrl")!]]
    
    
    var imageView1 : UIImageView?
    var imageView2 : UIImageView?
    var imageView3 : UIImageView?
    var imageView4 : UIImageView?
    var imageView5 : UIImageView?
    
    //MARK: - View default methods
    override func viewDidLayoutSubviews() {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            
            //Calling toggle of side bar button
            if self.revealViewController() != nil {
                
                self.menuButton.target = self.revealViewController()
                self.menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
                self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
                self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
            }

            
            //giving border to Profile image
            self.imgView_ProfilePic.layer.cornerRadius = 60.0
            self.imgView_ProfilePic.clipsToBounds = true
            self.tabBarController?.delegate = self

            
            
            //setting border to custom views(Boundaries)
            self.customView(view: self.view_BehindProfile)
            self.customView(view: self.view_BehindNumValues)
            self.customView(view: self.view_BehindOccupation)
            self.customView(view: self.view_BehindDescription)
            
        }
        
        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(handle_Tap(_:)))
        tap.delegate = self
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
    }
    
    // MARK: Tap gesture to hide keyboard
    func handle_Tap(_ sender: UITapGestureRecognizer) {
        
        if self.revealViewController() != nil {
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
        }
        
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        if (touch.view?.isDescendant(of: collection_View))!        {
            return false
        }
        return true
    }

    
    override func viewDidDisappear(_ animated: Bool) {
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationItem.setHidesBackButton(false, animated:true)
        idFromProfileVC = nil
        dicUrl.removeAllObjects()
        ratingview_ratingNumber = ""
        
  
            bool_ComingFromList = false
            bool_ComingRatingList = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        bool_Occupation = false
        
       

      
        if self.revealViewController() != nil {
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
        }
 
        
        if bool_UserIdComingFromSearch == true {            //if coming from search view
            
            DispatchQueue.main.async {
                
                self.Scroll_View.contentInset = UIEdgeInsets(top: 26, left: 0, bottom: 0, right: 0)
                self.automaticallyAdjustsScrollViewInsets = false
                self.Scroll_View.setContentOffset(CGPoint.init(x: 0, y: -15), animated: false)
                
              
                
                
                self.navigationController?.setNavigationBarHidden(false, animated: false)
                self.navigationItem.setHidesBackButton(false, animated:true)
                self.CreateNavigationBackBarButton()        //Create custom back button
                self.tabBarController?.tabBar.isHidden = true
                
                
                if self.user_IdMyProfile == nil {

                    self.user_IdMyProfile = userIdFromSearch
                    
                    
                }

                if self.user_IdMyProfile != SavedPreferences.value(forKey: Global.macros.kUserId) as? NSNumber {

                let btn2 = UIButton(type: .custom)
                btn2.setImage(UIImage(named: "chat-icon"), for: .normal)
                btn2.frame = CGRect(x: self.view.frame.size.width - 70, y: 0, width: 25, height: 25)
                btn2.addTarget(self, action: #selector(self.chatBtnPressed), for: .touchUpInside)
                let item2 = UIBarButtonItem(customView: btn2)
                
                let btn3 = UIButton(type: .custom)
                btn3.setImage(UIImage(named: "calendar"), for: .normal)//shadow-icon-1
                btn3.frame = CGRect(x: self.view.frame.size.width - 25, y: 0, width: 25, height: 25)
                btn3.addTarget(self, action: #selector(self.Calender_SearchBtnPressed), for: .touchUpInside)
                let item3 = UIBarButtonItem(customView: btn3)
                
                
                //right nav btns
                    self.navigationItem.setRightBarButtonItems([item2,item3], animated: true) }
                
              
                
                
                DispatchQueue.global(qos: .background).async {
                    
                    self.GetCompanySchoolProfile()
                    
                }
            }
        }
        else if bool_ComingFromList == true {
            
            DispatchQueue.main.async {
//                let desiredOffset = CGPoint(x: 0, y: self.Scroll_View.contentInset.top)
//                self.Scroll_View.setContentOffset(desiredOffset, animated: true)
//   
//                self.Scroll_View.contentInset = UIEdgeInsets(top: 44, left: 0, bottom: 0, right: 0)
//                self.automaticallyAdjustsScrollViewInsets = false
//                self.Scroll_View.setContentOffset(CGPoint.init(x: 0, y: -30), animated: false)
                
                              
                
                self.navigationController?.setNavigationBarHidden(false, animated: false)
                self.navigationItem.setHidesBackButton(false, animated:true)
                self.CreateNavigationBackBarButton()        //Create custom back button
                self.tabBarController?.tabBar.isHidden = true
                
                
                let btn2 = UIButton(type: .custom)
                btn2.setImage(UIImage(named: "chat-icon"), for: .normal)
                btn2.frame = CGRect(x: self.view.frame.size.width - 70, y: 0, width: 25, height: 25)
                btn2.addTarget(self, action: #selector(self.chatBtnPressed), for: .touchUpInside)
                let item2 = UIBarButtonItem(customView: btn2)
                
                let btn3 = UIButton(type: .custom)
                btn3.setImage(UIImage(named: "calendar"), for: .normal)//shadow-icon-1
                btn3.frame = CGRect(x: self.view.frame.size.width - 25, y: 0, width: 25, height: 25)
                btn3.addTarget(self, action: #selector(self.Calender_SearchBtnPressed), for: .touchUpInside)
                let item3 = UIBarButtonItem(customView: btn3)
                
                
                //right nav btns
                self.navigationItem.setRightBarButtonItems([item2,item3], animated: true)
                if self.user_IdMyProfile == nil {
                    
                    self.user_IdMyProfile = userIdFromSearch
                    
                    
                }

                
              
                DispatchQueue.global(qos: .background).async {
                    
                    self.GetCompanySchoolProfile()
                    
                }
                bool_ComingFromList = false
            }

            
        }

        else {
            
            DispatchQueue.main.async {
                
                
                self.tabBarController?.tabBar.isHidden = false
                self.navigationController?.setNavigationBarHidden(false, animated: false)
                self.navigationItem.setHidesBackButton(false, animated:true)
                
                
                if self.user_IdMyProfile != nil {
                    
                  
                    
                    if self.user_IdMyProfile == SavedPreferences.value(forKey: Global.macros.kUserId) as? NSNumber {
                        
                        self.menuButton.tintColor = UIColor.white
                        self.menuButton.isEnabled = true
                    }
                    
                    else{
                        
                        self.menuButton.tintColor = UIColor.clear
                        self.menuButton.isEnabled = false
                        self.CreateNavigationBackBarButton()
                        
                    }
                }
                
                else{
                    
                    self.user_IdMyProfile = SavedPreferences.value(forKey: Global.macros.kUserId) as? NSNumber
                    self.menuButton.tintColor = UIColor.white
                    self.menuButton.isEnabled = true
                    
                    let btn1 = UIButton(type: .custom)
                    btn1.setImage(UIImage(named: "chat-icon"), for: .normal)
                    btn1.frame = CGRect(x: self.view.frame.size.width - 25, y: 0, width: 20, height: 25)
                    btn1.addTarget(self, action: #selector(self.chatBtnPressed), for: .touchUpInside)
                    let item1 = UIBarButtonItem(customView: btn1)
                    
                  /*  let btn2 = UIButton(type: .custom)
                    btn2.setImage(UIImage(named: "notifications-button"), for: .normal)
                    btn2.frame = CGRect(x: self.view.frame.size.width - 40, y: 0, width: 20, height: 25)
                    btn2.addTarget(self, action: #selector(self.notificationBtnPressed), for: .touchUpInside)
                    let item2 = UIBarButtonItem(customView: btn2) */
                    
                    let btn3 = UIButton(type: .custom)
                    btn3.setImage(UIImage(named: "calendar"), for: .normal)//shadow-icon-1
                    btn3.frame = CGRect(x: self.view.frame.size.width - 70, y: 0, width: 20, height: 20)
                    btn3.addTarget(self, action: #selector(self.calenderBtnPressed), for: .touchUpInside)
                    let item3 = UIBarButtonItem(customView: btn3)
                    
                    
                    
                    
                    
                    
                    //Right items
                    self.navigationItem.setRightBarButtonItems([item1,item3], animated: true)
                    
                    
                }
                
               DispatchQueue.global(qos: .background).async {
                    
                    self.GetCompanySchoolProfile()
                    
                }
            }
        }
    }
    
    //MARK: - Functions
    
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
        
        let btn_actionRating = UIButton(type: .custom)
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
        
        let vc = Global.macros.Storyboard.instantiateViewController(withIdentifier: "ratingView") as! RatingViewController
        _ = self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func customView(view : UIView) {
        
        view.layer.cornerRadius = 4
        view.clipsToBounds = true
        view.layer.borderColor = UIColor.init(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 0.5).cgColor
        view.layer.borderWidth = 1.0
        
    }
    
    
    func notificationBtnPressed(sender: AnyObject){
        
        let vc = Global.macros.Storyboard.instantiateViewController(withIdentifier: "Notifications") as! NotificationsViewController
        _ = self.navigationController?.pushViewController(vc, animated: true)
    
    }
    
    func chatBtnPressed(sender: AnyObject){
        self.showAlert(Message: "Coming Soon", vc: self)
    }
    
    func shadowBtnPressed(sender: AnyObject){
        self.showAlert(Message: "Coming Soon", vc: self)
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
                            video_url = nil
                            
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
    
    
    func GetCompanySchoolProfile()
    {
        let dict =  NSMutableDictionary()
        dict.setValue(SavedPreferences.value(forKey: Global.macros.kUserId)as! NSNumber, forKey: Global.macros.kUserId)
        dict.setValue(user_IdMyProfile, forKey: "otherUserId")
        
        print(dict)
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
                        
                        dict_userInfo = response.1
                        array_public_UserSocialSites.removeAll()
                        
                        
//                        let verified = (response.1).value(forKey: "emailVerified")! as? NSNumber
//                        
//                        if verified == 0 {
//                            
//                            DispatchQueue.main.async {
//                                self.clearAllNotice()
//                                
//                                bool_fromMobile = false
//                                bool_NotVerified = false
//                                bool_LocationFilter = false
//                                bool_PlayFromProfile = false
//                                bool_AllTypeOfSearches = false
//                                bool_CompanySchoolTrends = false
//                                bool_fromVerificationMobile = false
//                                bool_UserIdComingFromSearch = false
//                                
//                                SavedPreferences.set(nil, forKey: "user_verified")
//                                SavedPreferences.set(nil, forKey: "sessionToken")
//                                SavedPreferences.removeObject(forKey: Global.macros.kUserId)
//                                let vc = Global.macros.Storyboard.instantiateViewController(withIdentifier: "Login")
//                                Global.macros.kAppDelegate.window?.rootViewController = vc
//                                
//                            }
//                        }

                        
                        //fetching urls
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
                        
                        
                        let str =  (response.1).value(forKey: "videoUrl") as? String
                        if str != nil {
                            video_url = NSURL(string: str!) as URL?
                        }
                        
                        //if coming from search class
                        if bool_UserIdComingFromSearch == true{
                            
                            let r = (response.1).value(forKey: Global.macros.krole) as? String
                            //  if it is company
                            if r == "COMPANY"{
                                
                                //setting titles of labels
                                self.lbl_title__cmpnyschool_withthesesoccupation.text = "School with these occupations"
                                
                                self.lbl_title_Users.text = "Users employed"
                                
                                
                                
                                //setting name of company
                                if (response.1).value(forKey: Global.macros.kcompanyName) as? String != nil {
                                    
                                    self.navigationItem.title = ((response.1).value(forKey: Global.macros.kcompanyName) as? String)?.capitalized
                                    
                                    
                                }
                                
                                //setting rating number
                                ratingview_name = (response.1).value(forKey: Global.macros.kcompanyName) as? String
                                
                                
                                //setting company url
                                if (response.1).value(forKey: Global.macros.kCompanyURL) as? String != nil &&  (response.1).value(forKey: Global.macros.kCompanyURL) as? String != "" &&  (response.1).value(forKey: Global.macros.kCompanyURL) as? String != " "{
                                    
                                    self.lbl_company_schoolUrl.isHidden = false
                                    self.btn_LinkOpenSchoolCompany.isHidden = false

                                    self.imgView_Url.isHidden = false
                                    self.lbl_company_schoolUrl.text = (response.1).value(forKey: Global.macros.kCompanyURL) as? String
                                    
                                    
                                    if array_public_UserSocialSites.count > 0{//social sites not nil
                                        self.tblView_SocialSites.isHidden = false
                                        
                                        
                                        if array_public_UserSocialSites.count == 1 {//social site count 1
                                            
                                            self.k_Constraint_Height_tblView.constant = 50.0
                                            self.k_Constraint_ViewDescriptionHeight.constant = 180.0
                                            
                                            
                                        }
                                        else  if array_public_UserSocialSites.count == 2{//social site count 2
                                            
                                            self.k_Constraint_Height_tblView.constant = 100.0
                                            self.k_Constraint_ViewDescriptionHeight.constant = 210.0
                                            
                                        }
                                        else{//social site count 3
                                            
                                            self.k_Constraint_Height_tblView.constant = 150.0
                                            self.k_Constraint_ViewDescriptionHeight.constant = 230.0
                                        }
                                        
                                        
                                        self.tblView_SocialSites.reloadData()
                                    }
                                    else{//social sites nil
                                        
                                        self.tblView_SocialSites.isHidden = true
                                        self.k_Constraint_ViewDescriptionHeight.constant = 157
                                        
                                    }
                                }
                                else {
                                    self.btn_LinkOpenSchoolCompany.isHidden = true

                                    self.lbl_company_schoolUrl.isHidden = true
                                    self.imgView_Url.isHidden = true
                                    
                                    
                                    if array_public_UserSocialSites.count > 0{//social sites not nil
                                        self.tblView_SocialSites.isHidden = false
                                        self.k_Constraint_Top_yblView.constant = -25
                                        
                                        if array_public_UserSocialSites.count == 1 {//social site count 1
                                            
                                            self.k_Constraint_Height_tblView.constant = 50.0
                                            self.k_Constraint_ViewDescriptionHeight.constant = 160.0
                                            
                                            
                                        }
                                        else  if array_public_UserSocialSites.count == 2{//social site count 2
                                            
                                            self.k_Constraint_Height_tblView.constant = 100.0
                                            self.k_Constraint_ViewDescriptionHeight.constant = 180.0
                                            
                                        }
                                        else{//social site count 3
                                            
                                            self.k_Constraint_Height_tblView.constant = 150.0
                                            self.k_Constraint_ViewDescriptionHeight.constant = 210.0
                                        }
                                        
                                        
                                        self.tblView_SocialSites.reloadData()
                                    }
                                    else{//social sites nil
                                        
                                        self.tblView_SocialSites.isHidden = true
                                        self.k_Constraint_ViewDescriptionHeight.constant = 135
                                        
                                    }

                                }
                                
                                
                            }else{//coming from search if it is school
                                
                                
                                //setting titles of labels
                                self.lbl_title__cmpnyschool_withthesesoccupation.text = "Company with these occupations"
                                
                                self.lbl_title_Users.text = "Users attended this school"
                                
                                
                                if (response.1).value(forKey: Global.macros.kschoolName) as? String != nil  && (response.1).value(forKey: Global.macros.kschoolName) as? String != "" {
                                    
                                    
                                    self.navigationItem.title = ((response.1).value(forKey: Global.macros.kschoolName) as? String)?.capitalized
                                    
                                }
                                
                                //getting school ratin gto send to next view
                                ratingview_name = (response.1).value(forKey: Global.macros.kschoolName) as? String
                                
                                
                                //setting school url
                                if (response.1).value(forKey: Global.macros.kSchoolURL) as? String != nil && (response.1).value(forKey: Global.macros.kSchoolURL) as? String != "" &&  (response.1).value(forKey: Global.macros.kSchoolURL) as? String != " "{
                                    self.btn_LinkOpenSchoolCompany.isHidden = false
                                    self.lbl_company_schoolUrl.isHidden = false
                                    self.imgView_Url.isHidden = false
                                    self.lbl_company_schoolUrl.text = (response.1).value(forKey: Global.macros.kSchoolURL) as? String
                                    
                                    if array_public_UserSocialSites.count > 0{//social sites not nil
                                        self.tblView_SocialSites.isHidden = false
                                        
                                        
                                        if array_public_UserSocialSites.count == 1 {//social site count 1
                                            
                                            self.k_Constraint_Height_tblView.constant = 50.0
                                            self.k_Constraint_ViewDescriptionHeight.constant = 180.0
                                            
                                            
                                        }
                                        else  if array_public_UserSocialSites.count == 2{//social site count 2
                                            
                                            self.k_Constraint_Height_tblView.constant = 100.0
                                            self.k_Constraint_ViewDescriptionHeight.constant = 210.0
                                            
                                        }
                                        else{//social site count 3
                                            
                                            self.k_Constraint_Height_tblView.constant = 150.0
                                            self.k_Constraint_ViewDescriptionHeight.constant = 230.0
                                        }
                                        
                                        self.tblView_SocialSites.reloadData()
                                    }
                                    else{//social sites nil
                                        
                                        self.tblView_SocialSites.isHidden = true
                                        self.k_Constraint_ViewDescriptionHeight.constant = 167
                                        
                                    }
                                }
                                    
                                else {
                                    self.btn_LinkOpenSchoolCompany.isHidden = true

                                    self.lbl_company_schoolUrl.isHidden = true
                                    self.imgView_Url.isHidden = true
                                    
                                    
                                    if array_public_UserSocialSites.count > 0{//social sites not nil
                                        self.tblView_SocialSites.isHidden = false
                                        self.k_Constraint_Top_yblView.constant = -25
                                        
                                        if array_public_UserSocialSites.count == 1 {//social site count 1
                                            
                                            self.k_Constraint_Height_tblView.constant = 50.0
                                            self.k_Constraint_ViewDescriptionHeight.constant = 160.0
                                            
                                            
                                        }
                                        else  if array_public_UserSocialSites.count == 2{//social site count 2
                                            
                                            self.k_Constraint_Height_tblView.constant = 100.0
                                            self.k_Constraint_ViewDescriptionHeight.constant = 180.0
                                            
                                        }
                                        else{//social site count 3
                                            
                                            self.k_Constraint_Height_tblView.constant = 150.0
                                            self.k_Constraint_ViewDescriptionHeight.constant = 210.0
                                        }
                                        
                                        self.tblView_SocialSites.reloadData()
                                    }
                                    else{//social sites nil
                                        
                                        self.tblView_SocialSites.isHidden = true
                                        self.k_Constraint_ViewDescriptionHeight.constant = 135
                                        
                                    }
                                }
                            }
                        }
                        else if bool_ComingFromList == true {
                           
                                
                                let r = (response.1).value(forKey: Global.macros.krole) as? String
                                //  if it is company
                                if r == "COMPANY"{
                                    
                                    //setting titles of labels
                                    self.lbl_title__cmpnyschool_withthesesoccupation.text = "School with these occupations"
                                    
                                    self.lbl_title_Users.text = "Users employed"
                                    
                                    
                                    
                                    //setting name of company
                                    if (response.1).value(forKey: Global.macros.kcompanyName) as? String != nil {
                                        
                                        self.navigationItem.title = ((response.1).value(forKey: Global.macros.kcompanyName) as? String)?.capitalized
                                        
                                        
                                    }
                                    
                                    //setting rating number
                                    ratingview_name = (response.1).value(forKey: Global.macros.kcompanyName) as? String
                                    
                                    
                                    //setting company url
                                    if (response.1).value(forKey: Global.macros.kCompanyURL) as? String != nil &&  (response.1).value(forKey: Global.macros.kCompanyURL) as? String != "" &&  (response.1).value(forKey: Global.macros.kCompanyURL) as? String != " "{
                                        
                                        self.btn_LinkOpenSchoolCompany.isHidden = false
                                        self.lbl_company_schoolUrl.isHidden = false
                                        self.imgView_Url.isHidden = false
                                        self.lbl_company_schoolUrl.text = (response.1).value(forKey: Global.macros.kCompanyURL) as? String
                                        
                                        
                                        if array_public_UserSocialSites.count > 0{//social sites not nil
                                            self.tblView_SocialSites.isHidden = false
                                            
                                            
                                            if array_public_UserSocialSites.count == 1 {//social site count 1
                                                
                                                self.k_Constraint_Height_tblView.constant = 50.0
                                                self.k_Constraint_ViewDescriptionHeight.constant = 180.0
                                                
                                                
                                            }
                                            else  if array_public_UserSocialSites.count == 2{//social site count 2
                                                
                                                self.k_Constraint_Height_tblView.constant = 100.0
                                                self.k_Constraint_ViewDescriptionHeight.constant = 210.0
                                                
                                            }
                                            else{//social site count 3
                                                
                                                self.k_Constraint_Height_tblView.constant = 150.0
                                                self.k_Constraint_ViewDescriptionHeight.constant = 230.0
                                            }
                                            
                                            
                                            self.tblView_SocialSites.reloadData()
                                        }
                                        else{//social sites nil
                                            
                                            self.tblView_SocialSites.isHidden = true
                                            self.k_Constraint_ViewDescriptionHeight.constant = 157
                                            
                                        }
                                    }
                                    else {
                                        
                                        self.btn_LinkOpenSchoolCompany.isHidden = true
                                        self.lbl_company_schoolUrl.isHidden = true

                                        self.imgView_Url.isHidden = true
                                        
                                        
                                        if array_public_UserSocialSites.count > 0{//social sites not nil
                                            self.tblView_SocialSites.isHidden = false
                                            self.k_Constraint_Top_yblView.constant = -25
                                            
                                            if array_public_UserSocialSites.count == 1 {//social site count 1
                                                
                                                self.k_Constraint_Height_tblView.constant = 50.0
                                                self.k_Constraint_ViewDescriptionHeight.constant = 160.0
                                                
                                                
                                            }
                                            else  if array_public_UserSocialSites.count == 2{//social site count 2
                                                
                                                self.k_Constraint_Height_tblView.constant = 100.0
                                                self.k_Constraint_ViewDescriptionHeight.constant = 180.0
                                                
                                            }
                                            else{//social site count 3
                                                
                                                self.k_Constraint_Height_tblView.constant = 150.0
                                                self.k_Constraint_ViewDescriptionHeight.constant = 210.0
                                            }
                                            
                                            
                                            self.tblView_SocialSites.reloadData()
                                        }
                                        else{//social sites nil
                                            
                                            self.tblView_SocialSites.isHidden = true
                                            self.k_Constraint_ViewDescriptionHeight.constant = 135
                                            
                                        }
                                        
                                    }
                                    
                                    
                                }else{//coming from search if it is school
                                    
                                    
                                    //setting titles of labels
                                    self.lbl_title__cmpnyschool_withthesesoccupation.text = " Company with these occupations"
                                    
                                    self.lbl_title_Users.text = "Users attended this school"
                                    
                                    
                                    if (response.1).value(forKey: Global.macros.kschoolName) as? String != nil  && (response.1).value(forKey: Global.macros.kschoolName) as? String != "" {
                                        
                                        
                                        self.navigationItem.title = ((response.1).value(forKey: Global.macros.kschoolName) as? String)?.capitalized
                                        
                                    }
                                    
                                    //getting school ratin gto send to next view
                                    ratingview_name = (response.1).value(forKey: Global.macros.kschoolName) as? String
                                    
                                    
                                    //setting school url
                                    if (response.1).value(forKey: Global.macros.kSchoolURL) as? String != nil && (response.1).value(forKey: Global.macros.kSchoolURL) as? String != "" &&  (response.1).value(forKey: Global.macros.kSchoolURL) as? String != " "{
                                        
                                        self.btn_LinkOpenSchoolCompany.isHidden = false
                                        self.lbl_company_schoolUrl.isHidden = false
                                        self.imgView_Url.isHidden = false
                                        self.lbl_company_schoolUrl.text = (response.1).value(forKey: Global.macros.kSchoolURL) as? String
                                        
                                        if array_public_UserSocialSites.count > 0{//social sites not nil
                                            self.tblView_SocialSites.isHidden = false
                                            
                                            
                                            if array_public_UserSocialSites.count == 1 {//social site count 1
                                                
                                                self.k_Constraint_Height_tblView.constant = 50.0
                                                self.k_Constraint_ViewDescriptionHeight.constant = 180.0
                                                
                                                
                                            }
                                            else  if array_public_UserSocialSites.count == 2{//social site count 2
                                                
                                                self.k_Constraint_Height_tblView.constant = 100.0
                                                self.k_Constraint_ViewDescriptionHeight.constant = 210.0
                                                
                                            }
                                            else{//social site count 3
                                                
                                                self.k_Constraint_Height_tblView.constant = 150.0
                                                self.k_Constraint_ViewDescriptionHeight.constant = 230.0
                                            }
                                            
                                            self.tblView_SocialSites.reloadData()
                                        }
                                        else{//social sites nil
                                            
                                            self.tblView_SocialSites.isHidden = true
                                            self.k_Constraint_ViewDescriptionHeight.constant = 167
                                            
                                        }
                                    }
                                        
                                    else {
                                        self.btn_LinkOpenSchoolCompany.isHidden = true

                                        self.lbl_company_schoolUrl.isHidden = true
                                        self.imgView_Url.isHidden = true
                                        
                                        
                                        if array_public_UserSocialSites.count > 0{//social sites not nil
                                            self.tblView_SocialSites.isHidden = false
                                            self.k_Constraint_Top_yblView.constant = -25
                                            
                                            if array_public_UserSocialSites.count == 1 {//social site count 1
                                                
                                                self.k_Constraint_Height_tblView.constant = 50.0
                                                self.k_Constraint_ViewDescriptionHeight.constant = 160.0
                                                
                                                
                                            }
                                            else  if array_public_UserSocialSites.count == 2{//social site count 2
                                                
                                                self.k_Constraint_Height_tblView.constant = 100.0
                                                self.k_Constraint_ViewDescriptionHeight.constant = 180.0
                                                
                                            }
                                            else{//social site count 3
                                                
                                                self.k_Constraint_Height_tblView.constant = 150.0
                                                self.k_Constraint_ViewDescriptionHeight.constant = 210.0
                                            }
                                            
                                            self.tblView_SocialSites.reloadData()
                                        }
                                        else{//social sites nil
                                            
                                            self.tblView_SocialSites.isHidden = true
                                            self.k_Constraint_ViewDescriptionHeight.constant = 135
                                            
                                        }
                                    }
                                }
                            }
                      
                            
                        else{ //opening direct profile
                            
                            // if company
                            if SavedPreferences.value(forKey: Global.macros.krole) as? String == "COMPANY"{
                                
                                //setting titles of labels
                                self.lbl_title__cmpnyschool_withthesesoccupation.text = "School with these occupations"
                                
                                self.lbl_title_Users.text = "Users employed"
                                
                                
                                
                                // setting company name on direct profile
                                if (response.1).value(forKey: Global.macros.kcompanyName) as? String != nil {
                                    
                                    self.navigationItem.title = ((response.1).value(forKey: Global.macros.kcompanyName) as? String)?.capitalized
                                    
                                }
                                
                                //setting company url on direct profile
                                if (response.1).value(forKey: Global.macros.kCompanyURL) as? String != nil &&  (response.1).value(forKey: Global.macros.kCompanyURL) as? String != "" &&  (response.1).value(forKey: Global.macros.kCompanyURL) as? String != " "{
                                    self.btn_LinkOpenSchoolCompany.isHidden = false

                                    self.lbl_company_schoolUrl.isHidden = false
                                    self.imgView_Url.isHidden = false
                                    self.lbl_company_schoolUrl.text = (response.1).value(forKey: Global.macros.kCompanyURL) as? String
                                    
                                    
                                    
                                    if array_public_UserSocialSites.count > 0{//social sites not nil
                                        self.tblView_SocialSites.isHidden = false
                                        
                                        
                                        if array_public_UserSocialSites.count == 1 {//social site count 1
                                            
                                            self.k_Constraint_Height_tblView.constant = 50.0
                                            self.k_Constraint_ViewDescriptionHeight.constant = 180.0
                                            
                                            
                                        }
                                        else  if array_public_UserSocialSites.count == 2{//social site count 2
                                            
                                            self.k_Constraint_Height_tblView.constant = 100.0
                                            self.k_Constraint_ViewDescriptionHeight.constant = 210.0
                                            
                                        }
                                        else{//social site count 3
                                            
                                            self.k_Constraint_Height_tblView.constant = 150.0
                                            self.k_Constraint_ViewDescriptionHeight.constant = 230.0
                                        }
                                        
                                        
                                        self.tblView_SocialSites.reloadData()
                                    }
                                    else{//social sites nil
                                        
                                        self.tblView_SocialSites.isHidden = true
                                        self.k_Constraint_ViewDescriptionHeight.constant = 157
                                        
                                    }
                                    
                                }
                                else {
                                    self.btn_LinkOpenSchoolCompany.isHidden = true

                                    self.lbl_company_schoolUrl.isHidden = true
                                    self.imgView_Url.isHidden = true
                                    
                                    
                                    if array_public_UserSocialSites.count > 0{//social sites not nil
                                        self.tblView_SocialSites.isHidden = false
                                        self.k_Constraint_Top_yblView.constant = -25
                                        
                                        if array_public_UserSocialSites.count == 1 {//social site count 1
                                            
                                            self.k_Constraint_Height_tblView.constant = 50.0
                                            self.k_Constraint_ViewDescriptionHeight.constant = 160.0
                                            
                                            
                                        }
                                        else  if array_public_UserSocialSites.count == 2{//social site count 2
                                            
                                            self.k_Constraint_Height_tblView.constant = 100.0
                                            self.k_Constraint_ViewDescriptionHeight.constant = 180.0
                                            
                                        }
                                        else{//social site count 3
                                            
                                            self.k_Constraint_Height_tblView.constant = 150.0
                                            self.k_Constraint_ViewDescriptionHeight.constant = 210.0
                                        }
                                        
                                        
                                        self.tblView_SocialSites.reloadData()
                                    }
                                    else{//social sites nil
                                        
                                        self.tblView_SocialSites.isHidden = true
                                        self.k_Constraint_ViewDescriptionHeight.constant = 135
                                        
                                    }
                                    
                                }
                            }
                            else{
                                
                                
                                //setting titles of labels
                                self.lbl_title__cmpnyschool_withthesesoccupation.text = "Company with these occupations"
                                self.lbl_title_Users.text = "Users attended this school"

                                
                                
                                // setting school name on direct profile
                                if (response.1).value(forKey: Global.macros.kschoolName) as? String != nil  && (response.1).value(forKey: Global.macros.kschoolName) as? String != "" {
                                    
                                    
                                    self.navigationItem.title = ((response.1).value(forKey: Global.macros.kschoolName) as? String)?.capitalized
                                }
                                
                                if (response.1).value(forKey: Global.macros.kschoolName) as? String != nil  && (response.1).value(forKey: Global.macros.kcompanyName) as? String != "" {
                                    
                                    
                                    self.navigationItem.title = ((response.1).value(forKey: Global.macros.kcompanyName) as? String)?.capitalized
                                }
                                
                                
                                //setting school url on direct profile
                                if (response.1).value(forKey: Global.macros.kSchoolURL) as? String != nil && (response.1).value(forKey: Global.macros.kSchoolURL) as? String != "" &&  (response.1).value(forKey: Global.macros.kSchoolURL) as? String != " "{
                                    
                                    
                                    self.btn_LinkOpenSchoolCompany.isHidden = false
                                    self.lbl_company_schoolUrl.isHidden = false
                                    self.imgView_Url.isHidden = false
                                    self.lbl_company_schoolUrl.text = (response.1).value(forKey: Global.macros.kSchoolURL) as? String
                                    
                                    if array_public_UserSocialSites.count > 0{//social sites not nil
                                        self.tblView_SocialSites.isHidden = false
                                        
                                        
                                        if array_public_UserSocialSites.count == 1 {//social site count 1
                                            
                                            self.k_Constraint_Height_tblView.constant = 50.0
                                            self.k_Constraint_ViewDescriptionHeight.constant = 180.0
                                            
                                            
                                        }
                                        else  if array_public_UserSocialSites.count == 2{//social site count 2
                                            
                                            self.k_Constraint_Height_tblView.constant = 100.0
                                            self.k_Constraint_ViewDescriptionHeight.constant = 210.0
                                            
                                        }
                                        else{//social site count 3
                                            
                                            self.k_Constraint_Height_tblView.constant = 150.0
                                            self.k_Constraint_ViewDescriptionHeight.constant = 230.0
                                        }
                                        
                                        self.tblView_SocialSites.reloadData()
                                    }
                                    else{//social sites nil
                                        
                                        self.tblView_SocialSites.isHidden = true
                                        self.k_Constraint_ViewDescriptionHeight.constant = 167
                                        
                                    }
                                }
                                    
                                    
                                    
                                else {
                                    
                                    self.btn_LinkOpenSchoolCompany.isHidden = true

                                    self.lbl_company_schoolUrl.isHidden = true
                                    self.imgView_Url.isHidden = true
                                    
                                    
                                    if array_public_UserSocialSites.count > 0{//social sites not nil
                                        self.tblView_SocialSites.isHidden = false
                                        self.k_Constraint_Top_yblView.constant = -25
                                        
                                        if array_public_UserSocialSites.count == 1 {//social site count 1
                                            
                                            self.k_Constraint_Height_tblView.constant = 50.0
                                            self.k_Constraint_ViewDescriptionHeight.constant = 160.0
                                            
                                            
                                        }
                                        else  if array_public_UserSocialSites.count == 2{//social site count 2
                                            
                                            self.k_Constraint_Height_tblView.constant = 100.0
                                            self.k_Constraint_ViewDescriptionHeight.constant = 180.0
                                            
                                        }
                                        else{//social site count 3
                                            
                                            self.k_Constraint_Height_tblView.constant = 150.0
                                            self.k_Constraint_ViewDescriptionHeight.constant = 210.0
                                        }
                                        
                                        self.tblView_SocialSites.reloadData()
                                    }
                                    else{//social sites nil
                                        
                                        self.tblView_SocialSites.isHidden = true
                                        self.k_Constraint_ViewDescriptionHeight.constant = 135
                                        
                                    }
                                }
                            }
                            
                        }
                        
                        
                        let dbl = 2.0
                        self.rating_number = "\((response.1).value(forKey: "avgRating")!)"
                        
                        if  dbl.truncatingRemainder(dividingBy: 1) == 0
                        {
                            self.lbl_RatingCount.text = self.rating_number! + ".0"
                            
                        }
                        else {
                            
                            self.lbl_RatingCount.text = self.rating_number!
                            
                        }
                        
                        self.lbl_totalRatingCount.text = "\((response.1).value(forKey: "ratingCount")!)"
                        
                        
                        
                        //  profileImageUrl
                        var profileurl = (response.1).value(forKey: "profileImageUrl")as? String
                        profileurl = profileurl?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                        ratingview_imgurl = profileurl?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                        
                        if profileurl != nil {
                            self.imgView_ProfilePic.sd_setImage(with: URL(string:profileurl!), placeholderImage: UIImage(named: "profile-icon-1"))//image
                        }
                        
                        
                        if (response.1).value(forKey: Global.macros.klocation) as? String != "" && (response.1).value(forKey: Global.macros.klocation) != nil {
                            
                            if (((response.1).value(forKey: Global.macros.klocation) as? String)?.contains("United States"))! || (((response.1).value(forKey: Global.macros.klocation) as? String)?.contains("USA"))!
                            {
                                let str = (response.1).value(forKey: Global.macros.klocation) as? String
                                
                                var strArry = str?.components(separatedBy: ",")
                                print(strArry!)
                                strArry?.removeLast()
                                print(strArry!)
                                var tempStr:String = ""
                                for (index,element) in (strArry?.enumerated())!
                                {
                                    var coma = ""
                                    
                                    if index == 0
                                    {
                                        coma = ""
                                    }
                                    else
                                    {
                                        coma = ","
                                    }
                                    
                                    tempStr = tempStr + coma + element
                                    
                              
                                  self.lbl_company_schoolLocation.text = tempStr
                                   
                                }
                                
                                print(tempStr)

                            }
                                
                            else {
                            
                            self.lbl_company_schoolLocation.text = (response.1).value(forKey: Global.macros.klocation) as? String
                                
                       
                        }
                            
                            
                        }
                        
                        self.lbl_CountverifiedShadowers.text = (((response.1).value(forKey: "shadowersVerified") as? NSDictionary)?.value(forKey: Global.macros.kcount) as? NSNumber)?.stringValue
                        self.lbl_CountshadowedYou.text = (((response.1).value(forKey: "shadowedByShadowUser") as? NSDictionary)?.value(forKey: Global.macros.kcount) as? NSNumber)?.stringValue
                        
                        
                        self.lbl_Count_cmpnyschool_withthesesoccupation.text = (((response.1).value(forKey: Global.macros.kschoolCompanyWithTheseOccupations) as? NSDictionary)?.value(forKey: Global.macros.kcount) as? NSNumber)?.stringValue
                        
                        if  self.lbl_Count_cmpnyschool_withthesesoccupation.text == "" ||  self.lbl_Count_cmpnyschool_withthesesoccupation.text == " " || self.lbl_Count_cmpnyschool_withthesesoccupation.text == nil {
                            self.lbl_Count_cmpnyschool_withthesesoccupation.text = "0"
                        }
                        
                        self.lbl_Count_Users.text = (((response.1).value(forKey: Global.macros.kschoolCompanyWithTheseUsers) as? NSDictionary)?.value(forKey: Global.macros.kcount) as? NSNumber)?.stringValue
                        
                        if (response.1).value(forKey: Global.macros.kbio) as? String
                            != nil {
                            
                            self.txtView_Description.text = "\((response.1).value(forKey: Global.macros.kbio) as! String)"
                           // self.txtView_Description.isenable
                            self.lbl_Placeholder_description.isHidden = true
                            
                        }
                        else{
                            self.lbl_Placeholder_description.isHidden = false
                        }
                        
                        //getting occupations of company or school
                        let tmp_arr_occ = (response.1.value(forKey: Global.macros.koccupation) as? NSArray)?.mutableCopy() as! NSMutableArray
                        
                        for value in tmp_arr_occ{
                            
                            let name_interest = (value as! NSDictionary).value(forKey: "name") as? String
                            let id = (value as! NSDictionary).value(forKey: "occupationTypeId") as? NSNumber

                            let dict = NSMutableDictionary()
                            dict.setValue(name_interest, forKey: "name")
                            dict.setValue(id, forKey: "id")

                            
                            if self.array_UserOccupations.contains(dict) {
                                break
                            }
                            else{
                                self.array_UserOccupations.add(dict)
                                
                            }
                        }
                        
                        if self.array_UserOccupations.count > 0{
                            self.collection_View.isHidden = false
                            self.lbl_NoOccupationYet.isHidden = true
                            self.collection_View.reloadData()
                        }
                        else{
                            self.lbl_NoOccupationYet.isHidden = false
                            self.collection_View.isHidden = true
                        }
                        
                    }
                case 401:
                    self.AlertSessionExpire()
                    
                case 304:
                    
                    let TitleString = NSAttributedString(string: "Shadow", attributes: [
                        NSFontAttributeName : UIFont.systemFont(ofSize: 18),
                        NSForegroundColorAttributeName : Global.macros.themeColor_pink
                        ])
                    let MessageString = NSAttributedString(string: "User does not exist.", attributes: [
                        NSFontAttributeName : UIFont.systemFont(ofSize: 15),
                        NSForegroundColorAttributeName : Global.macros.themeColor_pink
                        ])
                    
                    DispatchQueue.main.async {
                        self.clearAllNotice()
                        
                        let alert = UIAlertController(title: "Shadow", message: "", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action) in
                            
                           _ = self.navigationController?.popViewController(animated: true)
                            
                        
                        }))
                        alert.view.layer.cornerRadius = 10.0
                        alert.view.clipsToBounds = true
                        alert.view.backgroundColor = UIColor.white
                        alert.view.tintColor = Global.macros.themeColor_pink
                        
                        alert.setValue(TitleString, forKey: "attributedTitle")
                        alert.setValue(MessageString, forKey: "attributedMessage")
                        self.present(alert, animated: true, completion: nil)
                        
                    }

                    
                    
                    
                    break
                    
                default:
                    self.showAlert(Message: Global.macros.kError, vc: self)
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
    
    
    func ArrayOfPhotos(data:Data)->(NSArray)
    {
        
        
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
    
    
    func Calender_SearchBtnPressed(sender: AnyObject){

        
        let vc = Global.macros.Storyboard.instantiateViewController(withIdentifier: "send_request") as! SendRequestViewController
        vc.user_Name =  self.navigationItem.title
        
        if self.lbl_company_schoolLocation.text != nil {
        vc.location_comSchool = self.lbl_company_schoolLocation.text
            
        }
        _ = self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func calenderBtnPressed(sender: AnyObject){
        

        
        let vc = Global.macros.Storyboard.instantiateViewController(withIdentifier: "MyRequests") as! RequestsListViewController
        vc.user_Name =  self.navigationItem.title
        _ = self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.revealViewController() != nil {
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
        }
    }
    

    
    //MARK: - Button Actions
    
    
    @IBAction func Action_OpenRatingView(_ sender: Any) {
        
        if self.revealViewController() != nil {
            self.revealViewController().rightRevealToggle(animated: false)
        }
      //  else {
        DispatchQueue.main.async {
            
            
            if bool_UserIdComingFromSearch == true {
                
                let vc = Global.macros.Storyboard.instantiateViewController(withIdentifier: "ratingView") as! RatingViewController
                _ = self.navigationController?.pushViewController(vc, animated: true)
                
            }
            else if bool_ComingFromList == true {
                bool_ComingRatingList = true
                let vc = Global.macros.Storyboard.instantiateViewController(withIdentifier: "ratingView") as! RatingViewController
                _ = self.navigationController?.pushViewController(vc, animated: true)


            }
            else{
                
                if self.lbl_totalRatingCount.text != "0"{
                    
                    let vc = Global.macros.Storyboard.instantiateViewController(withIdentifier: "ratingView") as! RatingViewController
                    _ = self.navigationController?.pushViewController(vc, animated: true)
                    
                }else{
                    self.showAlert(Message: "No ratings yet.", vc: self)
                    
                }
            }
        }
       // }
    }
    
    @IBAction func Action_OpenCompaniesSchoolList(_ sender: UIButton) {
        
    }
    
    
    @IBAction func Open_ProfileImage(_ sender: UIButton) {
        if self.revealViewController() != nil {
            self.revealViewController().rightRevealToggle(animated: false)
        }
            
    //    else {
        Global.macros.statusBar.isHidden = true
        let imgdata = UIImageJPEGRepresentation(imgView_ProfilePic.image!, 0.5)
        let photos = self.ArrayOfPhotos(data: imgdata!)
        let vc: NYTPhotosViewController = NYTPhotosViewController(photos: photos as? [NYTPhoto])
        vc.rightBarButtonItem = nil
        self.present(vc, animated: true, completion: nil)
       // }
    }
    
    @IBAction func PlayVideo(_ sender: UIButton) {
        
        
        if video_url != nil {
            bool_PlayFromProfile = true
            bool_VideoFromGallary = false

            DispatchQueue.main.async {
                
                let vc = Global.macros.Storyboard.instantiateViewController(withIdentifier: "Upload_Video") as! UploadViewController
                _ = self.navigationController?.present(vc, animated: true, completion: nil)
            }
        }
        else {
            
            self.showAlert(Message: "No video to play yet.", vc: self)
            
        }
    }
    
    @IBAction func ActionSocialMedia1(_ sender: UIButton) {
        
        SetWebViewUrl (index: 0)
    }
    
    @IBAction func ActionSocialMedia2(_ sender: UIButton) {
        
        SetWebViewUrl (index: 1)
    }
    
    @IBAction func ActionSocialMedia3(_ sender: UIButton) {
        
        SetWebViewUrl (index: 2)
    }
    
    
    @IBAction func action_OpenList(_ sender: UIButton) {
        
        
        if self.revealViewController() != nil {
            self.revealViewController().rightRevealToggle(animated: false)
        }
        
      //  else {
     //   if bool_UserIdComingFromSearch == false {

        var type:String?
        var navigation_title:String?

        
        if sender.tag == 0{//shadowers
            
            type = Global.macros.kShadow
            navigation_title =  "Shadowers"
            
        }else if sender.tag == 1{//shadowed
            
            type = Global.macros.kShadowed
            navigation_title = "Shadowed Users"

            
        }else if sender.tag == 2{//occupations
            
            type = Global.macros.k_Occupation
            navigation_title = "Users with these Occupation"
        
            
        }
        else {//users
            
            type = Global.macros.k_User
            navigation_title = "Users List"
            
            
        }
        
        
        let vc = Global.macros.Storyboard.instantiateViewController(withIdentifier: "listing") as! ListingViewController
        vc.type = type
        vc.ListuserId = self.user_IdMyProfile
            vc.navigation_title = navigation_title
            _ = self.navigationController?.pushViewController(vc, animated: true)

            
      //  }
    }
    
    
    @IBAction func Action_LinkOpenSchoolCompany(_ sender: UIButton) {
        
        if let checkURL = NSURL(string: lbl_company_schoolUrl.text!) {
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
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    /* override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
     
     }*/
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//MARK: - Class Extensions

extension ComapanySchoolViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
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
        
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "skill", for: indexPath)as! SkillsNInterestCollectionViewCell
        
        if array_UserOccupations.count > 0 {
            
            cell.lbl_Skill.text = (array_UserOccupations[indexPath.row]as! NSDictionary).value(forKey: "name")as? String
            
        }
      
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        var count:Int?
        count = array_UserOccupations.count
        
        if count! <= 2 {
            self.kheightViewBehindOccupation.constant = 100
            
        }
            
            
        else if count == 4 {
            
            self.kheightViewBehindOccupation.constant = 160
            
        }
        else {
            
          //  self.kheightViewBehindOccupation.constant = CGFloat(count! * 32) + CGFloat(18)
            DispatchQueue.main.async {
                self.kHeightCollectionView.constant = self.collection_View.contentSize.height
            self.kheightViewBehindOccupation.constant = self.collection_View.contentSize.height + 30
            
            }
        }
        
        if Global.DeviceType.IS_IPHONE_5 {
            
            if count == 3 {
                
                self.kheightViewBehindOccupation.constant = 160
                
            }
            
        }
        
        DispatchQueue.main.async {

        self.Scroll_View.contentSize = CGSize(width: self.view.frame.size.width, height:  self.k_Constraint_ViewDescriptionHeight.constant + self.kheightViewBehindOccupation.constant + 400)
        }
         return count!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if self.revealViewController() != nil {
            self.revealViewController().rightRevealToggle(animated: false)
        }
            
      //  else {
            
            let vc = Global.macros.Storyboard.instantiateViewController(withIdentifier: "OccupationDetail") as! OccupationDetailViewController
            vc.occupationId = (array_UserOccupations[indexPath.row] as! NSDictionary)["id"]! as? NSNumber
            _ = self.navigationController?.pushViewController(vc, animated: true)
    //    }
       
        
    }
    
    
}

extension ComapanySchoolViewController:UITableViewDelegate,UITableViewDataSource{
    
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
            if (site_url?.contains("https://www.facebook.com/"))!{
                let index = site_url?.index((site_url?.startIndex)!, offsetBy: 25)
                cell.lbl_UserSocialSite.text = site_url?.substring(from: index!)
            }else
            {
                 cell.lbl_UserSocialSite.text = site_url!
            }
            break
            
        case "linkedInUrl":
            //https://www.linkedin.com/ 25
            if (site_url?.contains("https://www.linkedin.com/"))!{

            let index = site_url?.index((site_url?.startIndex)!, offsetBy: 25)
            cell.lbl_UserSocialSite.text = site_url?.substring(from: index!)
            }else{
                cell.lbl_UserSocialSite.text = site_url!

            }
            break
            
            
        case "instagramUrl":
            //https://www.instagram.com/ 26
            if (site_url?.contains("https://www.instagram.com/"))!{
            let index = site_url?.index((site_url?.startIndex)!, offsetBy: 26)
            cell.lbl_UserSocialSite.text = site_url?.substring(from: index!)
            }else{
                cell.lbl_UserSocialSite.text = site_url!
            }
            break
            
            
        case "googlePlusUrl":
            //https://www.googleplus.com/ 27
            if (site_url?.contains("https://www.googleplus.com/"))!{

            let index = site_url?.index((site_url?.startIndex)!, offsetBy: 27)
            cell.lbl_UserSocialSite.text = site_url?.substring(from: index!)
            }else{
                cell.lbl_UserSocialSite.text = site_url!

            }
            break
            
            
        case "gitHubUrl":
            //https://www.github.com/ 23
            if (site_url?.contains("https://www.github.com/"))!{

            let index = site_url?.index((site_url?.startIndex)!, offsetBy: 23)
            cell.lbl_UserSocialSite.text = site_url?.substring(from: index!)
            }else{
                cell.lbl_UserSocialSite.text = site_url!
            }
            break
            
            
        case "twitterUrl":
            //https://www.twitter.com/ 24
            if (site_url?.contains("https://www.twitter.com/"))!{

            let index = site_url?.index((site_url?.startIndex)!, offsetBy: 24)
            cell.lbl_UserSocialSite.text = site_url?.substring(from: index!)
            }else{
                cell.lbl_UserSocialSite.text = site_url!
            }
            break
            
        default:
            break
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if self.revealViewController() != nil {
            self.revealViewController().rightRevealToggle(animated: false)
        }
            
      //  else {
            
        let site_url = (array_public_UserSocialSites[indexPath.row] as NSDictionary).value(forKey: "url") as? String
        let trimmedString = site_url?.trimmingCharacters(in: .whitespacesAndNewlines)

        print(trimmedString!)
        DispatchQueue.main.async {
            if let checkURL = NSURL(string: trimmedString!) {
                
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
      //  }
   
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 28
    }
}

extension ComapanySchoolViewController:UITabBarControllerDelegate{
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        bool_ComingRatingList = false
        
        if self.revealViewController() != nil {
            self.revealViewController().rightRevealToggle(animated: false)
        }

        if tabBarController.selectedIndex == 0{
            if self.revealViewController() != nil {
                self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
                self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
                
            }
        }
    }
}
