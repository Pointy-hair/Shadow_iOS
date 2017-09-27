//
//  EnterEmailVC.swift
//  Shadow
//
//  Created by Sahil Arora on 5/31/17.
//  Copyright © 2017 Atinderjit Kaur. All rights reserved.
//

import UIKit

class EnterEmailVC: UIViewController {
    
    @IBOutlet var btn_Next: UIButton!
    @IBOutlet var textfield_Email: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    //    self.navigationItem.hidesBackButton = true //Hide default back button
               self.SetButtonCustomAttributes(btn_Next)
        
        textfield_Email.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControlEvents.editingChanged)
        
        
    }
    func textFieldDidChange(textField:UITextField)
    {
        print(textField.text!)
      if  textfield_Email.text != ""  &&  self.isValidEmail(textfield_Email.text!) {
            
            SetButtonCustomAttributesPurple(btn_Next)
        }
        else {
            
            SetButtonCustomAttributes(btn_Next)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if str_Confirmation == "true" {
        self.navigationItem.hidesBackButton = true
            
        
            
        }
        else {
            
            let myBackButton:UIButton = UIButton()
            myBackButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
            myBackButton.setImage(UIImage(named:"backpurple"), for: UIControlState())
            myBackButton.addTarget(self, action: #selector(self.root_ViewController), for: UIControlEvents.touchUpInside)
            let leftBackBarButton:UIBarButtonItem = UIBarButtonItem(customView: myBackButton)
            self.navigationItem.leftBarButtonItem = leftBackBarButton

        }
       Validation()
        
        
    }
    
    func root_ViewController() {
        DispatchQueue.main.async {
            self.setRootView("Login")
        }
        
    }
    //To hide keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
       
            self.view.endEditing(true)
        
    }
    
    
    
    //Validation
    fileprivate func Validation()
    {
        if textfield_Email.text != ""{
            btn_Next.isUserInteractionEnabled = true
        }
        else{
            btn_Next.isUserInteractionEnabled = false
        }
    }
    
    @IBAction func Action_Next(_ sender: UIButton) {
        
        if textfield_Email.text != ""
        {
        bool_fromMobile = true
        bool_fromVerificationMobile = true
        if bool_NotVerified == false && str_Confirmation == "" {
            
            let dict = NSMutableDictionary()
            dict.setValue(textfield_Email.text, forKey: Global.macros.kEmail)
            dict.setValue(registeringAs, forKey: "role")
            dict.setValue(password, forKey: Global.macros.kPassword)
            dict.setValue(false, forKey: "phoneOtp")
            dict.setValue(username, forKey: Global.macros.kUserName)
            dict.setValue(firstName, forKey: Global.macros.kFirstName)
            dict.setValue(lastName, forKey: Global.macros.kLastName)
            dict.setValue(countryCode, forKey: "countryCode")
            dict.setValue(schoolName, forKey: "schoolName")
            dict.setValue(Location, forKey: "location")
            dict.setValue(companyName, forKey: "companyName")
            dict.setValue(allowShadow, forKey: "OtherUserShadowYou")
            dict.setValue(true, forKey: "emailOtp")
            dict.setValue("1.1", forKey: Global.macros.kAppVersion)
            dict.setValue("1.1.1", forKey: Global.macros.kAppBuildNumber)
            dict.setValue(latitude, forKey: Global.macros.klatitude)
            dict.setValue(longitude, forKey: Global.macros.klongitude)
            
            print(dict)
            if self.checkInternetConnection(){
                if self.isValidEmail(textfield_Email.text!){
                    DispatchQueue.main.async{
                        self.pleaseWait()
                    }
                    
                    AuthenticationAPI.sharedInstance.Register(dict: dict, completion: {(response) in
                        print(response)
                        switch response {
                        case 200:
                            DispatchQueue.main.async {
                                self.performSegue(withIdentifier: "EmailToOTP", sender: self)
                            }
                            
                        case 226:
                            DispatchQueue.main.async {
                                self.showAlert(Message: "Email already exist.", vc: self)
                            }
                        default:
                            break
                        }
                        self.clearAllNotice()
                        
                    }, errorBlock: {(err) in
                        
                        DispatchQueue.main.async {
                            self.clearAllNotice()
                            self.showAlert(Message: Global.macros.kError, vc: self)
                        }
                    })
                }
                else{
                    self.showAlert(Message: Global.macros.KInvalidEmail, vc: self)
                }
            }
            else{
                self.showAlert(Message: Global.macros.kInternetConnection, vc: self)
            }
        }
        else if str_Confirmation == "true" {//editProfile
            let dict = NSMutableDictionary()
              dict.setValue(SavedPreferences.value(forKey: Global.macros.kUserId), forKey: Global.macros.kUserId)
            dict.setValue(textfield_Email.text, forKey: Global.macros.kEmail)
            dict.setValue("1.1", forKey: Global.macros.kAppVersion)
            dict.setValue("1.1.1", forKey: Global.macros.kAppBuildNumber)
            
            print(dict)
            if self.checkInternetConnection(){
                if self.isValidEmail(textfield_Email.text!){
                    DispatchQueue.main.async{
                        self.pleaseWait()
                    }
                    
                    AuthenticationAPI.sharedInstance.editProfile(dict: dict, completion: {(response) in
                        print(response)
                        switch response {
                        case 200:
                            DispatchQueue.main.async {
                                SavedPreferences.set("yes", forKey: "user_verified")

                                self.navigationController?.navigationBar.isHidden = true
                               // self.performSegue(withIdentifier: "email_to_reveal", sender: self)
                                self.performSegue(withIdentifier: "email_present_reveal", sender: self)

                                
//                                let vc = Global.macros.Storyboard.instantiateViewController(withIdentifier: "TabBar")as! TabbarController
//                                Global.macros.kAppDelegate.window?.rootViewController = vc
//                                vc.selectedIndex = 1
                            }
                            
                        case 226:
                            DispatchQueue.main.async {
                                self.showAlert(Message: "Email already exist.", vc: self)
                            }
                            
                        case 500:
                            DispatchQueue.main.async {
                                self.showAlert(Message: "Error occured while Otp resend.", vc: self)
                            }
                        default:
                            break
                        }
                        self.clearAllNotice()
                        
                    }, errorBlock: {(err) in
                        
                        DispatchQueue.main.async {
                            self.clearAllNotice()
                            self.showAlert(Message: Global.macros.kError, vc: self)
                        }
                    })
                }
                else{
                    self.showAlert(Message: Global.macros.KInvalidEmail, vc: self)
                }
            }
            else{
                self.showAlert(Message: Global.macros.kInternetConnection, vc: self)
            }

            
        }
        
        else{
            
            let dict = NSMutableDictionary()
            dict.setValue(textfield_Email.text, forKey: Global.macros.kEmail)
            
            if self.checkInternetConnection()
            {
                if self.isValidEmail(textfield_Email.text!){

                DispatchQueue.main.async {
                    self.pleaseWait()
                }
                AuthenticationAPI.sharedInstance.ResendOtp(dict: dict, completion: {(response) in
                    
                    switch response.0{
                    case 200:
                        
                        DispatchQueue.main.async {
                            self.performSegue(withIdentifier: "EmailToOTP", sender: self)
                        }
                    default:break
                        
                    }
                    self.clearAllNotice()
                    
                }, errorBlock: {(err) in
                    
                    DispatchQueue.main.async {
                        self.clearAllNotice()
                        self.showAlert(Message: Global.macros.kError, vc: self)
                    }
                })
                }
                else {
                    self.showAlert(Message: Global.macros.KInvalidEmail, vc: self)

                    
                }
            }
            
            else {
                self.showAlert(Message: Global.macros.kInternetConnection, vc: self)

            }
        }
        }
        else {
            
            self.showAlert(Message: "Please enter your email.", vc: self)

        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "EmailToOTP"{
            let vc =  segue.destination as! EnterOtpVC
            vc.otpRecievedOn = "email"
            vc.emailId = textfield_Email.text
        }
    }
}
extension EnterEmailVC:UITextFieldDelegate
{
       
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField.text == "\n"
        {
            textField.resignFirstResponder()
        }
     //   Validation()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        //textField.text?.capitalizeFirstLetter()
        
        
        
        let string: NSString = (textField.text! as NSString).replacingCharacters(in: range, with: string) as NSString
        
        if string.length > 0
         {
            if string.hasPrefix(" ") {
                return false
            }
            else if string.hasSuffix(" ") {
                return false
            }
                
            else if string.contains(" ") {
                return false
            }
            btn_Next.isUserInteractionEnabled = true

            return string.length <= 40
        }
        else{
            btn_Next.isUserInteractionEnabled = false
            return string.length <= 40
            
        }
        
        
        
    }
 
    
}
