//
//  SearchViewController.swift
//  Shadow
//
//  Created by Atinderjit Kaur on 26/06/17.
//  Copyright © 2017 Atinderjit Kaur. All rights reserved.
//

import UIKit

public var bool_AllTypeOfSearches = false
public var bool_CompanySchoolTrends = false
public var bool_LocationFilter = false
public var bool_Occupation = false

public var ratingType : String?




class SearchViewController: UIViewController {
    
    //Making secondary Searchbar
    var searchBar = UISearchBar()
    var btn2:UIButton = UIButton()
    var barBtn_Search: UIBarButtonItem?
    var lbl_Search = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.revealViewController() != nil {
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //Setting footer view
        self.showSearchBar()
        
        //creating button on search
        let btn_OnSearch = UIButton()
        btn_OnSearch.frame = CGRect(x: 0, y: 20 , width: self.view.frame.width, height: 40)
        btn_OnSearch.addTarget(self, action: #selector(self.next_View), for: .touchUpInside)
        self.searchBar.addSubview(btn_OnSearch)
        
        self.navigationItem.setHidesBackButton(false, animated:true)
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.tintColor = UIColor.clear
        self.tabBarController?.tabBar.backgroundColor = UIColor.clear
        
    }
    
    //MARK: Fuctions
    func showSearchBar() {
        
        // searchBar.delegate = self
        
        if let textFieldInsideSearchBar = self.searchBar.value(forKey: "searchField") as? UITextField,let glassIconView = textFieldInsideSearchBar.leftView as? UIImageView {
            
            //Magnifying glass
            glassIconView.frame = CGRect(x: 40, y: glassIconView.frame.origin.y , width: 16, height: 16)
            glassIconView.image = glassIconView.image?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
            
            textFieldInsideSearchBar.layer.borderColor = UIColor.clear.cgColor
            textFieldInsideSearchBar.layer.cornerRadius = 4.0
            textFieldInsideSearchBar.layer.borderWidth = 1.0
            textFieldInsideSearchBar.backgroundColor = UIColor.init(red: 144.0/255.0, green: 20.0/255.0, blue: 151.0/255.0, alpha: 1.0)
            textFieldInsideSearchBar.attributedPlaceholder = NSAttributedString(string: "Search",
                                                                                attributes: [NSForegroundColorAttributeName: UIColor.white])
            textFieldInsideSearchBar.isUserInteractionEnabled = false
            
        }
        navigationItem.titleView = searchBar
        
    }
    
    //Navigation to Custom search VC
    
    func PushToCustomSearchVC() {
        
        let vc = Global.macros.Storyboard.instantiateViewController(withIdentifier: "customSearch") as! CustomSearchViewController
        _ = self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    
    func next_View(){
        
        if self.checkInternetConnection()
        {
            DispatchQueue.main.async {
                
                self.searchBar.endEditing(true)
                self.view.endEditing(true)
                self.searchBar.resignFirstResponder()
                self.searchBar.text = ""
                
            }
            
            bool_AllTypeOfSearches = true
            self.PushToCustomSearchVC()
            
        }
        else
        {
            self.showAlert(Message: Global.macros.kInternetConnection, vc: self)
        }
    }
    
    
    //MARK: Button Actions
    
    @IBAction func Action_SelectCompany(_ sender: Any) {
        if self.checkInternetConnection()
        {
            ratingType = "Company"
            bool_CompanySchoolTrends = true
            self.PushToCustomSearchVC()
        }
        else
        {
            self.showAlert(Message: Global.macros.kInternetConnection, vc: self)
        }
    }
    
    
    @IBAction func Action_Location(_ sender: Any) {
        if self.checkInternetConnection()
        {
            bool_LocationFilter = true
            self.PushToCustomSearchVC()
            
        }
        else
        {
            self.showAlert(Message: Global.macros.kInternetConnection, vc: self)
            
        }
    }
    
    
    @IBAction func Action_School(_ sender: Any) {
        if self.checkInternetConnection()
        {
            
            ratingType = "School"
            bool_CompanySchoolTrends = true
            self.PushToCustomSearchVC()
            
        }
        else
        {
            self.showAlert(Message: Global.macros.kInternetConnection, vc: self)
            
        }
    }
    
    
    @IBAction func Action_Trends(_ sender: Any) {
        
        if self.checkInternetConnection()
        {
            ratingType = "Trend"
            bool_CompanySchoolTrends = true
            self.PushToCustomSearchVC()
        }
        else
        {
            self.showAlert(Message: Global.macros.kInternetConnection, vc: self)
            
        }
    }
    
    @IBAction func Action_Occupation(_ sender: UIButton) {
        
        
        if self.checkInternetConnection()
        {
            ratingType = "Occupation"
            bool_CompanySchoolTrends = true
            bool_Occupation = true
            self.PushToCustomSearchVC()
            
        }
        else
        {
            self.showAlert(Message: Global.macros.kInternetConnection, vc: self)
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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





