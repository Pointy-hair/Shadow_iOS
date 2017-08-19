//
//  RegisterOptionsViewController.swift
//  Shadow
//
//  Created by Atinderjit Kaur on 31/05/17.
//  Copyright © 2017 Atinderjit Kaur. All rights reserved.
//

import UIKit

public var registeringAs:String?

class RegisterOptionsViewController: UIViewController,UIGestureRecognizerDelegate {
    
    
    @IBOutlet weak var btn_User: UIButton!
    @IBOutlet weak var btn_Company: UIButton!
     @IBOutlet weak var btn_School: UIButton!
    
    @IBOutlet weak var lbl_headerOnPopUp: UILabel!
    @IBOutlet weak var view_blurView: UIView!
    @IBOutlet weak var txtView_PopUp: UITextView!
    @IBOutlet weak var view_PopUp: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.SetButtonCustomAttributes(self.btn_User)
        self.SetButtonCustomAttributes(self.btn_Company)
        self.SetButtonCustomAttributes(self.btn_School)
        
        
        //   self.navigationItem.hidesBackButton = true //Hide default back button
        let myBackButton:UIButton = UIButton()
        myBackButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        myBackButton.setImage(UIImage(named:"backpurple"), for: UIControlState())
        myBackButton.addTarget(self, action: #selector(self.PopToRootViewController), for: UIControlEvents.touchUpInside)
        let leftBackBarButton:UIBarButtonItem = UIBarButtonItem(customView: myBackButton)
        self.navigationItem.leftBarButtonItem = leftBackBarButton

        view_PopUp.layer.cornerRadius = 9.0
        view_PopUp.layer.masksToBounds = true
        
        txtView_PopUp.layer.borderWidth = 2.0
        txtView_PopUp.layer.borderColor = UIColor.init(red: 248.0/255.0, green: 250.0/255.0, blue: 251.0/255.0, alpha: 1.0).cgColor
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handle_Tap(_:))) // Tap gesture to resign keyboard
        tap.delegate = self
        self.view_blurView.addGestureRecognizer(tap)
        
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: Tap gesture to hide keyboard
    func handle_Tap(_ sender: UITapGestureRecognizer) {
        
        view_blurView.isHidden = true
        view_PopUp.isHidden = true
    }

    
    @IBAction func Action_RegisterDetail(_ sender: UIButton) {
        
      
        
        view_blurView.isHidden = false
        view_PopUp.isHidden = false
        
        switch sender.tag {
        case 101:
            //User
            lbl_headerOnPopUp.text = "Registering as a user:"
        case 102:
            //Company
            lbl_headerOnPopUp.text = "Registering as a company:"
        case 103:
            //School
            lbl_headerOnPopUp.text = "Registering as a school:"
        default:
            break
        }

 
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        view_blurView.isHidden = true
        view_PopUp.isHidden = true
        
       
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    
    //MARK:- ButtonActions
   
    @IBAction func Action_RegistersAsUser(_ sender: UIButton) {
        
        view_blurView.isHidden = false
        view_PopUp.isHidden = false
        
        switch sender.tag {
        case 0:
            //User
            registeringAs = "USER"
        case 1:
            //Company
            registeringAs = "COMPANY"
        case 2:
            //School
            registeringAs = "SCHOOL"
        default:
            break
        }
        
        
        if self.checkInternetConnection()
        {
            self.performSegue(withIdentifier: "RegisterToUsername", sender: self)
        }
        else
        {
            self.showAlert(Message: Global.macros.kInternetConnection, vc: self)

        }
        
        
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
