//
//  CustomSearchViewController.swift
//  Shadow
//
//  Created by Atinderjit Kaur on 03/07/17.
//  Copyright © 2017 Atinderjit Kaur. All rights reserved.
//

import UIKit

class CustomSearchViewController: UIViewController, UIGestureRecognizerDelegate {
    
    
    
    @IBOutlet weak var view_BehindSearchView: UIView!                //Custom View
    @IBOutlet weak var tblview_AllSearchResult: UITableView!
    @IBOutlet weak var view_CollectionView: UIView!                 // View behind collection view
    @IBOutlet weak var customCollectionView: UICollectionView!      //Custom Collection View
    @IBOutlet weak var kHeightTopView: NSLayoutConstraint!          // Height of top view i.e. behind navigation bar
    @IBOutlet weak var view_BehindProfile: UIView!                  //These are the views of only UI(white views)
    @IBOutlet weak var view_BehindBio: UIView!
    @IBOutlet weak var btn_HorizontalView: UIButton!               //Outlets of buttons
    @IBOutlet weak var btn_VerticalView: UIButton!
    @IBOutlet weak var btn_FilterLocation: UIButton!           //For Location filter
    @IBOutlet weak var img_DropDrown: UIImageView!
    @IBOutlet weak var view_Black: UIView!                     //For Location filter UI
    @IBOutlet weak var view_PopUp: UIView!
    @IBOutlet weak var custom_slider: UISlider!
    @IBOutlet weak var btn_Apply: UIButton!
    @IBOutlet weak var btn_Cancel: UIButton!
    @IBOutlet weak var lbl_Filter: UILabel!
    @IBOutlet weak var ktopToggleBtn: NSLayoutConstraint!
    
    
    fileprivate var array_ActualSocialSites = [
        ["name":"Facebook","name_url":"facebookUrl","image":UIImage(named: "facebookUrl")!],
        ["name":"LinkedIn","name_url":"linkedInUrl","image":UIImage(named: "linkedInUrl")!],
        ["name":"Twitter","name_url":"twitterUrl","image":UIImage(named: "twitterUrl")!],
        ["name":"gitHub","name_url":"gitHubUrl","image":UIImage(named: "gitHubUrl")!],
        ["name":"Google+","name_url":"googlePlusUrl","image":UIImage(named: "googlePlusUrl")!],
        ["name":"Instagram","name_url":"instagramUrl","image":UIImage(named: "instagramUrl")!]]
    
    
    fileprivate  var pageIndex : Int = 0                           //Pagination Parameters
    fileprivate var pageSize : Int = 0
    var pointNow : CGPoint?
    var isFetching:Bool =  false
    var bool_Search : Bool = false                          //This param for the cell for row at collection view to set data for first time.
    var bool_LastResultSearch : Bool = false                //When the pagination gives no data at last
    
    var searchBar = UISearchBar()                              //Making secondary Searchbar
    var barBtn_Search: UIBarButtonItem?
    var str_searchText: NSString?
    var arr_SearchData : NSMutableArray = NSMutableArray()
    var linkForOpenWebsite : String?                        //On collection view to open link of facebook, instagram and twitter etc.
    
    fileprivate var dicUrl: NSMutableDictionary = NSMutableDictionary()     //For social icons
    let array_URL = ["facebookUrl","linkedInUrl","instagramUrl","googlePlusUrl","gitHubUrl","twitterUrl"]
    
    var str_radiusInMiles : String?
    
    //MARK: Views default functions
    
    override func viewDidLayoutSubviews() {
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
            self.showSearchBar()    //Custom search bar
            let searchTextField:UITextField = self.searchBar.subviews[0].subviews.last as! UITextField         //Custom Designs for search bar
            searchTextField.layer.cornerRadius = 8
            searchTextField.textAlignment = NSTextAlignment.left
            searchTextField.textColor = UIColor.white
            let image:UIImage = UIImage(named: "customsearch")!
            let imageView:UIImageView = UIImageView.init(image: image)
            searchTextField.leftView = imageView
            searchTextField.attributedPlaceholder = NSAttributedString(string: "Search", attributes: [NSForegroundColorAttributeName: UIColor.white])
            searchTextField.leftViewMode = UITextFieldViewMode.always
            searchTextField.rightView = nil
            searchTextField.backgroundColor = UIColor.init(red: 144.0/255.0, green: 20.0/255.0, blue: 151.0/255.0, alpha: 1.0)
            self.searchBar.endEditing(true)
      
       
        
        tblview_AllSearchResult.tableFooterView = UIView()  //Set table extra rows eliminate
        
        str_radiusInMiles = "10000"    //Set default miles on start
        btn_FilterLocation.setTitle("Select distance", for: .normal)
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        
        if bool_LocationFilter == true {   //Check if location filter is selected then hit location api
            
            
            kHeightTopView.constant = 78
            btn_FilterLocation.isHidden = false
            img_DropDrown.isHidden = false
            self.GetSearchDataAccordingToLocation()
            
        }
            
        else if  bool_CompanySchoolTrends == true {  //Check if company,school,trends and occupation filter is selected then hit location api
            kHeightTopView.constant = 64
            ktopToggleBtn.constant = 19
            btn_FilterLocation.isHidden = true
            img_DropDrown.isHidden = true
            self.GetOnlyCompanyData()
            
        }
            
        else {   //Check if no filter applies
            
            kHeightTopView.constant = 64
            ktopToggleBtn.constant = 19
            btn_FilterLocation.isHidden = true
            img_DropDrown.isHidden = true
            self.getSearchData()
        }
        
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationItem.setHidesBackButton(true, animated:true)
        self.tabBarController?.tabBar.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
        self.bool_Search = true           //When we come back from view full profile.
        bool_UserIdComingFromSearch = false
        dic_DataOfProfileForOtherUser.removeAllObjects()
        
        
        SetButtonCustomAttributes(btn_Cancel)    //Designs changes of the location filter pop up
        SetButtonCustomAttributes(btn_Apply)
        
        
        custom_slider.addTarget(self, action: #selector(adjustLabelForSlider), for: .valueChanged)  //Custom slider on location filter action
        tblview_AllSearchResult.keyboardDismissMode = UIScrollViewKeyboardDismissMode.onDrag        //Hide keyboard on uitableview dragging
        tblview_AllSearchResult.keyboardDismissMode = UIScrollViewKeyboardDismissMode.interactive
        
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        
        bool_LastResultSearch = false
        bool_Occupation = false
        //self.arr_SearchData.removeAllObjects()
       self.searchBar.text = ""

    }
    
    //MARK: Custom Functions
    
    //MARK: Action of slider
    func adjustLabelForSlider(_ sender: UISlider) {
        
        let trackRect : CGRect = sender.trackRect(forBounds: sender.bounds)
        let thumbRect : CGRect = sender.thumbRect(forBounds: sender.bounds, trackRect: trackRect, value: sender.value)
        lbl_Filter.center = CGPoint(x: thumbRect.origin.x + sender.frame.origin.x + 5, y: sender.frame.origin.y - 7)
        
        let currentValue = Int(sender.value)
        lbl_Filter.text = "\(currentValue)"
        
    }
    
    
    
    // MARK: Tap gesture to hide keyboard
    func handle_Tap(_ sender: UITapGestureRecognizer) {
        
        self.view.endEditing(true)
        view_Black.isHidden = true
        view_PopUp.isHidden = true
        
        
    }
    
    
    //MARK: Custom ShowSearchBar
    func showSearchBar() {
        
        let btn_back = UIButton(type: .custom)    // Custom back button
        
        if bool_LocationFilter == true {
            
            searchBar.frame = CGRect(x: 40, y: self.view_BehindSearchView.frame.origin.y + 10, width: self.view_BehindSearchView.frame.width - 140, height: 45)
            
            let btn_back = UIButton(type: .custom)    // Custom back button
            btn_back.frame = CGRect(x: 0, y: 12, width: 42, height: 42)
            btn_back.setImage(UIImage(named:"back-new"), for: .normal)
            _ = UIBarButtonItem(customView: btn_back)
            btn_back.addTarget(self, action: #selector(self.PopView), for: .touchUpInside)
            view_BehindSearchView.addSubview(btn_back)
            
            
            if Global.DeviceType.IS_IPHONE_6  {  //Check of frame of search bar
                searchBar.frame = CGRect(x: 40, y: self.view_BehindSearchView.frame.origin.y + 10, width: self.view_BehindSearchView.frame.width - 80, height: 45)
            }
                
            else if  Global.DeviceType.IS_IPHONE_6P {
                
                searchBar.frame = CGRect(x: 40, y: self.view_BehindSearchView.frame.origin.y + 10, width: self.view_BehindSearchView.frame.width - 50, height: 45)
            }
            
        }
        else{
            
            searchBar.frame = CGRect(x: 40, y: self.view_BehindSearchView.frame.origin.y + 18, width: self.view_BehindSearchView.frame.width - 140, height: 45)
            
            btn_back.frame = CGRect(x: 0, y: 18, width: 42, height: 42)
            btn_back.setImage(UIImage(named:"back-new"), for: .normal)
            _ = UIBarButtonItem(customView: btn_back)
            btn_back.addTarget(self, action: #selector(self.PopView), for: .touchUpInside)
            view_BehindSearchView.addSubview(btn_back)
            
            if Global.DeviceType.IS_IPHONE_6 {  //Check of frame of search bar
                searchBar.frame = CGRect(x: 40, y: self.view_BehindSearchView.frame.origin.y + 18, width: self.view_BehindSearchView.frame.width - 80, height: 45)
            }
                
            else if  Global.DeviceType.IS_IPHONE_6P {
                
                searchBar.frame = CGRect(x: 40, y: self.view_BehindSearchView.frame.origin.y + 18, width: self.view_BehindSearchView.frame.width - 50, height: 45)
            }
        }
        
        searchBar.backgroundImage = UIImage()
        searchBar.returnKeyType = .done
        searchBar.delegate = self
        
        if let textFieldInsideSearchBar = self.searchBar.value(forKey: "searchField") as? UITextField,
            let glassIconView = textFieldInsideSearchBar.leftView as? UIImageView {
            
            //Magnifying glass
            glassIconView.image = glassIconView.image?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
            glassIconView.tintColor = UIColor.white
            
            textFieldInsideSearchBar.layer.borderColor = UIColor.clear.cgColor
            textFieldInsideSearchBar.layer.cornerRadius = 6.0
            textFieldInsideSearchBar.layer.borderWidth = 1.0
            
        }
        
        view_BehindSearchView.addSubview(searchBar)
        self.searchBar.alpha = 1
    }
    
    //Action of back icon near to search
    func PopView() {
        _ = self.navigationController?.popViewController(animated: true)
        bool_AllTypeOfSearches = false
        bool_LocationFilter = false
        bool_CompanySchoolTrends = false
        arr_SearchData.removeAllObjects()
    }
    
    
    func SetWebViewUrl (index:Int) {
        
        let tempArray = self.dicUrl.allKeys as! [String]
        
        if tempArray.count > 0 {
            
            let socialStr:String = tempArray[index]
            
            switch socialStr {
            case "facebookUrl":
                
                linkForOpenWebsite = self.dicUrl.value(forKey: "facebookUrl") as? String
                break
            case "linkedInUrl":
                
                linkForOpenWebsite = self.dicUrl.value(forKey: "linkedInUrl") as? String
                break
                
            case "twitterUrl":
                
                linkForOpenWebsite = self.dicUrl.value(forKey: "twitterUrl") as? String
                break
                
            case "googlePlusUrl":
                
                linkForOpenWebsite = self.dicUrl.value(forKey: "googlePlusUrl") as? String
                break
                
                
            case "instagramUrl":
                linkForOpenWebsite = self.dicUrl.value(forKey: "instagramUrl") as? String
                break
                
            case "gitHubUrl":
                linkForOpenWebsite = self.dicUrl.value(forKey: "gitHubUrl") as? String
                
            default: break
                
            }
        }
        
        
        if linkForOpenWebsite != nil && linkForOpenWebsite != ""{
            if let checkURL = NSURL(string: linkForOpenWebsite!) {
                
                if  UIApplication.shared.openURL(checkURL as URL){
                    print("URL Successfully Opened")
                }
                else {
                    self.showAlert(Message: "Invalid URL. Unable to open in browser.", vc: self)
                }
            }
            else {
                
                self.showAlert(Message:"Invalid URL. Unable to open in browser.", vc: self)
            }
        }
        else {
            self.showAlert(Message: "Invalid URL. Unable to open in browser.", vc: self)
        }
        
    }
    
    
    //MARK: Api to search the data from all options
    func getSearchData() {
        
        if self.checkInternetConnection()
        {
            
            if str_searchText  == "" ||  str_searchText  == nil
            {
                
                DispatchQueue.main.async {
                    self.pleaseWait()
                }
            }
            isFetching = false
            
            let dic:NSMutableDictionary = NSMutableDictionary()
            dic.setValue(SavedPreferences.value(forKey: Global.macros.kUserId)as! NSNumber, forKey: Global.macros.kUserId)
            dic.setValue(str_searchText, forKey: "searchKeyword") //string for search
            dic.setValue(pageIndex, forKey: "pageIndex")   //pageIndex
            dic.setValue( 10, forKey: "pageSize")    //pageSize
            
            print(dic)
            ProfileAPI.sharedInstance.AllSearchData(dict: dic, completion: {(response) in
                let status = (response).value(forKey: Global.macros.KStatus)as! NSNumber
                self.isFetching = true
                
                switch status
                {
                case 200:
                    self.clearAllNotice()
                    self.arr_SearchData.addObjects(from: (response.value(forKey: "data") as? NSArray as! [Any]))
                    self.bool_LastResultSearch = true
                    if self.arr_SearchData.count == 0 {
                        self.bool_LastResultSearch = false
                    }
                    DispatchQueue.main.async {
                        self.tblview_AllSearchResult.reloadData()
                        self.customCollectionView.reloadData()
                    }
                    
                case 210:
                    
                    DispatchQueue.main.async {
                        self.clearAllNotice()
                        self.bool_LastResultSearch = false
                        self.showAlert(Message: str_messageInWrongCeredentials!, vc: self)
                    }
                    
                case 400:
                    
                    self.clearAllNotice()
                    DispatchQueue.main.async {
                        self.bool_LastResultSearch = false
                        self.bool_Search = true
                        self.tblview_AllSearchResult.reloadData()
                        self.customCollectionView.reloadData()
                     //   self.showAlert(Message: "No more data to show.", vc: self)
                        
                        
                    }
                    
                case 401 :
                    DispatchQueue.main.async {
                        self.clearAllNotice()
                        self.AlertSessionExpire()
                    }
                    
                    
                case 500:
                    
                    self.clearAllNotice()
                    self.arr_SearchData.removeAllObjects()
                    DispatchQueue.main.async {
                        self.bool_LastResultSearch = false
                        self.tblview_AllSearchResult.reloadData()
                        self.customCollectionView.reloadData()
                    }
                    
                default:
                    break
                }
                
                
            }, errorBlock: {(err) in
                DispatchQueue.main.async {
                    self.bool_LastResultSearch = false
                    self.clearAllNotice()
                    self.showAlert(Message:(err?.localizedDescription)!, vc: self)
                }
            })
        }
        else
        {
            self.showAlert(Message: Global.macros.kInternetConnection, vc: self)
            
        }
    }
    
    //MARK: Api to search the data from location
    
    func GetSearchDataAccordingToLocation() {
        
        if self.checkInternetConnection()
        {
            if str_searchText  == "" ||  str_searchText  == nil
            {
                DispatchQueue.main.async {
                    self.pleaseWait()
                }
            }
            isFetching = false
            let dic:NSMutableDictionary = NSMutableDictionary()
            dic.setValue(SavedPreferences.value(forKey: Global.macros.kUserId)as! NSNumber, forKey: Global.macros.kUserId)
            dic.setValue(str_searchText, forKey: "searchKeyword")
            dic.setValue(str_radiusInMiles, forKey: "radiusInMiles")
            dic.setValue(myCurrentLat, forKey: "latitude")
            dic.setValue(myCurrentLong, forKey: "longitude")
            dic.setValue(0, forKey: "searchType")
            dic.setValue(pageIndex, forKey: "pageIndex")   //pageIndex
            dic.setValue( 10, forKey: "pageSize")          //pageSize
            
            print(dic)
            
            ProfileAPI.sharedInstance.AllSearchDataAsLocation(dict: dic, completion: {(response) in
                let status = (response).value(forKey: Global.macros.KStatus)as! NSNumber
                self.isFetching = true
                switch status
                {
                case 200:
                    self.clearAllNotice()
                    self.arr_SearchData.addObjects(from: (response.value(forKey: "data") as? NSArray as! [Any]))
                    print(self.arr_SearchData)
                    self.bool_LastResultSearch = true
                    if self.arr_SearchData.count == 0 {
                        self.bool_LastResultSearch = false
                    }
                    
                    DispatchQueue.main.async {
                        self.tblview_AllSearchResult.reloadData()
                        self.customCollectionView.reloadData()
                    }
                    
                case 210:
                    
                    DispatchQueue.main.async {
                        self.clearAllNotice()
                        self.bool_LastResultSearch = false
                        self.showAlert(Message: str_messageInWrongCeredentials!, vc: self)
                    }
                    
                case 400:
                    
                    DispatchQueue.main.async {
                        self.clearAllNotice()
                        self.bool_LastResultSearch = false
                        self.bool_Search = true
                        self.tblview_AllSearchResult.reloadData()
                        self.customCollectionView.reloadData()
                      //  self.showAlert(Message: "No more data to show.", vc: self)
                    }
                    
                case 401 :
                    DispatchQueue.main.async {
                        self.clearAllNotice()
                        self.AlertSessionExpire()
                    }
                    
                    
                case 500:
                    
                    self.arr_SearchData.removeAllObjects()
                    DispatchQueue.main.async {
                        self.clearAllNotice()
                        self.bool_LastResultSearch = false
                        self.tblview_AllSearchResult.reloadData()
                        self.customCollectionView.reloadData()
                        
                    }
                    
                default:
                    break
                }
                
                
            }, errorBlock: {(err) in
                DispatchQueue.main.async {
                    self.clearAllNotice()
                    self.bool_LastResultSearch = false
                    self.showAlert(Message:(err?.localizedDescription)!, vc: self)
                }
            })
        }
        else
        {
            self.showAlert(Message: Global.macros.kInternetConnection, vc: self)
        }
    }
    
    //MARK: Api to search the data from Company,school,trends and occupation
    
    
    func GetOnlyCompanyData() {
        
        if self.checkInternetConnection()
        {
            if str_searchText  == "" ||  str_searchText  == nil
            {
                DispatchQueue.main.async {
                    self.pleaseWait()
                }
            }
            isFetching = false
            let dic:NSMutableDictionary = NSMutableDictionary()
            dic.setValue(SavedPreferences.value(forKey: Global.macros.kUserId)as! NSNumber, forKey: Global.macros.kUserId)
            dic.setValue(ratingType, forKey: "ratingType")
            dic.setValue(str_searchText, forKey: "searchKeyword")
            dic.setValue(0, forKey: "searchType")
            dic.setValue(pageIndex, forKey: "pageIndex")   //pageIndex
            dic.setValue( 10, forKey: "pageSize")    //pageSize
            
            print(dic)
            
            ProfileAPI.sharedInstance.getAllTypeTopRatingListbyType(dict: dic, completion: {(response) in
                let status = (response).value(forKey: Global.macros.KStatus)as! NSNumber
                self.isFetching = true
                switch status
                {
                case 200:
                    self.clearAllNotice()
                    self.arr_SearchData.addObjects(from: (response.value(forKey: "data") as? NSArray as! [Any]))
                    print(self.arr_SearchData)
                    self.bool_LastResultSearch = true
                    if self.arr_SearchData.count == 0 {
                        self.bool_LastResultSearch = false
                    }
                    
                    DispatchQueue.main.async {
                        self.tblview_AllSearchResult.reloadData()
                        self.customCollectionView.reloadData()
                    }
                    
                case 210:
                    
                    DispatchQueue.main.async {
                        self.clearAllNotice()
                        self.bool_LastResultSearch = false
                        self.showAlert(Message: str_messageInWrongCeredentials!, vc: self)
                    }
                    
                case 400:
                    
                    DispatchQueue.main.async {
                        self.bool_Search = true
                        self.clearAllNotice()
                        self.bool_LastResultSearch = false
                        self.tblview_AllSearchResult.reloadData()
                        self.customCollectionView.reloadData()
                        //  self.showAlert(Message: "No data to show.", vc: self)
                    }
                    
                case 401 :
                    
                    DispatchQueue.main.async {
                        self.clearAllNotice()
                        self.AlertSessionExpire()
                    }
                    
                case 500:
                    
                    self.arr_SearchData.removeAllObjects()
                    DispatchQueue.main.async {
                        self.clearAllNotice()
                        self.bool_LastResultSearch = false
                        self.tblview_AllSearchResult.reloadData()
                        self.customCollectionView.reloadData()
                        
                    }
                    
                default:
                    break
                }
                
                
            }, errorBlock: {(err) in
                DispatchQueue.main.async {
                    
                    self.clearAllNotice()
                    self.bool_LastResultSearch = false
                    self.showAlert(Message:(err?.localizedDescription)!, vc: self)
                    
                }
            })
        }
            
        else
        {
            self.showAlert(Message: Global.macros.kInternetConnection, vc: self)
            
        }
        
    }
    
    func suffixNumber(number:NSNumber) -> NSString {
        
        var num:Double = number.doubleValue;
        let sign = ((num < 0) ? "-" : "" );
        
        num = fabs(num);
        
        if (num < 1000.0){
            return "\(sign)\(num)" as NSString;
        }
        
        let exp:Int = Int(log10(num) / 3.0 ); //log10(1000));
        
        let units:[String] = ["K","M","G","T","P","E"];
        
        let roundedNum:Double = round(10 * num / pow(1000.0,Double(exp))) / 10;
        
        return "\(sign)\(roundedNum)\(units[exp-1])" as NSString;
    }

    
    
    //MARK: Action of Buttons
    
    @IBAction func Action_ListView(_ sender: UIButton) {
        
        btn_HorizontalView.setImage(UIImage(named: "three-dot-icon"), for: .normal)
        btn_VerticalView.setImage(UIImage(named: "purpleHor"), for: .normal)
        
        tblview_AllSearchResult.isHidden = false
        view_CollectionView.isHidden = true
        searchBar.isHidden = false
        
        if bool_LocationFilter == true {
            
            btn_FilterLocation.isHidden = false
            img_DropDrown.isHidden = false
            
        }
        else {
            
            btn_FilterLocation.isHidden = true
            img_DropDrown.isHidden = true
            
        }
        
    }
    
    
    @IBAction func Action_HorizontalView(_ sender: Any) {
        
     //   if bool_Occupation == false {
            
            if arr_SearchData.count > 0 {
                
                
                if (btn_HorizontalView.currentImage?.isEqual(UIImage(named: "three-dot-icon")))! {
                    
                    //do something here
                    btn_HorizontalView.setImage(UIImage(named: "grayHorizontalLines"), for: .normal)
                    self.scrollViewDidEndDecelerating(customCollectionView)
                    tblview_AllSearchResult.isHidden = true
                    view_CollectionView.isHidden = false
                    searchBar.resignFirstResponder()
                    
                }
                    
                else {
                    
                    btn_HorizontalView.setImage(UIImage(named: "three-dot-icon"), for: .normal)
                    tblview_AllSearchResult.isHidden = false
                    view_CollectionView.isHidden = true
                    searchBar.isHidden = false
                    
                    if bool_LocationFilter == true {
                        
                        btn_FilterLocation.isHidden = false
                        img_DropDrown.isHidden = false
                        
                    }
                    else {
                        
                        btn_FilterLocation.isHidden = true
                        img_DropDrown.isHidden = true
                        
                    }
                    
                }
                
                
            }
            else {
                
                
                self.showAlert(Message: "No data found.", vc: self)
                
            }
            
    //    }
            
      /*  else {
            if arr_SearchData.count > 0 {
                
                
                if (btn_HorizontalView.currentImage?.isEqual(UIImage(named: "three-dot-icon")))! {
                    
                    //do something here
                    btn_HorizontalView.setImage(UIImage(named: "grayHorizontalLines"), for: .normal)
                    self.scrollViewDidEndDecelerating(customCollectionView)
                    tblview_AllSearchResult.isHidden = true
                    view_CollectionView.isHidden = false
                    
                    searchBar.resignFirstResponder()
                    
                    
                    
                }
                    
                else {
                    
                    btn_HorizontalView.setImage(UIImage(named: "three-dot-icon"), for: .normal)
                    tblview_AllSearchResult.isHidden = false
                    view_CollectionView.isHidden = true
                    searchBar.isHidden = false
                    
                    if bool_LocationFilter == true {
                        
                        btn_FilterLocation.isHidden = false
                        img_DropDrown.isHidden = false
                        
                    }
                    else {
                        
                        btn_FilterLocation.isHidden = true
                        img_DropDrown.isHidden = true
                        
                    }
                    
                }
                
                
            }
            else {
                
                
                self.showAlert(Message: "No data found.", vc: self)
                
            }
            
        } */
        
    }
    
    
    
    //MARK: - Button Actions
    
    
    @IBAction func Action_BackButtonOnCollectionView(_ sender: Any) {
        
        btn_HorizontalView.setImage(UIImage(named: "three-dot-icon"), for: .normal)
        tblview_AllSearchResult.isHidden = false
        view_CollectionView.isHidden = true
        searchBar.isHidden = false
        
        if bool_LocationFilter == true {
            
            btn_FilterLocation.isHidden = false
            img_DropDrown.isHidden = false
            
        }
        else {
            
            btn_FilterLocation.isHidden = true
            img_DropDrown.isHidden = true
            
        }

    }
    
    
    
    @IBAction func Action_Video(_ sender: UIButton) {
        print("atinder")
        
        if video_url != nil {
            
            bool_PlayFromProfile = true
            let vc = Global.macros.Storyboard.instantiateViewController(withIdentifier: "Upload_Video") as! UploadViewController
            _ = self.navigationController?.pushViewController(vc, animated: true)
            
        }
            
        else{
            
            
            self.showAlert(Message: "No video to play yet.", vc: self)
            
        }
        
        
    }
    
    @IBAction func Action_OpenSocialSite1(_ sender: UIButton) {
        linkForOpenWebsite = ""
        SetWebViewUrl (index: 0)
        
        
    }
    
    @IBAction func Action_OpenSocialSite2(_ sender: UIButton) {
        linkForOpenWebsite = ""
        
        SetWebViewUrl (index: 1)
        
        
    }
    
    @IBAction func Action_OpenSocialSite3(_ sender: UIButton) {
        linkForOpenWebsite = ""
        SetWebViewUrl (index: 2)
        
    }
    
    
    
    @IBAction func Action_ViewFullProfile(_ sender: UIButton) {
        
        bool_UserIdComingFromSearch = true
        let dict_Temp = (arr_SearchData[sender.tag] as! NSDictionary)["userDTO"] as? NSDictionary
        
        userIdFromSearch = dict_Temp?.value(forKey: "userId") as? NSNumber
        let str_role = dict_Temp?.value(forKey: "role") as? String
        dic_DataOfProfileForOtherUser = NSMutableDictionary()
        dic_DataOfProfileForOtherUser = (arr_SearchData[sender.tag] as! NSDictionary).mutableCopy() as! NSMutableDictionary
        
        
        if str_role == "USER" {

            let vc = Global.macros.Storyboard.instantiateViewController(withIdentifier: "user") as! ProfileVC
            _ = self.navigationController?.pushViewController(vc, animated: true)
            
        }
            
        else {
            
            let vc = Global.macros.Storyboard.instantiateViewController(withIdentifier: "company") as! ComapanySchoolViewController
            _ = self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
    
    
    @IBAction func ActionSelectLocationFilter(_ sender: Any) {
        
        self.view.endEditing(true)
        view_Black.isHidden = false
        view_PopUp.isHidden = false
        
    }
    
    
    
    @IBAction func Action_Slider(_ sender: UISlider) {
        
        let currentValue = Int(sender.value)
        str_radiusInMiles = "\(currentValue)"
        
    }
    
 
    
    @IBAction func Action_FilterLocationApply(_ sender: Any) {
        
        btn_FilterLocation.setTitle(str_radiusInMiles! + " " + "MILES", for: .normal)
        view_Black.isHidden = true
        view_PopUp.isHidden = true
        self.view.endEditing(true)
        GetSearchDataAccordingToLocation()
        
    }
    
    
    @IBAction func Action_Cancel(_ sender: Any) {
        
        self.view.endEditing(true)
        view_Black.isHidden = true
        view_PopUp.isHidden = true
        
    }
    
    
    
    @IBAction func Action_DidSelectRow(_ sender: UIButton) {
        
        if bool_Occupation == false {
            
            if self.checkInternetConnection()
            {
                bool_UserIdComingFromSearch = true
                print(arr_SearchData [sender.tag] as! NSDictionary)
                userIdFromSearch = (arr_SearchData[sender.tag] as! NSDictionary)["userId"] as? NSNumber
                let dict_Temp = (arr_SearchData[sender.tag] as! NSDictionary)["userDTO"] as? NSDictionary
                let str_role = dict_Temp?.value(forKey: "role") as? String
                dic_DataOfProfileForOtherUser = (arr_SearchData[sender.tag] as! NSDictionary).mutableCopy() as! NSMutableDictionary
                
                if str_role == "USER" {
                    
                    DispatchQueue.main.async {
                        
                        let vc = Global.macros.Storyboard.instantiateViewController(withIdentifier: "user") as! ProfileVC
                        _ = self.navigationController?.pushViewController(vc, animated: true)
                        vc.extendedLayoutIncludesOpaqueBars = true
                        self.automaticallyAdjustsScrollViewInsets = false
                        //self.navigationController?.navigationBar.isTranslucent = false
                    }
                    
                    //self.edgesForExtendedLayout = UIRectEdgeNone;
                    // self.edgesForExtendedLayout = UIRectEdge.top
                    
                    // self.tabBarController?.tabBar.isTranslucent = false
                    // self.navigationController?.navigationBar.isTranslucent = false
                    //arr_SearchData.removeAllObjects()
                    
                }
                else {
                    
                    let vc = Global.macros.Storyboard.instantiateViewController(withIdentifier: "company") as! ComapanySchoolViewController
                    _ = self.navigationController?.pushViewController(vc, animated: true)
                    vc.extendedLayoutIncludesOpaqueBars = true
                    self.automaticallyAdjustsScrollViewInsets = false
                    // self.tabBarController?.tabBar.isTranslucent = false
                    // self.navigationController?.navigationBar.isTranslucent = false
                    
                    //arr_SearchData.removeAllObjects()
                    
                }
            }
                
            else{
                self.showAlert(Message: Global.macros.kInternetConnection, vc: self)
            }
            
        }
        else {
           // self.showAlert(Message: "Coming Soon.", vc: self)
            let vc = Global.macros.Storyboard.instantiateViewController(withIdentifier: "OccupationDetail") as! OccupationDetailViewController
            vc.occupationId = (arr_SearchData[sender.tag] as! NSDictionary)["id"]! as? NSNumber
            _ = self.navigationController?.pushViewController(vc, animated: true)
           // vc.extendedLayoutIncludesOpaqueBars = true
           // self.tabBarController?.tabBar.isTranslucent = false
           // self.navigationController?.navigationBar.isTranslucent = false
            
        }
    }
    
    
    @IBAction func Action_OpenUrl(_ sender: UIButton) {
        
        let str_role = ((self.arr_SearchData[(sender.tag)] as! NSDictionary)["userDTO"] as? NSDictionary)?.value(forKey: "role") as? String
        let url:String?
        if str_role == "COMPANY"{
            url = ((self.arr_SearchData[(sender.tag)] as! NSDictionary)["userDTO"] as? NSDictionary)?.value(forKey: "companyUrl") as? String
        }else{
            url = ((self.arr_SearchData[(sender.tag)] as! NSDictionary)["userDTO"] as? NSDictionary)?.value(forKey: "schoolUrl") as? String
        }
        
        DispatchQueue.main.async {
            
            if url != nil && url != ""{
                if let checkURL = NSURL(string: url!) {
                    
                    if  UIApplication.shared.openURL(checkURL as URL){
                        print("URL Successfully Opened")
                    }
                    else {
                        self.showAlert(Message: "Invalid URL. Unable to open in browser.", vc: self)
                    }
                }
                else {
                    
                    self.showAlert(Message:"Invalid URL. Unable to open in browser.", vc: self)
                }
            }
            else {
                self.showAlert(Message: "Invalid URL. Unable to open in browser.", vc: self)
            }
        }
        
    }
    
    
    
    @IBAction func Action_OpenRatingView(_ sender: Any) {
        
        
    }
    
    
    @IBAction func Action_ViewProfileOccupation(_ sender: UIButton) {
        
        let vc = Global.macros.Storyboard.instantiateViewController(withIdentifier: "OccupationDetail") as! OccupationDetailViewController
        vc.occupationId = (arr_SearchData[sender.tag] as! NSDictionary)["id"]! as? NSNumber
        _ = self.navigationController?.pushViewController(vc, animated: true)
        vc.extendedLayoutIncludesOpaqueBars = true
        self.tabBarController?.tabBar.isTranslucent = false
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    
    //MARK:Scroll View Delegate Methods and Pagination
    
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        pointNow = scrollView.contentOffset
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        //Custom indexpath and cell formation
        let visibleRect = CGRect(origin: self.customCollectionView.contentOffset, size: self.customCollectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        let indexPath = self.customCollectionView.indexPathForItem(at: visiblePoint)
        if indexPath != nil {
            let cell = self.customCollectionView.cellForItem(at: indexPath!) as? CustomCollectionViewCell
            if cell != nil {
                
                if scrollView == self.tblview_AllSearchResult {       //Pagination for tableview
                    
                    print(scrollView.contentOffset.y)
                    if (scrollView.contentOffset.y<(pointNow?.y)!) {
                        print("down")
                    } else if (scrollView.contentOffset.y>(pointNow?.y)!) {
                        
                        if isFetching {
                            self.pageIndex = self.pageIndex + 1
                            isFetching = true
                            DispatchQueue.global(qos: .background).async {
                                
                                self.bool_Search = true
                                if bool_AllTypeOfSearches == true {
                                    self.getSearchData()
                                }
                                else if bool_LocationFilter == true {
                                    self.GetSearchDataAccordingToLocation()
                                }
                                    
                                else if bool_CompanySchoolTrends == true {
                                    self.GetOnlyCompanyData()
                                }
                            }
                        }
                    }
                    
                }
                else {
                    
                    // cell?.customScrollView.contentSize = CGSize.init(width: self.view.frame.width, height: self.view.frame.height + 250)
                    if (indexPath?.row)!  == self.arr_SearchData.count - 1 {   //Pagination for scrollView
                        
                        print(scrollView.contentOffset.x)
                        print(arr_SearchData.count)
                        
                        if pointNow != nil {
                            if (scrollView.contentOffset.x<(pointNow?.x)!) {
                                print("down")
                            } else if (scrollView.contentOffset.x>(pointNow?.x)!) {
                                if isFetching {
                                    self.pageIndex = self.pageIndex + 1
                                    isFetching = true
                                    DispatchQueue.global(qos: .background).async {
                                        self.bool_Search = true
                                        if bool_AllTypeOfSearches == true {
                                            self.getSearchData()
                                        }
                                        else if bool_LocationFilter == true {
                                            self.GetSearchDataAccordingToLocation()
                                        }
                                        else if bool_CompanySchoolTrends == true {
                                            self.GetOnlyCompanyData()
                                        }
                                    }
                                }
                            }
                                
                            else {
                                self.bool_Search = true
                                self.tblview_AllSearchResult.reloadData()
                                self.customCollectionView.reloadData()
                            }
                        }
                        else {
                            self.bool_Search = true
                            self.tblview_AllSearchResult.reloadData()
                            self.customCollectionView.reloadData()
                            
                        }
                        
                    }
                    else {        //Set data for UICollectionView when end declarating calls
                        DispatchQueue.main.async {
                          
                                
                            if bool_Occupation == false {

                             cell?.view_MainOccupation.isHidden = true
                            cell?.btn_ViewFullProfile.tag = (indexPath?.row)!
                            cell?.btn_PlayVideo.tag = (indexPath?.row)!
                            cell?.btn_SocialSite1.tag = (indexPath?.row)!
                            cell?.btn_SocialSite2.tag = (indexPath?.row)!
                            cell?.btn_SocialSite3.tag = (indexPath?.row)!
                            cell?.btn_OpenUrl.tag = (indexPath?.row)!
                            
                            if self.arr_SearchData.count > 0 {
                                self.dicUrl.removeAllObjects()
                                if (self.arr_SearchData[(indexPath?.row)!] as! NSDictionary)["name"] != nil || (self.arr_SearchData[(indexPath?.row)!] as! NSDictionary)["name"] as? String != "" {
                                   cell?.lbl_CompanySchoolUserName.text = (self.arr_SearchData[(indexPath?.row)!] as! NSDictionary)["name"] as? String
                                }
                                else {
                                    cell?.lbl_CompanySchoolUserName.text = "NA"
                                }
                                
                                let rating_number = "\((self.arr_SearchData[(indexPath?.row)!] as! NSDictionary)["avgRating"]!)"  //Set the star images acc. to rating
                                
                                let dbl = 2.0
                                
                                if  dbl.truncatingRemainder(dividingBy: 1) == 0
                                {
                                    cell?.lbl_RatingFloat.text = rating_number + ".0"
                                    
                                }
                                else {
                                    
                                    cell?.lbl_RatingFloat.text = rating_number
                                }
                                
                                
                                cell?.lbl_totalRatingCount.text = "\((self.arr_SearchData[(indexPath?.row)!] as! NSDictionary)["ratingCount"]!)"
                                
                                
                                
                                let dict_Temp = (self.arr_SearchData[(indexPath?.row)!] as! NSDictionary)["userDTO"] as? NSDictionary
                                let str_role = dict_Temp?.value(forKey: "role") as? String //Getting the role
                                
                                
                                let str_video =  dict_Temp?.value(forKey: "videoUrl") as? String  //Video url to play video
                                if str_video != nil {
                                    video_url = NSURL(string: str_video!) as URL?
                                }
                                else{
                                    video_url = nil
                                }
                                
                                
                                array_public_UserSocialSites.removeAll()
                                
                                //fetching urls
                                for v in self.array_ActualSocialSites
                                {
                                    let value = v["name_url"] as? String
                                    if  (dict_Temp?[value!] != nil && dict_Temp?.value(forKey: value!) as? String != "" )
                                    {
                                        
                                        var dic = v
                                        dic["url"] = (dict_Temp?.value(forKey: value!)!)
                                        array_public_UserSocialSites.append(dic)
                                        
                                    }
                                }
                                
                                print(array_public_UserSocialSites)
                                
                                
                                if str_role == "USER" {              //For users UI and data Checks
                                    
                                    cell?.lbl_Count_NumberOfUsers.isHidden = true
                                    cell?.lbl_Count_CompanySchoolWithOccupations.isHidden = true
                                    cell?.lbl_occupation.isHidden = true
                                    cell?.lbl_attend.isHidden = true
                                    cell?.view_line.isHidden = true
                                    cell?.kHeight_BehindDetailView.constant = 58
                                    cell?.imgView_Location.image = UIImage.init(named: "company-icon")
                                    cell?.imgView_Url.image = UIImage.init(named: "school-icon")


                                    
                                    if dict_Temp?.value(forKey: "companyName") != nil && dict_Temp?.value(forKey: "companyName") as? String != ""  && dict_Temp?.value(forKey: "companyName") as? String != " "{//company is not nil in user
                                        
                                        
                                        cell?.lbl_Location.text = dict_Temp?.value(forKey: "companyName") as? String
                                        cell?.imgView_Location.image = UIImage.init(named: "company-icon")
                                        
                                        cell?.lbl_Location.isHidden = false
                                        cell?.imgView_Location.isHidden = false
                                        
                                        if dict_Temp?.value(forKey: "schoolName") != nil &&  dict_Temp?.value(forKey: "schoolName") as? String != "" && dict_Temp?.value(forKey: "schoolName") as? String != " "{//school is not nil in user
                                            
                                            cell?.lbl_Url.text = dict_Temp?.value(forKey: "schoolName") as? String
                                            cell?.imgView_Url.image = UIImage.init(named: "school-icon")
                                            cell?.lbl_Url.isHidden = false
                                            cell?.imgView_Url.isHidden = false
                                            
                                            cell?.k_Constraint_Top_labelUrl.constant = 8.0
                                            cell?.k_Constraint_Top_btnUrl.constant = 8.0
                                            cell?.k_Constraint_Top_imageViewUrl.constant = 8.0
                                            
                                            
                                            if array_public_UserSocialSites.count > 0 {
                                                
                                                cell?.tbl_View_SocialSite.isHidden = false
                                                if array_public_UserSocialSites.count == 1 {//social site count 1
                                                    
                                                    cell?.k_Constraint_Height_TableviewSocialSite.constant = 50.0
                                                    cell?.k_Constraint_ViewDescriptionHeight.constant = 170.0
                                                    
                                                    
                                                }
                                                else  if array_public_UserSocialSites.count == 2{//social site count 2
                                                    
                                                    cell?.k_Constraint_Height_TableviewSocialSite.constant = 100.0
                                                    cell?.k_Constraint_ViewDescriptionHeight.constant = 210.0
                                                    
                                                }
                                                else{//social site count 3
                                                    
                                                    cell?.k_Constraint_Height_TableviewSocialSite.constant = 150.0
                                                    cell?.k_Constraint_ViewDescriptionHeight.constant = 250.0
                                                }
                                                cell?.tbl_View_SocialSite.reloadData()
                                                
                                            }else{
                                                
                                                cell?.tbl_View_SocialSite.isHidden = true
                                                cell?.k_Constraint_ViewDescriptionHeight.constant = 160.0
                                                
                                            }
                                        }
                                        else{//if school is nil in user
                                            
                                            
                                            cell?.lbl_Url.isHidden = true
                                            cell?.imgView_Url.isHidden = true
                                            
                                            if array_public_UserSocialSites.count > 0 {//social site nil
                                                
                                                cell?.tbl_View_SocialSite.isHidden = false
                                                cell?.k_Constraint_Top_tblViewSocialSite.constant = -25.0
                                                
                                                if array_public_UserSocialSites.count == 1 {//social site count 1
                                                    
                                                    cell?.k_Constraint_Height_TableviewSocialSite.constant = 50.0
                                                    cell?.k_Constraint_ViewDescriptionHeight.constant = 150.0
                                                    
                                                    
                                                }
                                                else  if array_public_UserSocialSites.count == 2{//social site count 2
                                                    
                                                    cell?.k_Constraint_Height_TableviewSocialSite.constant = 100.0
                                                    cell?.k_Constraint_ViewDescriptionHeight.constant = 180.0
                                                    
                                                }
                                                else{//social site count 3
                                                    
                                                    cell?.k_Constraint_Height_TableviewSocialSite.constant = 150.0
                                                    cell?.k_Constraint_ViewDescriptionHeight.constant = 210.0
                                                }
                                                cell?.tbl_View_SocialSite.reloadData()
                                                
                                            }
                                            else{//social site not nil
                                                
                                                cell?.tbl_View_SocialSite.isHidden = true
                                                cell?.k_Constraint_ViewDescriptionHeight.constant = 150.0
                                                
                                            }
                                        }
                                        
                                    }
                                    else {//if company is nil in case of user
                                        
                                        
                                        cell?.lbl_Location.isHidden = true
                                        cell?.imgView_Location.isHidden = true
                                        
                                        if dict_Temp?.value(forKey: "schoolName") != nil &&  dict_Temp?.value(forKey: "schoolName") as? String != "" {//school is not nil in user
                                            
                                            cell?.lbl_Url.isHidden = false
                                            cell?.imgView_Url.isHidden = false
                                            cell?.k_Constraint_Top_labelUrl.constant = -28.0
                                            cell?.k_Constraint_Top_btnUrl.constant = -28.0
                                            cell?.k_Constraint_Top_imageViewUrl.constant = -23.0
                                            
                                            cell?.lbl_Url.text = dict_Temp?.value(forKey: "schoolName") as? String
                                            if array_public_UserSocialSites.count > 0 {//social site not nil
                                                
                                                cell?.tbl_View_SocialSite.isHidden = false
                                                if array_public_UserSocialSites.count == 1 {//social site count 1
                                                    
                                                    cell?.k_Constraint_Height_TableviewSocialSite.constant = 50.0
                                                    cell?.k_Constraint_ViewDescriptionHeight.constant = 150.0
                                                    
                                                    
                                                }
                                                else  if array_public_UserSocialSites.count == 2{//social site count 2
                                                    
                                                    cell?.k_Constraint_Height_TableviewSocialSite.constant = 100.0
                                                    cell?.k_Constraint_ViewDescriptionHeight.constant = 180.0
                                                    
                                                }
                                                else{//social site count 3
                                                    
                                                    cell?.k_Constraint_Height_TableviewSocialSite.constant = 150.0
                                                    cell?.k_Constraint_ViewDescriptionHeight.constant = 210.0
                                                }
                                                cell?.tbl_View_SocialSite.reloadData()
                                                
                                            }else{//spcial site nil
                                                
                                                cell?.tbl_View_SocialSite.isHidden = true
                                                cell?.k_Constraint_ViewDescriptionHeight.constant = 120.0
                                                
                                            }
                                        }
                                        else{
                                            
                                            cell?.lbl_Url.isHidden = true
                                            cell?.imgView_Url.isHidden = true
                                            
                                            if array_public_UserSocialSites.count > 0 {//social sites not nil
                                                
                                                cell?.tbl_View_SocialSite.isHidden = false
                                                cell?.k_Constraint_Top_tblViewSocialSite.constant = -60.0
                                                
                                                
                                                if array_public_UserSocialSites.count == 1 {//social site count 1
                                                    
                                                    cell?.k_Constraint_Height_TableviewSocialSite.constant = 50.0
                                                    cell?.k_Constraint_ViewDescriptionHeight
                                                        
                                                        .constant = 120.0
                                                    
                                                    
                                                }
                                                else  if array_public_UserSocialSites.count == 2{//social site count 2
                                                    
                                                    cell?.k_Constraint_Height_TableviewSocialSite.constant = 100.0
                                                    cell?.k_Constraint_ViewDescriptionHeight.constant = 150.0
                                                    
                                                }
                                                else{//social site count 3
                                                    
                                                    cell?.k_Constraint_Height_TableviewSocialSite.constant = 150.0
                                                    cell?.k_Constraint_ViewDescriptionHeight.constant = 180.0
                                                }
                                                cell?.tbl_View_SocialSite.reloadData()
                                                
                                            }
                                            else{//everything nil
                                                
                                                cell?.tbl_View_SocialSite.isHidden = true
                                                cell?.k_Constraint_ViewDescriptionHeight.constant = 110.0
                                                
                                            }
                                        }
                                        
                                    }
                                }
                                else{   //For Company and school UI and data Checks
                                    
                                    cell?.lbl_Count_NumberOfUsers.isHidden = false
                                    cell?.lbl_Count_CompanySchoolWithOccupations.isHidden = false
                                    cell?.lbl_occupation.isHidden = false
                                    cell?.lbl_attend.isHidden = false
                                    cell?.view_line.isHidden = false
                                    
                                    
                                    cell?.kHeight_BehindDetailView.constant = 118
                                    
                                    if dict_Temp?.value(forKey: "schoolOrCompanyWithTheseUsers") != nil {
                                        cell?.lbl_Count_CompanySchoolWithOccupations.text = "\((dict_Temp?.value(forKey: "schoolOrCompanyWithTheseUsers") as! NSDictionary)["count"]!)"
                                    }
                                    else {
                                        cell?.lbl_Count_CompanySchoolWithOccupations.text = "0"
                                    }
                                    
                                    if dict_Temp?.value(forKey: "schoolOrCompanyWithTheseOccupations")  != nil {
                                        
                                        cell?.lbl_Count_NumberOfUsers.text = "\((dict_Temp?.value(forKey: "schoolOrCompanyWithTheseOccupations") as! NSDictionary)["count"]!)"
                                    }
                                        
                                    else {
                                        cell?.lbl_Count_NumberOfUsers.text = "0"
                                    }
                                    
                                    cell?.imgView_Location.image = UIImage.init(named: "location-pin")
                                    cell?.lbl_Location.isHidden = false
                                    cell?.imgView_Location.isHidden = false

                                    
                                    if dict_Temp?.value(forKey: "location") != nil && dict_Temp?.value(forKey: "location") as? String != "" {
                                        cell?.lbl_Location.text = dict_Temp?.value(forKey: "location") as? String
                                        
                                    }
                                    else {
                                        cell?.lbl_Location.text = "NA"
                                    }
                                    
                                    
                                    if str_role == "COMPANY"{                  //Set Company or school url to view
                                        
                                        if dict_Temp?.value(forKey: "companyUrl") as? String != nil && dict_Temp?.value(forKey: "companyUrl") as? String != " "{
                                            
                                            cell?.lbl_Url.text = dict_Temp?.value(forKey: "companyUrl") as? String
                                            cell?.imgView_Url.image = UIImage.init(named: "url_icon")
                                            cell?.btn_OpenUrl.isUserInteractionEnabled = true
                                            cell?.lbl_Url.isHidden = false
                                            cell?.imgView_Url.isHidden = false
                                            
                                            cell?.k_Constraint_Top_labelUrl.constant = 8.0
                                            cell?.k_Constraint_Top_btnUrl.constant = 8.0
                                            cell?.k_Constraint_Top_imageViewUrl.constant = 8.0
                                            
                                            if array_public_UserSocialSites.count > 0{//social sites not nil
                                                cell?.tbl_View_SocialSite.isHidden = false
                                                
                                                if array_public_UserSocialSites.count == 1 {//social site count 1
                                                    
                                                    cell?.k_Constraint_Height_TableviewSocialSite.constant = 50.0
                                                    cell?.k_Constraint_ViewDescriptionHeight.constant = 180.0
                                                    
                                                    
                                                }
                                                else  if array_public_UserSocialSites.count == 2{//social site count 2
                                                    
                                                    cell?.k_Constraint_Height_TableviewSocialSite.constant = 100.0
                                                    cell?.k_Constraint_ViewDescriptionHeight.constant = 210.0
                                                    
                                                }
                                                else{//social site count 3
                                                    
                                                    cell?.k_Constraint_Height_TableviewSocialSite.constant = 130.0
                                                    cell?.k_Constraint_ViewDescriptionHeight.constant = 240.0
                                                }
                                                
                                                
                                                cell?.tbl_View_SocialSite.reloadData()
                                            }
                                            else{
                                                
                                                cell?.tbl_View_SocialSite.isHidden = true
                                                cell?.k_Constraint_ViewDescriptionHeight.constant = 160.0
                                            }
                                        }
                                        else{//IF COMPANY URL IS NIL
                                            
                                            cell?.lbl_Url.isHidden = true
                                            cell?.imgView_Url.isHidden = true
                                            cell?.btn_OpenUrl.isUserInteractionEnabled = false
                                            
                                            if array_public_UserSocialSites.count > 0{//social sites not nil
                                                cell?.tbl_View_SocialSite.isHidden = false
                                                cell?.k_Constraint_Top_tblViewSocialSite.constant = -25.0
                                                
                                                if array_public_UserSocialSites.count == 1 {//social site count 1
                                                    
                                                    cell?.k_Constraint_Height_TableviewSocialSite.constant = 50.0
                                                    cell?.k_Constraint_ViewDescriptionHeight.constant = 175.0
                                                    
                                                    
                                                }
                                                else  if array_public_UserSocialSites.count == 2{//social site count 2
                                                    
                                                    cell?.k_Constraint_Height_TableviewSocialSite.constant = 100.0
                                                    cell?.k_Constraint_ViewDescriptionHeight.constant = 200.0
                                                    
                                                }
                                                else{//social site count 3
                                                    
                                                    cell?.k_Constraint_Height_TableviewSocialSite.constant = 130.0
                                                    cell?.k_Constraint_ViewDescriptionHeight.constant = 240.0
                                                }
                                                
                                                
                                                cell?.tbl_View_SocialSite.reloadData()
                                            }
                                            else{//IF SOCIAL SITES ARE NIL IN CASE OF COMPANY
                                                
                                                cell?.tbl_View_SocialSite.isHidden = true
                                                cell?.k_Constraint_ViewDescriptionHeight.constant = 125.0
                                            }
                                            
                                            
                                        }
                                        
                                    }else{
                                        
                                        if dict_Temp?.value(forKey: "schoolUrl") as? String != nil && dict_Temp?.value(forKey: "schoolUrl") as? String != " "{
                                            
                                            cell?.lbl_Url.text = dict_Temp?.value(forKey: "schoolUrl") as? String
                                            cell?.btn_OpenUrl.isUserInteractionEnabled = true
                                            
                                            cell?.lbl_Url.isHidden = false
                                            cell?.imgView_Url.isHidden = false
                                            
                                            cell?.k_Constraint_Top_labelUrl.constant = 8.0
                                            cell?.k_Constraint_Top_btnUrl.constant = 8.0
                                            cell?.k_Constraint_Top_imageViewUrl.constant = 8.0
                                            
                                            
                                            if array_public_UserSocialSites.count > 0{//social sites not nil
                                                cell?.tbl_View_SocialSite.isHidden = false
                                                
                                                if array_public_UserSocialSites.count == 1 {//social site count 1
                                                    
                                                    cell?.k_Constraint_Height_TableviewSocialSite.constant = 50.0
                                                    cell?.k_Constraint_ViewDescriptionHeight.constant = 215.0
                                                    
                                                    
                                                }
                                                else  if array_public_UserSocialSites.count == 2{//social site count 2
                                                    
                                                    cell?.k_Constraint_Height_TableviewSocialSite.constant = 100.0
                                                    cell?.k_Constraint_ViewDescriptionHeight.constant = 240.0
                                                    
                                                }
                                                else{//social site count 3
                                                    
                                                    cell?.k_Constraint_Height_TableviewSocialSite.constant = 130.0
                                                    cell?.k_Constraint_ViewDescriptionHeight.constant = 290.0
                                                }
                                                
                                                
                                                cell?.tbl_View_SocialSite.reloadData()
                                            }
                                            else{
                                                
                                                cell?.tbl_View_SocialSite.isHidden = true
                                                cell?.k_Constraint_ViewDescriptionHeight.constant = 160.0
                                            }
                                            
                                            
                                        }
                                        else{
                                            
                                            
                                            cell?.lbl_Url.isHidden = true
                                            cell?.imgView_Url.isHidden = true
                                            cell?.btn_OpenUrl.isUserInteractionEnabled = false
                                            
                                            if array_public_UserSocialSites.count > 0{//social sites not nil
                                                cell?.tbl_View_SocialSite.isHidden = false
                                                cell?.k_Constraint_Top_tblViewSocialSite.constant = -25.0
                                                
                                                if array_public_UserSocialSites.count == 1 {//social site count 1
                                                    
                                                    cell?.k_Constraint_Height_TableviewSocialSite.constant = 50.0
                                                    cell?.k_Constraint_ViewDescriptionHeight.constant = 175.0
                                                    
                                                    
                                                }
                                                else  if array_public_UserSocialSites.count == 2{//social site count 2
                                                    
                                                    cell?.k_Constraint_Height_TableviewSocialSite.constant = 100.0
                                                    cell?.k_Constraint_ViewDescriptionHeight.constant = 200.0
                                                    
                                                }
                                                else{//social site count 3
                                                    
                                                    cell?.k_Constraint_Height_TableviewSocialSite.constant = 130.0
                                                    cell?.k_Constraint_ViewDescriptionHeight.constant = 240.0
                                                }
                                                
                                                
                                                cell?.tbl_View_SocialSite.reloadData()
                                            }
                                            else{//IF SOCIAL SITES ARE NIL IN CASE OF school
                                                
                                                cell?.tbl_View_SocialSite.isHidden = true
                                                cell?.k_Constraint_ViewDescriptionHeight.constant = 125.0
                                            }
                                            
                                            
                                        }
                                        
                                            
                                        }
                                        
                                    }
                                    
                                
                                
                                if dict_Temp?.value(forKey: "shadowedByShadowUser") != nil {   //Mutual data set on user, school and company
                                    cell?.lbl_Count_ShadowersVerified.text = "\((dict_Temp?.value(forKey: "shadowedByShadowUser") as! NSDictionary)["count"]!)"
                                }
                                    
                                else {
                                    cell?.lbl_Count_ShadowersVerified.text = "0"
                                }
                                
                                if dict_Temp?.value(forKey: "shadowersVerified")  != nil {
                                    cell?.lbl_Count_ShadowedByShadowUser.text = "\((dict_Temp?.value(forKey: "shadowersVerified") as! NSDictionary)["count"]!)"
                                }
                                else {
                                    
                                    cell?.lbl_Count_ShadowedByShadowUser.text = "0"
                                }
                                
                                
                                let str_bio = dict_Temp?.value(forKey: "bio") as? String
                                
                                if str_bio == "" || str_bio == nil {
                                    cell?.lbl_Description.text = "No biography to show..."
                                }
                                else {
                                    cell?.lbl_Description.text = str_bio
                                }
                                
                                
                                
                                if (dict_Temp?.value(forKey: "profileImageUrl")as? String) != nil {      // Set Profile ImageUrl
                                    var profileurl = dict_Temp?.value(forKey: "profileImageUrl") as? String
                                    profileurl = profileurl?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                                    
                                    if profileurl != nil {
                                        cell?.imgView_ProfilePic.sd_setImage(with: URL(string:profileurl!), placeholderImage: UIImage(named: "profile-icon-1"))//image
                                    }
                                }else{
                                    cell?.imgView_ProfilePic.image = UIImage.init(named: "dummy")
                                }
                                self.bool_LastResultSearch = false
                            }
                          
                        } //a
                            
                            else {
                                DispatchQueue.main.async {
                                    
                                    cell?.view_MainOccupation.isHidden = false
                                    cell?.setChart()
                                    
                                    if self.arr_SearchData.count > 0 {
                                        
                                        self.dicUrl.removeAllObjects()
                                        
                                        if (self.arr_SearchData[(indexPath?.row)!] as! NSDictionary)["name"] != nil || (self.arr_SearchData[(indexPath?.row)!] as! NSDictionary)["name"] as? String != "" {
                                            cell?.lbl_CompanySchoolUserName.text = (self.arr_SearchData[(indexPath?.row)!] as! NSDictionary)["name"] as? String
                                            cell?.lbl_Abt.text = "About" + " " + "\((self.arr_SearchData[(indexPath?.row)!] as! NSDictionary)["name"]!)"
                                            
                                        }
                                        else {
                                            
                                            cell?.lbl_CompanySchoolUserName.text = "NA"
                                            cell?.lbl_Abt.text = "About"
                                        }
                                        
                                        let rating_number = "\((self.arr_SearchData[(indexPath?.row)!] as! NSDictionary)["avgRating"]!)"
                                        
                                        let dbl = 2.0
                                        
                                        if  dbl.truncatingRemainder(dividingBy: 1) == 0
                                        {
                                            cell?.lbl_Rating.text = rating_number + ".0"
                                            
                                        }
                                        else {
                                            cell?.lbl_Rating.text = rating_number
                                        }
                                        
                                        if (self.arr_SearchData[(indexPath?.row)!] as! NSDictionary)["occupationDTO"] as? NSDictionary != nil {
                                            
                                            
                                             let dict_Temp = (self.arr_SearchData[(indexPath?.row)!] as! NSDictionary)["occupationDTO"] as! NSDictionary
                                            
                                            let str_bio = dict_Temp.value(forKey: "description") as? String
                                            
                                            if str_bio == "" || str_bio == nil {
                                                cell?.txtView_Description.text = "No biography to show..."
                                            }
                                            else {
                                                cell?.txtView_Description.text = str_bio
                                            }

                                            let morePrecisePI = Double((dict_Temp.value(forKey: "salary") as? String)!)
                                            
                                            let myInteger = Int(morePrecisePI!)
                                            let myNumber = NSNumber(value:myInteger)
                                            print(myNumber)
                                            cell?.lbl_avgSalary.text = self.suffixNumber(number: myNumber) as String

                                            
                                        }
                                        
                                        cell?.lbl_RatingCount.text = "\((self.arr_SearchData[(indexPath?.row)!] as! NSDictionary)["ratingCount"]!)"
                                        
                                        cell?.lbl_Growth.text = "15%"
                                        
                                        cell?.lbl_UserWithOccupation.text = "0"
                                        cell?.lbl_UserShadowed.text = "0"
                                        
                                        
                                        
                                       
                                    }
                                    
                                }
                            } //
                        }
                        
                        
                    }
                }
            }
        }
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        
        let visibleRect = CGRect(origin: self.customCollectionView.contentOffset, size: self.customCollectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        let indexPath = self.customCollectionView.indexPathForItem(at: visiblePoint)
        if indexPath != nil {
            let cell = self.customCollectionView.cellForItem(at: indexPath!) as? CustomCollectionViewCell
            
          if bool_Occupation == false {
                cell?.customScrollView.contentSize = CGSize.init(width: self.view.frame.size.width, height:  950)
            cell?.customScrollView.isScrollEnabled = true

            }
            
            else{
                
                cell?.customScrollView.contentSize = CGSize.init(width: self.view.frame.size.width, height:  750)
            
                cell?.customScrollView.isScrollEnabled = false
            }
            
            if scrollView == self.customCollectionView {
                
                if scrollView == cell?.customScrollView {
                    
                    if cell != nil {
                        
                        cell?.customScrollView.contentSize = CGSize.init(width: self.view.frame.size.width, height:  950)
                        cell?.customScrollView.contentOffset = CGPoint.zero
                        cell?.customScrollView.contentInset = UIEdgeInsets.zero
                        cell?.customScrollView.isScrollEnabled = true

                    }
                }
                    
                else {
                    
                    DispatchQueue.main.async {
                        
                        let visibleRect = CGRect(origin: self.customCollectionView.contentOffset, size: self.customCollectionView.bounds.size)
                        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
                        let indexPath = self.customCollectionView.indexPathForItem(at: visiblePoint)
                        
                        if indexPath != nil {
                            let cell  = self.customCollectionView.cellForItem(at: indexPath!) as? CustomCollectionViewCell
                            
                            //setting all fields empty or to dummy state
//                            cell?.imgView_Star1.image = UIImage(named: "graystar")
//                            cell?.imgView_Star2.image = UIImage(named: "graystar")
//                            cell?.imgView_Star3.image = UIImage(named: "graystar")
//                            cell?.imgView_Star4.image = UIImage(named: "graystar")
//                            cell?.imgView_Star5.image = UIImage(named: "graystar")
                            
                            cell?.imgView_ProfilePic.image = UIImage.init(named: "dummy")
                            cell?.btn_SocialSite1.isHidden = true
                            cell?.btn_SocialSite2.isHidden = true
                            cell?.btn_SocialSite3.isHidden = true
                            
                            cell?.lbl_CompanySchoolUserName.text = ""
                            cell?.lbl_Location.text = ""
                            cell?.lbl_Url.text = ""
                            cell?.lbl_Count_ShadowersVerified.text = "0"
                            cell?.lbl_Count_ShadowedByShadowUser.text = "0"
                            cell?.lbl_Count_CompanySchoolWithOccupations.text = "0"
                            cell?.lbl_Count_NumberOfUsers.text = "0"
                            cell?.lbl_Description.text = "No biography to show.."
                            
                        }
                        
                    }
                    
                }
            }
            
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

//MARK: SEARCHBAR METHODS

extension CustomSearchViewController:UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        self.searchBar.showsCancelButton = false
        
        if text == "\n" {
            self.searchBar.resignFirstResponder()
            return false
            
        }
        
        str_searchText = (searchBar.text! as NSString).replacingCharacters(in: range, with: text) as NSString
        //print(str_searchText!)
        
        
        if ((self.str_searchText?.length)! > 2 ) {
            if (self.str_searchText?.hasPrefix(" "))! {
                return false
            }
            
            if bool_AllTypeOfSearches == true {
                if bool_LastResultSearch == false {
                    
                    self.arr_SearchData.removeAllObjects()
                    pageIndex = 0
                    DispatchQueue.main.async {
                        self.bool_Search = true
                        self.getSearchData()
                    }
                }
            }
                
            else if bool_LocationFilter == true {
                
                if bool_LastResultSearch == false {
                    self.arr_SearchData.removeAllObjects()
                    pageIndex = 0
                    DispatchQueue.main.async {
                        self.bool_Search = true
                        self.GetSearchDataAccordingToLocation()
                    }
                }
            }
                
            else if bool_CompanySchoolTrends == true{
                
                if bool_LastResultSearch == false {
                    self.arr_SearchData.removeAllObjects()
                    pageIndex = 0
                    DispatchQueue.main.async {
                        self.bool_Search = true
                        self.GetOnlyCompanyData()
                    }
                }
            }
            
            
            return self.str_searchText!.length <= 30
        }
        else  if ((self.str_searchText?.length)! == 0 ) {
            
            
            if bool_AllTypeOfSearches == true {
                pageIndex = 0
                DispatchQueue.main.async {
                    self.arr_SearchData.removeAllObjects()

                    self.bool_Search = true
                    self.getSearchData()
                }
            }
                
            else  if bool_LocationFilter == true {
                pageIndex = 0
                DispatchQueue.main.async {
                    self.arr_SearchData.removeAllObjects()

                    self.bool_Search = true
                    self.GetSearchDataAccordingToLocation()
                }
            }
                
            else if bool_CompanySchoolTrends == true{
                pageIndex = 0
                DispatchQueue.main.async {
                    self.arr_SearchData.removeAllObjects()

                    self.bool_Search = true
                    self.GetOnlyCompanyData()
                }
            }
                
            else {
                
                DispatchQueue.main.async {
                    self.arr_SearchData.removeAllObjects()

                    self.tblview_AllSearchResult.reloadData()
                    self.customCollectionView.reloadData()
                    
                    
                }
                
                
                
            }
            
            
        }
        else{
            DispatchQueue.main.async {
                self.arr_SearchData.removeAllObjects()

                self.tblview_AllSearchResult.reloadData()
                self.customCollectionView.reloadData()
                
                
            }
            
        }
        return self.str_searchText!.length <= 30
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
    }
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        self.searchBar.alpha = 1
        self.searchBar.showsCancelButton = false
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        
        
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
    }
    
}

//MARK: - CLASS EXTENSIONS
extension CustomSearchViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var count:Int?
        //Custom indexpath and cell formation
        let visibleRect = CGRect(origin: self.customCollectionView.contentOffset, size: self.customCollectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        let indexPath = self.customCollectionView.indexPathForItem(at: visiblePoint)
        
        if indexPath != nil {
            let cell = self.customCollectionView.cellForItem(at: indexPath!) as? CustomCollectionViewCell
            if tableView == cell?.tbl_View_SocialSite{
                
                count = array_public_UserSocialSites.count
                
            }else{
                
                count = array_public_UserSocialSites.count
            }
            
        }
        
        if tableView == tblview_AllSearchResult {
            count = arr_SearchData.count
        }
        
        return count!
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        var main_cell = UITableViewCell()
        
        if tableView == tblview_AllSearchResult {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell_Simple", for: indexPath) as! AllSearchesTableViewCell
            
            cell.btn_DidSelectRow.tag = indexPath.row
            
            
            let dict_Temp = (self.arr_SearchData[(indexPath.row)] as! NSDictionary)["userDTO"] as? NSDictionary
            let str_role = dict_Temp?.value(forKey: "role") as? String
            
            
            if str_role == "USER" {
                
                
                if dict_Temp?.value(forKey: "companyName") != nil {
                    
                    if bool_Occupation == false {
                    
                    let companyName =  dict_Temp?.value(forKey: "companyName") as! String
                    
                    if companyName != ""    {
                        cell.lbl_LocNcom.text = companyName.capitalizingFirstLetter()
                        cell.img_LocNcom.image = UIImage.init(named: "company-icon")
                    }
                    else {
                        cell.lbl_LocNcom.text  = ""
                    }
                    
                }
                    else {
                        cell.lbl_LocNcom.isHidden = true
                        cell.img_LocNcom.isHidden = true
                        
                    }
                }
                else {
                    
                    
                    if dict_Temp?.value(forKey: "schoolName") != nil {
                         if bool_Occupation == false {
                        
                        let schoolName = dict_Temp?.value(forKey: "schoolName") as! String
                        
                        if schoolName != ""
                        {
                            cell.lbl_LocNcom.text = schoolName.capitalizingFirstLetter()
                            cell.img_LocNcom.image = UIImage.init(named: "company-icon")
                            
                        }
                        else {
                            cell.lbl_LocNcom.text = ""
                        }
                       
                    }
                        
                        
                         else {
                            cell.lbl_LocNcom.isHidden = true
                            cell.img_LocNcom.isHidden = true
                            
                        }
                    }
                        
                    else {
                        
                        cell.lbl_LocNcom.text = ""
                        
                        
                    }
                    
                }
                
            }
                
            else {
                
                if bool_Occupation == false {
                
                if dict_Temp?.value(forKey: "location") != nil && dict_Temp?.value(forKey: "location") as? String != "" {
                    cell.lbl_LocNcom.text = dict_Temp?.value(forKey: "location") as? String
                    cell.img_LocNcom.image = UIImage.init(named: "location-pin")
                }
                else {
                    
                    cell.lbl_LocNcom.text = ""
                    cell.img_LocNcom.image = UIImage.init(named: "")
                    
                }
            }
                else {
                    cell.lbl_LocNcom.isHidden = true
                    cell.img_LocNcom.isHidden = true
                    
                }
            
            }
            
            
            if bool_LocationFilter == true {
                
                cell.lbl_Time.isHidden = false
                
                if self.arr_SearchData.count > 0 {
                    let str_distance = (arr_SearchData[indexPath.row] as! NSDictionary)["distance"] as? NSString
                    
                    if str_distance == "" || str_distance == nil {
                        cell.lbl_Time.text = "0m"
                    }
                    else {
                        cell.lbl_Time.text = String(format: "%.0f", str_distance!.floatValue) + " " + "MILES"
                    }
                    
                }
            }
                
            else {
                
                cell.lbl_Time.isHidden = true
                
            }
            
            
            if self.arr_SearchData.count > 0 {
                
                cell.lbl_Name.text = ((arr_SearchData[indexPath.row] as! NSDictionary)["name"] as? String)?.capitalizingFirstLetter()
                let rating_number = "\((arr_SearchData[indexPath.row] as! NSDictionary)["avgRating"]!)"
                
                //print(rating_number)
                
                let dbl = 2.0
                if  dbl.truncatingRemainder(dividingBy: 1) == 0
                {
                    cell.lbl_RatingFloat.text = rating_number + ".0"
                    
                }
                else {
                    cell.lbl_RatingFloat.text = rating_number
                }
                
                cell.lbl_totalRatingCount.text = "\((arr_SearchData[indexPath.row] as! NSDictionary)["ratingCount"]!)"
                
                
                let dict_Temp : NSDictionary?
                
                if  bool_Occupation == true {
                    
                    dict_Temp = (arr_SearchData[indexPath.row] as! NSDictionary)["occupationDTO"] as? NSDictionary
                    
                    if dict_Temp?.value(forKey: "profileImageUrl")as? String != nil{
                        var profileurl = dict_Temp?.value(forKey: "profileImageUrl")as? String
                        profileurl = profileurl?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                        
                        if profileurl != nil {
                            
                            cell.imgView_Profile.sd_setImage(with: URL(string:profileurl!), placeholderImage: UIImage(named: "occupation_filter"))//image
                        }
                    }else{
                        cell.imgView_Profile.image = UIImage.init(named: "occupation_filter")
                    }
                    
                }
                else {
                    dict_Temp = (arr_SearchData[indexPath.row] as! NSDictionary)["userDTO"] as? NSDictionary
                    
                    if dict_Temp?.value(forKey: "profileImageUrl")as? String != nil{
                        var profileurl = dict_Temp?.value(forKey: "profileImageUrl")as? String
                        profileurl = profileurl?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                        
                        if profileurl != nil {
                            
                            cell.imgView_Profile.sd_setImage(with: URL(string:profileurl!), placeholderImage: UIImage(named: "profile-icon-1"))//image
                        }
                    }else{
                        cell.imgView_Profile.image = UIImage.init(named: "profile-icon-1")
                    }
                    
                }
                
               
                bool_LastResultSearch = false
            }
            
            main_cell = cell
            
            
        }
        else {//for social site table view
            
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
            
            main_cell = cell
            
        }
        
        return main_cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if tableView != tblview_AllSearchResult {
            
            let site_url = (array_public_UserSocialSites[indexPath.row] as NSDictionary).value(forKey: "url") as? String
            print(site_url!)
            DispatchQueue.main.async {
                
                
                if let checkURL = NSURL(string: site_url!) {
                    
                    if  UIApplication.shared.openURL(checkURL as URL){
                        print("URL Successfully Opened")
                    }
                    else {
                        self.showAlert(Message: "Invalid URL", vc: self)
                        print("Invalid URL")
                    }
                } else {
                    self.showAlert(Message: "Invalid URL", vc: self)
                    print("Invalid URL")
                }
            }
        }
    }
    
}

//MARK : - COLLECTIONVIEW StarFull
extension CustomSearchViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath)as! CustomCollectionViewCell
        
        let desiredOffset = CGPoint(x: 0, y: -CGFloat((cell.customScrollView.contentInset.top )))
        cell.customScrollView.setContentOffset(desiredOffset, animated: true)
        
     
        DispatchQueue.main.async {
            if self.bool_Search == true {
                
                if bool_Occupation == false {
                cell.view_MainOccupation.isHidden = true
                self.bool_Search = false
                cell.btn_ViewFullProfile.tag = indexPath.row
                cell.btn_PlayVideo.tag = indexPath.row
                cell.btn_SocialSite1.tag = indexPath.row
                cell.btn_SocialSite2.tag = indexPath.row
                cell.btn_SocialSite3.tag = indexPath.row
                
                print(indexPath.row)
                print("indexPath \(indexPath.row)")
                if self.arr_SearchData.count > 0 {
                    
                    self.dicUrl.removeAllObjects()
                    
                    if (self.arr_SearchData[indexPath.row] as! NSDictionary)["name"] != nil || (self.arr_SearchData[indexPath.row] as! NSDictionary)["name"] as? String != "" {
                        cell.lbl_CompanySchoolUserName.text = (self.arr_SearchData[indexPath.row] as! NSDictionary)["name"] as? String
                        
                    }
                    else {
                        
                       cell.lbl_CompanySchoolUserName.text = "NA"
                        
                    }
                    let rating_number = "\((self.arr_SearchData[indexPath.row] as! NSDictionary)["avgRating"]!)"
                    
                    let dbl = 2.0
                    
                    if  dbl.truncatingRemainder(dividingBy: 1) == 0
                    {
                        cell.lbl_RatingFloat.text = rating_number + ".0"
                        
                    }
                    else {
                        cell.lbl_RatingFloat.text = rating_number
                    }
                    
                    
                    cell.lbl_totalRatingCount.text = "\((self.arr_SearchData[(indexPath.row)] as! NSDictionary)["ratingCount"]!)"
                    
                    
                    
                    let dict_Temp = (self.arr_SearchData[(indexPath.row)] as! NSDictionary)["userDTO"] as? NSDictionary
                    let str_role = dict_Temp?.value(forKey: "role") as? String
                    
                    
                    let str_video =  dict_Temp?.value(forKey: "videoUrl") as? String
                    if str_video != nil {
                        video_url = NSURL(string: str_video!) as URL?
                    }
                    else {
                        video_url = nil
                    }
                    
                    array_public_UserSocialSites.removeAll()
                    
                    //fetching urls
                    for v in self.array_ActualSocialSites
                    {
                        let value = v["name_url"] as? String
                        if  (dict_Temp?[value!] != nil && dict_Temp?.value(forKey: value!) as? String != "" )
                        {
                            
                            var dic = v
                            dic["url"] = (dict_Temp?.value(forKey: value!)!)
                            array_public_UserSocialSites.append(dic)
                            
                        }
                    }
                    
                    print(array_public_UserSocialSites)
                    
                    if str_role == "USER" {
                        
                        
                        cell.lbl_Count_NumberOfUsers.isHidden = true
                        cell.lbl_Count_NumberOfUsers.isHidden = true
                        cell.lbl_occupation.isHidden = true
                        cell.lbl_attend.isHidden = true
                        cell.view_line.isHidden = true
                        
                        cell.kHeight_BehindDetailView.constant = 58
                        
                        if dict_Temp?.value(forKey: "companyName") != nil && dict_Temp?.value(forKey: "companyName") as? String != ""{//company not nil
                            
                            cell.lbl_Location.text = dict_Temp?.value(forKey: "companyName") as? String
                            cell.imgView_Location.image = UIImage.init(named: "company-icon")
                            
                            cell.lbl_Location.isHidden = false
                            cell.imgView_Location.isHidden = false
                            
                            if dict_Temp?.value(forKey: "schoolName") != nil &&  dict_Temp?.value(forKey: "schoolName") as? String != ""{
                                
                                cell.lbl_Url.text = dict_Temp?.value(forKey: "schoolName") as? String
                                
                                cell.imgView_Url.image = UIImage.init(named: "school-icon")
                                cell.btn_OpenUrl.isUserInteractionEnabled = false
                                cell.lbl_Url.isHidden = false
                                cell.imgView_Url.isHidden = false
                                
                                cell.k_Constraint_Top_labelUrl.constant = 8.0
                                cell.k_Constraint_Top_btnUrl.constant = 8.0
                                cell.k_Constraint_Top_imageViewUrl.constant = 8.0
                                
                                
                                
                                
                                if array_public_UserSocialSites.count > 0 {
                                    
                                    cell.tbl_View_SocialSite.isHidden = false
                                    if array_public_UserSocialSites.count == 1 {//social site count 1
                                        
                                        cell.k_Constraint_Height_TableviewSocialSite.constant = 50.0
                                        cell.k_Constraint_ViewDescriptionHeight.constant = 170.0
                                        
                                        
                                    }
                                    else  if array_public_UserSocialSites.count == 2{//social site count 2
                                        
                                        cell.k_Constraint_Height_TableviewSocialSite.constant = 100.0
                                        cell.k_Constraint_ViewDescriptionHeight.constant = 210.0
                                        
                                    }
                                    else{//social site count 3
                                        
                                        cell.k_Constraint_Height_TableviewSocialSite.constant = 150.0
                                        cell.k_Constraint_ViewDescriptionHeight.constant = 250.0
                                    }
                                    cell.tbl_View_SocialSite.reloadData()
                                    
                                }else{
                                    
                                    cell.tbl_View_SocialSite.isHidden = true
                                    cell.k_Constraint_ViewDescriptionHeight.constant = 160.0
                                    
                                }
                            }
                            else{
                                
                                
                                cell.lbl_Url.isHidden = true
                                cell.imgView_Url.isHidden = true
                                
                                if array_public_UserSocialSites.count > 0 {//social site nil
                                    
                                    cell.tbl_View_SocialSite.isHidden = false
                                    cell.k_Constraint_Top_tblViewSocialSite.constant = -25.0
                                    
                                    if array_public_UserSocialSites.count == 1 {//social site count 1
                                        
                                        cell.k_Constraint_Height_TableviewSocialSite.constant = 50.0
                                        cell.k_Constraint_ViewDescriptionHeight.constant = 150.0
                                        
                                        
                                    }
                                    else  if array_public_UserSocialSites.count == 2{//social site count 2
                                        
                                        cell.k_Constraint_Height_TableviewSocialSite.constant = 100.0
                                        cell.k_Constraint_ViewDescriptionHeight.constant = 180.0
                                        
                                    }
                                    else{//social site count 3
                                        
                                        cell.k_Constraint_Height_TableviewSocialSite.constant = 150.0
                                        cell.k_Constraint_ViewDescriptionHeight.constant = 210.0
                                    }
                                    cell.tbl_View_SocialSite.reloadData()
                                    
                                }
                                else{//social site not nil
                                    
                                    cell.tbl_View_SocialSite.isHidden = true
                                    cell.k_Constraint_ViewDescriptionHeight.constant = 150.0
                                    
                                }
                            }
                            
                            
                        }
                        else {//company is nil
                            
                            cell.lbl_Location.isHidden = true
                            cell.imgView_Location.isHidden = true
                            
                            if dict_Temp?.value(forKey: "schoolName") != nil &&  dict_Temp?.value(forKey: "schoolName") as? String != ""{
                                
                                cell.lbl_Url.isHidden = false
                                cell.imgView_Url.isHidden = false
//                                cell.k_Constraint_Top_labelUrl.constant = -28.0
//                                cell.k_Constraint_Top_btnUrl.constant = -28.0
//                                cell.k_Constraint_Top_imageViewUrl.constant = -23.0
                                
                                if array_public_UserSocialSites.count > 0 {//social site not nil
                                    
                                    cell.tbl_View_SocialSite.isHidden = false
                                    if array_public_UserSocialSites.count == 1 {//social site count 1
                                        
                                        cell.k_Constraint_Height_TableviewSocialSite.constant = 50.0
                                        cell.k_Constraint_ViewDescriptionHeight.constant = 150.0
                                        
                                        
                                    }
                                    else  if array_public_UserSocialSites.count == 2{//social site count 2
                                        
                                        cell.k_Constraint_Height_TableviewSocialSite.constant = 100.0
                                        cell.k_Constraint_ViewDescriptionHeight.constant = 180.0
                                        
                                    }
                                    else{//social site count 3
                                        
                                        cell.k_Constraint_Height_TableviewSocialSite.constant = 150.0
                                        cell.k_Constraint_ViewDescriptionHeight.constant = 210.0
                                    }
                                    cell.tbl_View_SocialSite.reloadData()
                                    
                                }else{//spcial site nil
                                    
                                    cell.tbl_View_SocialSite.isHidden = true
                                    cell.k_Constraint_ViewDescriptionHeight.constant = 120.0
                                    
                                }
                            }
                            else{
                                
                                cell.lbl_Url.isHidden = true
                                cell.imgView_Url.isHidden = true
                                
                                if array_public_UserSocialSites.count > 0 {//social sites not nil
                                    
                                    cell.tbl_View_SocialSite.isHidden = false
                                    cell.k_Constraint_Top_tblViewSocialSite.constant = -60.0
                                    
                                    
                                    if array_public_UserSocialSites.count == 1 {//social site count 1
                                        
                                        cell.k_Constraint_Height_TableviewSocialSite.constant = 50.0
                                        cell.k_Constraint_ViewDescriptionHeight
                                            
                                            .constant = 120.0
                                        
                                        
                                    }
                                    else  if array_public_UserSocialSites.count == 2{//social site count 2
                                        
                                        cell.k_Constraint_Height_TableviewSocialSite.constant = 100.0
                                        cell.k_Constraint_ViewDescriptionHeight.constant = 150.0
                                        
                                    }
                                    else{//social site count 3
                                        
                                        cell.k_Constraint_Height_TableviewSocialSite.constant = 150.0
                                        cell.k_Constraint_ViewDescriptionHeight.constant = 180.0
                                    }
                                    cell.tbl_View_SocialSite.reloadData()
                                    
                                }
                                else{//everything nil
                                    
                                    cell.tbl_View_SocialSite.isHidden = true
                                    cell.k_Constraint_ViewDescriptionHeight.constant = 110.0
                                    
                                }
                            }
                        }
                        
                    }
                    else{
                        
                        cell.lbl_Count_NumberOfUsers.isHidden = false
                        cell.lbl_Count_NumberOfUsers.isHidden = false
                        cell.lbl_occupation.isHidden = false
                        cell.lbl_attend.isHidden = false
                        cell.view_line.isHidden = false
                        
                        cell.kHeight_BehindDetailView.constant = 118
                        cell.imgView_Location.image = UIImage.init(named: "location-pin")
                        cell.imgView_Url.image = UIImage.init(named: "url_icon")
                        
                        cell.lbl_Location.isHidden = false
                        cell.imgView_Location.isHidden = false

                        
                        if dict_Temp?.value(forKey: "schoolOrCompanyWithTheseUsers") != nil {
                            cell.lbl_Count_CompanySchoolWithOccupations.text = "\((dict_Temp?.value(forKey: "schoolOrCompanyWithTheseUsers") as! NSDictionary)["count"]!)"
                        }
                        else {
                            cell.lbl_Count_CompanySchoolWithOccupations.text = "0"
                            
                        }
                        
                        if dict_Temp?.value(forKey: "schoolOrCompanyWithTheseOccupations")  != nil {
                            
                            cell.lbl_Count_NumberOfUsers.text = "\((dict_Temp?.value(forKey: "schoolOrCompanyWithTheseOccupations") as! NSDictionary)["count"]!)"
                        }
                            
                            
                        else {
                            cell.lbl_Count_NumberOfUsers.text = "0"
                        }
                        
                        
                        if dict_Temp?.value(forKey: "location") != nil && dict_Temp?.value(forKey: "location") as? String != "" {
                            cell.lbl_Location.text = dict_Temp?.value(forKey: "location") as? String
                        }
                        else {
                            cell.lbl_Location.text = "NA"
                        }
                        
                        if str_role == "COMPANY"{
                            
                            if dict_Temp?.value(forKey: "companyUrl") as? String != nil {
                                cell.lbl_Url.text = dict_Temp?.value(forKey: "companyUrl") as? String
                                cell.btn_OpenUrl.isUserInteractionEnabled = true
                                
                                cell.lbl_Url.isHidden = false
                                cell.imgView_Url.isHidden = false
                                cell.k_Constraint_Top_labelUrl.constant = 8.0
                                cell.k_Constraint_Top_btnUrl.constant = 8.0
                                cell.k_Constraint_Top_imageViewUrl.constant = 8.0
                                
                                if array_public_UserSocialSites.count > 0   {   //social sites not nil
                                    cell.tbl_View_SocialSite.isHidden = false
                                    
                                    if array_public_UserSocialSites.count == 1 {   //social site count 1
                                        
                                        cell.k_Constraint_Height_TableviewSocialSite.constant = 50.0
                                        cell.k_Constraint_ViewDescriptionHeight.constant = 180.0
                                        
                                    }
                                        
                                    else  if array_public_UserSocialSites.count == 2{    //social site count 2
                                        
                                        cell.k_Constraint_Height_TableviewSocialSite.constant = 100.0
                                        cell.k_Constraint_ViewDescriptionHeight.constant = 210.0
                                        
                                    }
                                    else {//social site count 3
                                        
                                        cell.k_Constraint_Height_TableviewSocialSite.constant = 130.0
                                        cell.k_Constraint_ViewDescriptionHeight.constant = 240.0
                                    }
                                    
                                    
                                    cell.tbl_View_SocialSite.reloadData()
                                }
                                else{
                                    
                                    cell.tbl_View_SocialSite.isHidden = true
                                    cell.k_Constraint_ViewDescriptionHeight.constant = 160.0
                                }
                            }
                            else{//IF COMPANY URL IS NIL
                                
                                cell.lbl_Url.isHidden = true
                                cell.imgView_Url.isHidden = true
                                cell.btn_OpenUrl.isUserInteractionEnabled = false
                                
                                
                                if array_public_UserSocialSites.count > 0{//social sites not nil
                                    cell.tbl_View_SocialSite.isHidden = false
                                    cell.k_Constraint_Top_tblViewSocialSite.constant = -25.0
                                    
                                    if array_public_UserSocialSites.count == 1 {//social site count 1
                                        
                                        cell.k_Constraint_Height_TableviewSocialSite.constant = 50.0
                                        cell.k_Constraint_ViewDescriptionHeight.constant = 175.0
                                        
                                        
                                    }
                                    else  if array_public_UserSocialSites.count == 2{//social site count 2
                                        
                                        cell.k_Constraint_Height_TableviewSocialSite.constant = 100.0
                                        cell.k_Constraint_ViewDescriptionHeight.constant = 200.0
                                        
                                    }
                                    else{//social site count 3
                                        
                                        cell.k_Constraint_Height_TableviewSocialSite.constant = 130.0
                                        cell.k_Constraint_ViewDescriptionHeight.constant = 240.0
                                    }
                                    
                                    
                                    cell.tbl_View_SocialSite.reloadData()
                                }
                                else{//IF SOCIAL SITES ARE NIL IN CASE OF COMPANY
                                    
                                    cell.tbl_View_SocialSite.isHidden = true
                                    cell.k_Constraint_ViewDescriptionHeight.constant = 125.0
                                }
                                
                            }
                        }
                        else{
                            
                            if dict_Temp?.value(forKey: "schoolUrl") as? String != nil{
                                cell.lbl_Url.text = dict_Temp?.value(forKey: "schoolUrl") as? String
                                cell.btn_OpenUrl.isUserInteractionEnabled = true
                                
                                
                                cell.lbl_Url.isHidden = false
                                cell.imgView_Url.isHidden = false
                                cell.k_Constraint_Top_labelUrl.constant = 8.0
                                cell.k_Constraint_Top_btnUrl.constant = 8.0
                                cell.k_Constraint_Top_imageViewUrl.constant = 8.0
                                
                                if array_public_UserSocialSites.count > 0{//social sites not nil
                                    cell.tbl_View_SocialSite.isHidden = false
                                    
                                    if array_public_UserSocialSites.count == 1 {//social site count 1
                                        
                                        cell.k_Constraint_Height_TableviewSocialSite.constant = 50.0
                                        cell.k_Constraint_ViewDescriptionHeight.constant = 215.0
                                        
                                        
                                    }
                                    else  if array_public_UserSocialSites.count == 2{//social site count 2
                                        
                                        cell.k_Constraint_Height_TableviewSocialSite.constant = 100.0
                                        cell.k_Constraint_ViewDescriptionHeight.constant = 240.0
                                        
                                    }
                                    else{//social site count 3
                                        
                                        cell.k_Constraint_Height_TableviewSocialSite.constant = 130.0
                                        cell.k_Constraint_ViewDescriptionHeight.constant = 290.0
                                    }
                                    
                                    
                                    cell.tbl_View_SocialSite.reloadData()
                                }
                                else{
                                    
                                    cell.tbl_View_SocialSite.isHidden = true
                                    cell.k_Constraint_ViewDescriptionHeight.constant = 160.0
                                }
                                
                                
                            }
                            else{//IF SCHOOL URL IS NIL
                                
                                cell.lbl_Url.isHidden = true
                                cell.imgView_Url.isHidden = true
                                cell.btn_OpenUrl.isUserInteractionEnabled = false
                                
                                if array_public_UserSocialSites.count > 0{//social sites not nil
                                    cell.tbl_View_SocialSite.isHidden = false
                                    cell.k_Constraint_Top_tblViewSocialSite.constant = -25.0
                                    
                                    if array_public_UserSocialSites.count == 1 {//social site count 1
                                        
                                        cell.k_Constraint_Height_TableviewSocialSite.constant = 50.0
                                        cell.k_Constraint_ViewDescriptionHeight.constant = 175.0
                                        
                                        
                                    }
                                    else  if array_public_UserSocialSites.count == 2{//social site count 2
                                        
                                        cell.k_Constraint_Height_TableviewSocialSite.constant = 100.0
                                        cell.k_Constraint_ViewDescriptionHeight.constant = 200.0
                                        
                                    }
                                    else{//social site count 3
                                        
                                        cell.k_Constraint_Height_TableviewSocialSite.constant = 130.0
                                        cell.k_Constraint_ViewDescriptionHeight.constant = 240.0
                                    }
                                    
                                    
                                    cell.tbl_View_SocialSite.reloadData()
                                }
                                else{//IF SOCIAL SITES ARE NIL IN CASE OF school
                                    
                                    cell.tbl_View_SocialSite.isHidden = true
                                    cell.k_Constraint_ViewDescriptionHeight.constant = 125.0
                                }
                                
                            }
                            
                        }
                        
                    }
                    
                    if dict_Temp?.value(forKey: "shadowedByShadowUser") != nil {
                        cell.lbl_Count_ShadowedByShadowUser.text = "\((dict_Temp?.value(forKey: "shadowedByShadowUser") as! NSDictionary)["count"]!)"
                    }
                        
                    else {
                        cell.lbl_Count_ShadowedByShadowUser.text = "0"
                        
                    }
                    
                    if dict_Temp?.value(forKey: "shadowersVerified") != nil {
                        cell.lbl_Count_ShadowersVerified.text = "\((dict_Temp?.value(forKey: "shadowersVerified") as! NSDictionary)["count"]!)"
                    }
                    else {
                        
                        cell.lbl_Count_ShadowersVerified.text = "0"
                    }
                    
                    let str_bio = dict_Temp?.value(forKey: "bio") as? String
                    
                    if str_bio == "" || str_bio == nil {
                        cell.lbl_Description.text = "No biography to show..."
                    }
                    else {
                        cell.lbl_Description.text = str_bio
                    }
                    
                    //  profileImageUrl
                    if (dict_Temp?.value(forKey: "profileImageUrl")as? String) != nil {
                        var profileurl = dict_Temp?.value(forKey: "profileImageUrl") as? String
                        profileurl = profileurl?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                        
                        if profileurl != nil {
                            cell.imgView_ProfilePic.sd_setImage(with: URL(string:profileurl!), placeholderImage: UIImage(named: "profile-icon-1"))//image
                        }
                        
                    }else{
                        
                        cell.imgView_ProfilePic.image = UIImage.init(named: "dummy")
                        
                    }
                    self.bool_LastResultSearch = false
                    
                }
            }   //at
                else {
             
                    DispatchQueue.main.async {
    
                    cell.view_MainOccupation.isHidden = false
                    cell.setChart()

                    if self.arr_SearchData.count > 0 {
                        
                        self.dicUrl.removeAllObjects()
                        
                        if (self.arr_SearchData[indexPath.row] as! NSDictionary)["name"] != nil || (self.arr_SearchData[indexPath.row] as! NSDictionary)["name"] as? String != "" {
                            cell.lbl_CompanySchoolUserName.text = (self.arr_SearchData[indexPath.row] as! NSDictionary)["name"] as? String
                            cell.lbl_Abt.text = "About" + " " + "\((self.arr_SearchData[indexPath.row] as! NSDictionary)["name"]!)"

                        }
                        else {
                            
                            cell.lbl_CompanySchoolUserName.text = "NA"
                            cell.lbl_Abt.text = "About"
                        }
                        
                        let rating_number = "\((self.arr_SearchData[indexPath.row] as! NSDictionary)["avgRating"]!)"
                        
                        let dbl = 2.0
                        
                        if  dbl.truncatingRemainder(dividingBy: 1) == 0
                        {
                            cell.lbl_Rating.text = rating_number + ".0"
                            
                        }
                        else {
                            cell.lbl_Rating.text = rating_number
                        }
                        if (self.arr_SearchData[(indexPath.row)] as! NSDictionary)["occupationDTO"] as? NSDictionary != nil {
                           
                            
                            let dict_Temp = (self.arr_SearchData[(indexPath.row)] as! NSDictionary)["occupationDTO"] as! NSDictionary

                            let str_bio = dict_Temp.value(forKey: "description") as? String
                            
                            if str_bio == "" || str_bio == nil {
                                cell.txtView_Description.text = "No biography to show..."
                            }
                            else {
                                cell.txtView_Description.text = str_bio
                            }

                            
                            let morePrecisePI = Double((dict_Temp.value(forKey: "salary") as? String)!)
                            let myInteger = Int(morePrecisePI!)
                            let myNumber = NSNumber(value:myInteger)
                            print(myNumber)
                            cell.lbl_avgSalary.text = self.suffixNumber(number: myNumber) as String

                        }
                        
  
                        cell.lbl_RatingCount.text = "\((self.arr_SearchData[(indexPath.row)] as! NSDictionary)["ratingCount"]!)"
                       
                        cell.lbl_Growth.text = "15"
                       
                        cell.lbl_UserWithOccupation.text = "0"
                        cell.lbl_UserShadowed.text = "0"
                        
                        
 
                       
                    }
  
                }
                }
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.view.frame.size.width , height: self.view.frame.size.height + 180)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arr_SearchData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
    }
    
}


