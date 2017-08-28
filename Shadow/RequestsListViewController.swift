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
        }

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
          //  self.performSegue(withIdentifier: "myrequests_to_requestdetail", sender: self)
    
    //MARK: - Button Actions
    
    
    @IBAction func Action_MyRequests(_ sender: UIButton) {
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
