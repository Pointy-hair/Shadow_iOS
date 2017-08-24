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
    
    var username:String?

    override func viewDidLayoutSubviews() {
        self.scroll_View.contentSize = CGSize.init(width: self.view.frame.width, height: 800)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.async {
            
            self.navigationItem.title = self.username!
            self.navigationItem.setHidesBackButton(false, animated:true)
            self.CreateNavigationBackBarButton()
            
            
            self.calender.layer.borderWidth = 1.0
            self.calender.layer.borderColor = Global.macros.themeColor.cgColor
            self.calender.layer.cornerRadius = 5.0
            
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

            self.lbl_Location.layer.cornerRadius = 5.0
            self.lbl_Location.layer.borderWidth = 1.0
            self.lbl_Location.layer.borderColor = Global.macros.themeColor.cgColor
            
            self.lbl_VirtualMedium.layer.cornerRadius = 5.0
            self.lbl_VirtualMedium.layer.borderWidth = 1.0
            self.lbl_VirtualMedium.layer.borderColor = Global.macros.themeColor.cgColor
            
        }
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Button Actions
    @IBAction func action_OpenVideo(_ sender: UIButton) {
        
        self.showAlert(Message: "Coming", vc: self)
        
    }

    @IBAction func action_Accept(_ sender: UIButton) {
        
        //selected button
        self.btn_Accept.setTitleColor(UIColor.white, for: .normal)
        self.btn_Accept.backgroundColor = UIColor.lightGray
        
        //deselected button
        self.btn_Decline.setTitleColor(UIColor.lightGray, for: .normal)
        self.btn_Decline.backgroundColor = UIColor.white

        
    }
    
    @IBAction func action_Decline(_ sender: UIButton) {
        
        
        //selected button
        self.btn_Decline.setTitleColor(UIColor.white, for: .normal)
        self.btn_Decline.backgroundColor = UIColor.lightGray

        
        //deselected button
        self.btn_Accept.setTitleColor(UIColor.lightGray, for: .normal)
        self.btn_Accept.backgroundColor = UIColor.white
        

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
