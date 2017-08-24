//
//  RequestsListViewController.swift
//  Shadow
//
//  Created by Aditi on 23/08/17.
//  Copyright © 2017 Atinderjit Kaur. All rights reserved.
//

import UIKit

class RequestsListViewController: UIViewController {

    @IBOutlet var segment_Control: UISegmentedControl!
    @IBOutlet var tblView_Requests: UITableView!
    
    var user_Name:String?

    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        DispatchQueue.main.async {
            
            self.segment_Control.tintColor = Global.macros.themeColor_pink

            
            self.navigationItem.title = self.user_Name!
            self.segment_Control.backgroundColor = UIColor.white
            self.navigationItem.setHidesBackButton(false, animated:true)
            self.CreateNavigationBackBarButton()
        }

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func Action_SegmntControl(_ sender: UISegmentedControl) {
        
        if segment_Control.selectedSegmentIndex == 0{
            
           // self.segment_Control.tintColor = Global.macros.themeColor_pink
            self.performSegue(withIdentifier: "myrequests_to_requestdetail", sender: self)
        }
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
