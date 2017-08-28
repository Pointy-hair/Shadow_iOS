//
//  RequestsListViewController.swift
//  Shadow
//
//  Created by Aditi on 23/08/17.
//  Copyright © 2017 Atinderjit Kaur. All rights reserved.
//

import UIKit

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
    
    
    
    
    var user_Name:String?

    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        DispatchQueue.main.async {
            

            self.navigationItem.title = self.user_Name!
            self.navigationItem.setHidesBackButton(false, animated:true)
            self.CreateNavigationBackBarButton()
            self.tabBarController?.tabBar.isHidden = true
            
            self.view_MainButtons.layer.borderWidth = 1.0
            self.view_MainButtons.layer.borderColor = Global.macros.themeColor_pink.cgColor

            
        }

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - Button Actions
    
    
    @IBAction func Action_MyRequests(_ sender: UIButton) {
        
        
        self.btn_MyRequest.setTitleColor(Global.macros.themeColor_pink, for: .normal)
        self.btn_ShadowRequest.setTitleColor(UIColor.black, for: .normal)

        
        
    }

    @IBAction func Action_ShadowRequests(_ sender: UIButton) {
        
        self.btn_MyRequest.setTitleColor(UIColor.black, for: .normal)
        self.btn_ShadowRequest.setTitleColor(Global.macros.themeColor_pink, for: .normal)

    }

    @IBAction func Action_Accepted(_ sender: UIButton) {
        
        //Showing line and color of accepted button
        self.btn_Accepted.setTitleColor(Global.macros.themeColor_pink, for: .normal)
        self.lbl_btn_Accepted.isHidden = false
        
        //hiding the lines and changing color unselected buttons
        self.btn_All.setTitleColor(Global.macros.themeColor_pink, for: .normal)
        self.lbl_btn_Accepted.isHidden = false

        self.btn_Accepted.setTitleColor(Global.macros.themeColor_pink, for: .normal)
        self.lbl_btn_Accepted.isHidden = false

        
        
        
        
        
    }

    @IBAction func Action_All(_ sender: UIButton) {
        
    }


    @IBAction func Action_Declined(_ sender: UIButton) {
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "myrequests_to_requestdetail"{
            
            let vc = segue.destination as! RequestDetailsViewController
            vc.username = self.navigationItem.title
        }
        
        
        
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}

extension RequestsListViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RequestsListTableViewCell
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
          self.performSegue(withIdentifier: "myrequests_to_requestdetail", sender: self)

    }
    
    
    
}
