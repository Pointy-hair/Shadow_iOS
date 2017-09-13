//
//  ListingViewController.swift
//  Shadow
//
//  Created by Atinderjit Kaur on 06/09/17.
//  Copyright © 2017 Atinderjit Kaur. All rights reserved.
//

import UIKit
var bool_ComingFromList : Bool = false

class ListingViewController: UIViewController {

    @IBOutlet var tbl_View: UITableView!
    
    
    var type:String?
    var navigation_title:String?
    fileprivate var array_userList = NSMutableArray()
    var ListuserId : NSNumber?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewDidDisappear(_ animated: Bool) {
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        
        DispatchQueue.main.async {
            self.navigationItem.title = self.navigation_title
            self.navigationItem.setHidesBackButton(false, animated:true)
            self.CreateNavigationBackBarButton()
            self.tabBarController?.tabBar.isHidden = true
            self.tbl_View.tableFooterView = UIView()  //Set table extra rows eliminate

        }
        
        
        if type != nil{
            self.getlistofusers()
        }
        
    }
    
    
    
    //MARK: - Functions
    
    func getlistofusers()  {
        
        
        let dict = NSMutableDictionary()
        dict.setValue(ListuserId, forKey: Global.macros.kUserId)
        dict.setValue(self.type!, forKey: Global.macros.k_type)

        print(dict)
        
       if ListuserId == SavedPreferences.value(forKey: Global.macros.kUserId) as? NSNumber {
        if checkInternetConnection(){
            DispatchQueue.main.async {
                self.pleaseWait()
            
            }
        OpenList_API.sharedInstance.getListOfUsers(completion_block: { (status, dict_Info) in
            
            DispatchQueue.main.async {
                self.clearAllNotice()
            }
            
            switch status{
                
            case 200:
                DispatchQueue.main.async {
                    
                    self.array_userList.removeAllObjects()
                    if dict_Info["shadowersVerified"] != nil{
                        
                        if (dict_Info.value(forKey: "shadowersVerified") as! NSDictionary).value(forKey:"count") as? NSNumber != 0{

                        self.array_userList = ((dict_Info.value(forKey: "shadowersVerified") as! NSDictionary).value(forKey:"requestDTOs") as! NSArray).mutableCopy() as! NSMutableArray
                            
                        }else{
                            
                            self.showAlert(Message: "No Data Found", vc: self)

                        }
                    }
                    
                    if dict_Info["shadowedByShadowUser"] != nil{
                        
                         if (dict_Info.value(forKey: "shadowedByShadowUser") as! NSDictionary).value(forKey:"count") as? NSNumber != 0{
                        
                        
                        self.array_userList = ((dict_Info.value(forKey: "shadowedByShadowUser") as! NSDictionary).value(forKey:"requestDTOs") as! NSArray).mutableCopy() as! NSMutableArray
                         }else{
                            self.showAlert(Message: "No Data Found", vc: self)

                        }
                    }
                    
                    if dict_Info["schoolOrCompanyWithTheseOccupations"] != nil{
                        
                        if (dict_Info.value(forKey: "schoolOrCompanyWithTheseOccupations") as! NSDictionary).value(forKey:"count") as? NSNumber != 0{
                          
                            
                            if (dict_Info.value(forKey: "schoolOrCompanyWithTheseOccupations") as! NSDictionary).value(forKey:"schoolList") != nil {
                            
                        self.array_userList = ((dict_Info.value(forKey: "schoolOrCompanyWithTheseOccupations") as! NSDictionary).value(forKey:"schoolList") as! NSArray).mutableCopy() as! NSMutableArray
                            }
                            
                            if (dict_Info.value(forKey: "schoolOrCompanyWithTheseOccupations") as! NSDictionary).value(forKey:"companyList") != nil {
                                
                                self.array_userList = ((dict_Info.value(forKey: "schoolOrCompanyWithTheseOccupations") as! NSDictionary).value(forKey:"companyList") as! NSArray).mutableCopy() as! NSMutableArray
                            }
                        }
                        else{
                            
                            self.showAlert(Message: "No Data Found", vc: self)

                        }
                    }
                    if dict_Info["schoolOrCompanyWithTheseUsers"] != nil{
                        
                        if (dict_Info.value(forKey: "schoolOrCompanyWithTheseUsers") as! NSDictionary).value(forKey:"count") as? NSNumber != 0 {
                        
                        self.array_userList = ((dict_Info.value(forKey: "schoolOrCompanyWithTheseUsers") as! NSDictionary).value(forKey:"userList") as! NSArray).mutableCopy() as! NSMutableArray
                        }
                        else{
                            self.showAlert(Message: "No Data Found", vc: self)
                        }
                    }

                    
                    self.tbl_View.reloadData()

                }
                break
                
            case 401:
                
                break
                
                
            default:
                
                
                break
                
                
            }
            
        }, error_block: { (error) in
            DispatchQueue.main.async {
                self.clearAllNotice()
                self.showAlert(Message: Global.macros.kError, vc: self)
            }
        }, dict: dict)
        }else{
            self.showAlert(Message: Global.macros.kInternetConnection, vc: self)
        }
    }
    else{
        self.tbl_View.isHidden = true
        bool_ComingFromList = false

    self.showAlert(Message: "Coming Soon", vc: self)

    }
    }
    
    
    
    /**
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ListingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    return self.array_userList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_listing", for: indexPath) as! ListingTableViewCell
        
        
        cell.dataToCell(dictionay: self.array_userList[indexPath.row] as! NSDictionary)
        
        
        return cell
     
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        bool_ComingFromList = true
        var user_dict = NSDictionary()
        user_dict = self.array_userList[indexPath.row] as! NSDictionary
        if user_dict["userDTO"] != nil{
            
            user_dict = user_dict.value(forKey: "userDTO") as! NSDictionary
        }
       
        let role = user_dict.value(forKey: Global.macros.krole) as? String
        
        if role == "COMPANY" || role == "SCHOOL"
        {
            DispatchQueue.main.async {
                userIdFromSearch = user_dict["userId"] as? NSNumber

            let vc = Global.macros.Storyboard.instantiateViewController(withIdentifier: "company") as! ComapanySchoolViewController
            _ = self.navigationController?.pushViewController(vc, animated: true)
            vc.extendedLayoutIncludesOpaqueBars = true
            self.automaticallyAdjustsScrollViewInsets = false
            }
        }
        else {
            DispatchQueue.main.async {
                userIdFromSearch = user_dict["userId"] as? NSNumber

                let vc = Global.macros.Storyboard.instantiateViewController(withIdentifier: "user") as! ProfileVC
                _ = self.navigationController?.pushViewController(vc, animated: true)
                vc.extendedLayoutIncludesOpaqueBars = true
                self.automaticallyAdjustsScrollViewInsets = false
                //self.navigationController?.navigationBar.isTranslucent = false
            }
        }
  
        
    }
    
    
}
