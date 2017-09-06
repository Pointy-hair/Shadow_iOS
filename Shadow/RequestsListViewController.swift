//
//  RequestsListViewController.swift
//  Shadow
//
//  Created by Aditi on 23/08/17.
//  Copyright © 2017 Atinderjit Kaur. All rights reserved.
//

import UIKit

var My_Request_Selected_Status:Bool = true

class RequestsListViewController: UIViewController {

    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var view_MainButtons: UIView!
    @IBOutlet var btn_MyRequest: UIButton!
    @IBOutlet var btn_ShadowRequest: UIButton!
    @IBOutlet var btn_Accepted: UIButton!
    @IBOutlet var lbl_btn_Accepted: UILabel!
    @IBOutlet var btn_All: UIButton!
    @IBOutlet var lbl_btn_All: UILabel!
    @IBOutlet var btn_Declined: UIButton!
    @IBOutlet var lbl_btn_Declined: UILabel!
    @IBOutlet var tblView_Requests: UITableView!
    @IBOutlet var lbl_NoRequests: UILabel!
    
    
    
    //Variables
    var user_Name:String?
    fileprivate var requestID:NSNumber?
    fileprivate var array_Requests = NSMutableArray()
    fileprivate var colorCode_light = UIColor.init(red: 237.0/255.0, green: 237.0/255.0, blue: 237.0/255.0, alpha: 1.0)
    
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
       
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        DispatchQueue.main.async {
            
            
            self.navigationItem.title = "Received Request"//self.user_Name!
            self.navigationItem.setHidesBackButton(false, animated:true)
            self.CreateNavigationBackBarButton()
            self.tabBarController?.tabBar.isHidden = true
            
            
            //Adding button to navigation bar
            let btn_delete = UIButton(type: .custom)
            btn_delete.setImage(UIImage(named: "trash"), for: .normal)
            btn_delete.frame = CGRect(x: self.view.frame.size.width - 25, y: 0, width: 25, height: 25)
            btn_delete.addTarget(self, action: #selector(self.delete_requests), for: .touchUpInside)
            let item2 = UIBarButtonItem(customView: btn_delete)
            //Right items
            self.navigationItem.setRightBarButtonItems([item2], animated: true)
            
            
            //adding view to table
            self.tblView_Requests.tableFooterView = UIView()
            
            self.view_MainButtons.layer.borderWidth = 1.5
            self.view_MainButtons.layer.borderColor = Global.macros.themeColor.cgColor
            
            //setting default selected button for request
            self.btn_MyRequest.setTitleColor(Global.macros.themeColor_pink, for: .normal)
            self.btn_ShadowRequest.setTitleColor(UIColor.black, for: .normal)
            
            
            //setting default selected filter button
            //Showing line and color of accepted button
            self.btn_All.setTitleColor(Global.macros.themeColor_pink, for: .normal)
            self.lbl_btn_All.backgroundColor = Global.macros.themeColor_pink
            
            //hiding the lines and changing color unselected buttons
            self.btn_Accepted.setTitleColor(UIColor.black, for: .normal)
            self.lbl_btn_Accepted.backgroundColor = self.colorCode_light

            self.btn_Declined.setTitleColor(UIColor.black, for: .normal)
            self.lbl_btn_Declined.backgroundColor = self.colorCode_light

            
        }

        //initialy my request keyword at server end is "send"
        My_Request_Selected_Status = true
        self.getRequestsByType(Type: Global.macros.kSend,SubType:Global.macros.kAll)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - Button Actions
    
    
    @IBAction func Action_MyRequests(_ sender: UIButton) {//requests to me
        
        self.navigationItem.title = "Received Requests"
        self.btn_MyRequest.setTitleColor(Global.macros.themeColor_pink, for: .normal)
        self.btn_ShadowRequest.setTitleColor(UIColor.black, for: .normal)

        //Showing line and color of accepted button
        self.btn_All.setTitleColor(Global.macros.themeColor_pink, for: .normal)
        self.lbl_btn_All.backgroundColor = Global.macros.themeColor_pink

        
        //hiding the lines and changing color unselected buttons
        self.btn_Accepted.setTitleColor(UIColor.black, for: .normal)
        self.lbl_btn_Accepted.backgroundColor = self.colorCode_light

        
        self.btn_Declined.setTitleColor(UIColor.black, for: .normal)
        self.lbl_btn_Declined.backgroundColor = self.colorCode_light

        self.getRequestsByType(Type: Global.macros.kSend,SubType:Global.macros.kAll)
        My_Request_Selected_Status = true

    }

    @IBAction func Action_ShadowRequests(_ sender: UIButton) {//requests that I have send
        
        self.navigationItem.title = "Sent Requests"
        self.btn_MyRequest.setTitleColor(UIColor.black, for: .normal)
        self.btn_ShadowRequest.setTitleColor(Global.macros.themeColor_pink, for: .normal)

        
        //Showing line and color of accepted button
        self.btn_All.setTitleColor(Global.macros.themeColor_pink, for: .normal)
        self.lbl_btn_All.backgroundColor = Global.macros.themeColor_pink

        
        //hiding the lines and changing color unselected buttons
        self.btn_Accepted.setTitleColor(UIColor.black, for: .normal)
        self.lbl_btn_Accepted.backgroundColor = self.colorCode_light

        
        self.btn_Declined.setTitleColor(UIColor.black, for: .normal)
        self.lbl_btn_Declined.backgroundColor = self.colorCode_light

        
        self.getRequestsByType(Type: Global.macros.kReceived,SubType:Global.macros.kAll)
        My_Request_Selected_Status = false
        
    }

    @IBAction func Action_Accepted(_ sender: UIButton) {
        
        //Showing line and color of accepted button
        self.btn_Accepted.setTitleColor(Global.macros.themeColor_pink, for: .normal)
        self.lbl_btn_Accepted.backgroundColor = Global.macros.themeColor_pink

        
        //hiding the lines and changing color unselected buttons
        self.btn_All.setTitleColor(UIColor.black, for: .normal)
        self.lbl_btn_All.backgroundColor = self.colorCode_light


        
        
        self.btn_Declined.setTitleColor(UIColor.black, for: .normal)
        self.lbl_btn_Declined.backgroundColor = self.colorCode_light


        //getting requests according to type(My request or shadow request)
        if My_Request_Selected_Status == true{//My request is selected
            self.getRequestsByType(Type: Global.macros.kSend,SubType:Global.macros.kAccept)
            
        }
        else{
            self.getRequestsByType(Type: Global.macros.kReceived,SubType:Global.macros.kAccept)

        }
        
    }

    @IBAction func Action_All(_ sender: UIButton) {
        
        //Showing line and color of accepted button
        self.btn_All.setTitleColor(Global.macros.themeColor_pink, for: .normal)
        self.lbl_btn_All.backgroundColor = Global.macros.themeColor_pink

        
        //hiding the lines and changing color unselected buttons
        self.btn_Accepted.setTitleColor(UIColor.black, for: .normal)
        self.lbl_btn_Accepted.backgroundColor = self.colorCode_light

        
        self.btn_Declined.setTitleColor(UIColor.black, for: .normal)
        self.lbl_btn_Declined.backgroundColor = self.colorCode_light

        
        //getting requests according to type(My request or shadow request)
        if My_Request_Selected_Status == true{//My request is selected
            self.getRequestsByType(Type: Global.macros.kSend,SubType:Global.macros.kAll)
            
        }
        else{
            self.getRequestsByType(Type: Global.macros.kReceived,SubType:Global.macros.kAll)
            
        }
    }


    @IBAction func Action_Declined(_ sender: UIButton) {
        
        //Showing line and color of accepted button
        self.btn_Declined.setTitleColor(Global.macros.themeColor_pink, for: .normal)
        self.lbl_btn_Declined.backgroundColor = Global.macros.themeColor_pink

        //hiding the lines and changing color unselected buttons
        self.btn_Accepted.setTitleColor(UIColor.black, for: .normal)
        self.lbl_btn_Accepted.backgroundColor = self.colorCode_light

        
        self.btn_All.setTitleColor(UIColor.black, for: .normal)
        self.lbl_btn_All.backgroundColor = self.colorCode_light


        //getting requests according to type(My request or shadow request)
        if My_Request_Selected_Status == true{//My request is selected
            self.getRequestsByType(Type: Global.macros.kSend,SubType:Global.macros.kReject)
            
        }
        else{
            self.getRequestsByType(Type: Global.macros.kReceived,SubType:Global.macros.kReject)
            
        }
    }
    
    
    @IBAction func Action_AcceptRequest(_ sender: UIButton) {
        
        sender.setTitleColor(UIColor.white, for: .normal)
        sender.backgroundColor = Global.macros.themeColor_pink
        
        
        //changing color of unselected button
        let indexPath = NSIndexPath.init(row: sender.tag, section: 0)
        let cell = tblView_Requests.cellForRow(at: indexPath as IndexPath) as! RequestsListTableViewCell
        cell.btn_Decline.setTitleColor(Global.macros.themeColor_pink, for: .normal)
        cell.btn_Decline.backgroundColor = UIColor.white

        self.request_AcceptReject(idx: sender.tag, acceptStatus: "true", rejectStatus: "false")
        
        
    }
    
    
    @IBAction func Action_DeclineRequest(_ sender: UIButton) {
        
        sender.setTitleColor(UIColor.white, for: .normal)
        sender.backgroundColor = Global.macros.themeColor_pink
        
        //changing color of unselected button
        let indexPath = NSIndexPath.init(row: sender.tag, section: 0)
        let cell = tblView_Requests.cellForRow(at: indexPath as IndexPath) as! RequestsListTableViewCell
        cell.btn_Accept.setTitleColor(Global.macros.themeColor_pink, for: .normal)
        cell.btn_Accept.backgroundColor = UIColor.white
        
        self.request_AcceptReject(idx: sender.tag, acceptStatus: "false", rejectStatus: "true")

    }
    
    
    //MARK: - Functions
    
    func getRequestsByType(Type:String,SubType:String)  {
        
        let dict = NSMutableDictionary()
        let  user_Id = SavedPreferences.value(forKey: Global.macros.kUserId) as? NSNumber
       
        dict.setValue(user_Id, forKey: Global.macros.kUserId)
        dict.setValue(Type, forKey: Global.macros.k_type)
        dict.setValue(SubType, forKey: Global.macros.k_subType)

        print(dict)
        
        if self.checkInternetConnection(){
            
            DispatchQueue.main.async {
                self.pleaseWait()
            }
            
            Requests_API.sharedInstance.getRequestByType(completionBlock: { (status, array_Info) in
                
                DispatchQueue.main.async {
                    self.clearAllNotice()
                }
                
                switch status {
                    
                case 200:
                    
                    DispatchQueue.main.async {
                        self.tblView_Requests.isHidden = false
                        self.lbl_NoRequests.isHidden = true
                        self.array_Requests = array_Info as! NSMutableArray
                        self.tblView_Requests.reloadData()
                    }
                    
                    break
                    
                case 404:
                    
                    DispatchQueue.main.async {
                        self.tblView_Requests.isHidden = true
                        self.lbl_NoRequests.isHidden = false
                        
                    }
                    break
                    
                case 401:
                    
                    DispatchQueue.main.async {
                        self.AlertSessionExpire()
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
             self.showAlert(Message:Global.macros.kInternetConnection, vc: self)
        }
    }
    
    func request_AcceptReject(idx:Int,acceptStatus:String,rejectStatus:String) {
        
        
        let request_id = (array_Requests.object(at: idx) as! NSDictionary).value(forKey: "id") as? NSNumber
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
                        
                        self.getRequestsByType(Type: Global.macros.kSend, SubType: Global.macros.kAll)
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
                    self.showAlert(Message: Global.macros.kError, vc: self)
                }

            }, dict: dict)
            
        }else{
            self.showAlert(Message: Global.macros.kInternetConnection, vc: self)
        }
        
    }
    
    
    
    func delete_requests(){
        
        
        let TitleString = NSAttributedString(string: "Shadow", attributes: [
            NSFontAttributeName : UIFont.systemFont(ofSize: 18),
            NSForegroundColorAttributeName : Global.macros.themeColor_pink
            ])
        let MessageString = NSAttributedString(string: "Are you sure you want to delete rejected requests?", attributes: [
            NSFontAttributeName : UIFont.systemFont(ofSize: 15),
            NSForegroundColorAttributeName : Global.macros.themeColor_pink
            ])
        
        DispatchQueue.main.async {
            self.clearAllNotice()
            
            let alert = UIAlertController(title: "Shadow", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: {(action) in
            
                let dict = NSMutableDictionary()
                let  user_Id = SavedPreferences.value(forKey: Global.macros.kUserId) as? NSNumber
                dict.setValue(user_Id, forKey: Global.macros.kUserId)
                print(dict)
                
                if self.checkInternetConnection(){
                    
                    DispatchQueue.main.async {
                        self.pleaseWait()
                    }
                    
                    Requests_API.sharedInstance.deleteRequests(completionBlock: { (status, dict_Info) in
                        
                        DispatchQueue.main.async {
                            self.clearAllNotice()
                        }
                        
                        switch status {
                            
                        case 200:
                            
                            DispatchQueue.main.async {
                                
                                My_Request_Selected_Status = true
                                self.getRequestsByType(Type: Global.macros.kSend,SubType:Global.macros.kAll)
                                
                                self.navigationItem.title = "Received Requests"
                                //setting default selected button for request
                                self.btn_MyRequest.setTitleColor(Global.macros.themeColor_pink, for: .normal)
                                self.btn_ShadowRequest.setTitleColor(UIColor.black, for: .normal)
                                
                                
                                //setting default selected filter button
                                //Showing line and color of accepted button
                                self.btn_All.setTitleColor(Global.macros.themeColor_pink, for: .normal)
                                self.lbl_btn_All.backgroundColor = Global.macros.themeColor_pink
                                
                                //hiding the lines and changing color unselected buttons
                                self.btn_Accepted.setTitleColor(UIColor.black, for: .normal)
                                self.lbl_btn_Accepted.backgroundColor = self.colorCode_light
                                
                                self.btn_Declined.setTitleColor(UIColor.black, for: .normal)
                                self.lbl_btn_Declined.backgroundColor = self.colorCode_light
                                
                            }
                            
                            break
                            
                        case 404:
                            
                            DispatchQueue.main.async {
                                
                                self.showAlert(Message: "No requests to delete.", vc: self)
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
                    self.showAlert(Message:Global.macros.kInternetConnection, vc: self)
                }
            
              
            
            }))
            alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler: nil))
            alert.view.layer.cornerRadius = 10.0
            alert.view.clipsToBounds = true
            alert.view.backgroundColor = UIColor.white
            alert.view.tintColor = Global.macros.themeColor_pink
            
            alert.setValue(TitleString, forKey: "attributedTitle")
            alert.setValue(MessageString, forKey: "attributedMessage")
            self.present(alert, animated: true, completion: nil)
            
        }

        
        
      /*  let dict = NSMutableDictionary()
        let  user_Id = SavedPreferences.value(forKey: Global.macros.kUserId) as? NSNumber
        dict.setValue(user_Id, forKey: Global.macros.kUserId)
        if self.checkInternetConnection(){
            
            DispatchQueue.main.async {
                self.pleaseWait()
            }
            
            Requests_API.sharedInstance.deleteRequests(completionBlock: { (status, dict_Info) in
                
                DispatchQueue.main.async {
                    self.clearAllNotice()
                }
                
                switch status {
                    
                case 200:
                    
                    DispatchQueue.main.async {
                      
                        
                        
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
                    self.showAlert(Message: Global.macros.kError, vc: self)
                    
                }
            }, dict: dict)
            
        }else{
            self.showAlert(Message:Global.macros.kInternetConnection, vc: self)
        }*/

        
        
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "myrequests_to_requestdetail"{
            
            let vc = segue.destination as! RequestDetailsViewController
            vc.username = self.navigationItem.title
            vc.request_Id =  self.requestID
        }
    }
}

extension RequestsListViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RequestsListTableViewCell
        
        cell.btn_Accept.tag = indexPath.section
        cell.btn_Decline.tag = indexPath.section
        
        
       // cell.contentView.layer.borderWidth = 1.0
       // cell.contentView.layer.borderColor = Global.macros.themeColor.cgColor
        cell.contentView.layer.cornerRadius = 5.0
        
        cell.DataToCell(dictionary: array_Requests.object(at: indexPath.section) as! NSDictionary)
        
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if array_Requests.count > 0{
            return array_Requests.count
        }
        else{
            return 0
        }

    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.requestID = (array_Requests.object(at: indexPath.section) as! NSDictionary).value(forKey: "id") as? NSNumber
        self.performSegue(withIdentifier: "myrequests_to_requestdetail", sender: self)

    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = UIView()
        header.backgroundColor = UIColor.clear
        return header
      
//        let view:UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.bounds.size.width, height: 10))
//        view.backgroundColor = .clear
//        
//        return view
    }
    
    
    
    
}
