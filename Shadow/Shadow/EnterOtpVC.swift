//
//  EnterOtpVC.swift
//  Shadow
//
//  Created by Sahil Arora on 5/31/17.
//  Copyright © 2017 Atinderjit Kaur. All rights reserved.
//

import UIKit

class EnterOtpVC: UIViewController {

    @IBOutlet var btn_ResendOtp: UIButton!
    @IBOutlet var lbl_OtpSource:UILabel!
    @IBOutlet var btn_Next: UIButton!
    @IBOutlet var textfield_Otp: UITextField!
    
    //Variables from segue from previous class
    public var otpRecievedOn:String?
    public var emailId:String?
    public var country_Code:String?
    public var Phonenumber:String?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        //  self.navigationItem.hidesBackButton = true //Hide default back button
        let myBackButton:UIButton = UIButton()
        myBackButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        myBackButton.setImage(UIImage(named:"backpurple"), for: UIControlState())
        myBackButton.addTarget(self, action: #selector(self.PopToRootViewController), for: UIControlEvents.touchUpInside)
        let leftBackBarButton:UIBarButtonItem = UIBarButtonItem(customView: myBackButton)
        self.navigationItem.leftBarButtonItem = leftBackBarButton
        
        
        self.SetButtonCustomAttributes(btn_Next)
        self.SetButtonCustomAttributes(btn_ResendOtp)
        
        textfield_Otp.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControlEvents.editingChanged)
        
        
    }
  
    func textFieldDidChange(textField:UITextField)
    {
        if  textfield_Otp.text != ""  && (textfield_Otp.text?.characters.count)! >= 6 {

     
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
        
        if otpRecievedOn == "email"
        {
          lbl_OtpSource.text = "Enter the code sent to you to your registered email."
        }
        else
        {
         lbl_OtpSource.text = "Enter the code sent to you via sms."
        }
     Validation()
        
    }
//    //TO hide Keyboard
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let touch:UITouch = touches.first!
//        if touch.view != btn_Next {
//            self.view.endEditing(true)
//            Validation()
//            
//        }
//        
//    }
    
    
    fileprivate func Validation()
    {
        
        if textfield_Otp.text != ""
        {
            btn_Next.isUserInteractionEnabled = true
            Action_Next(btn_Next)
        }
        else
        {
            btn_Next.isUserInteractionEnabled = false
        }
    }
    
    @IBAction func Action_ResendOtp(_ sender: UIButton) {
        
             
     //   if bool_fromMobile == true {

        
        let dict = NSMutableDictionary()
        dict.setValue(str_email, forKey: Global.macros.kEmail)
        
        if self.checkInternetConnection()
        {
            DispatchQueue.main.async {
            self.pleaseWait()
            }
            AuthenticationAPI.sharedInstance.ResendOtp(dict: dict, completion: {(response) in
                
                switch response.0{
                    
                case 200:
                    
                    DispatchQueue.main.async {
                        self.showAlert(Message: Global.macros.kResentOtp, vc: self)

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
        
    /*    }
        
        else{
            let dict = NSMutableDictionary()
            dict.setValue(Phonenumber, forKey: Global.macros.kMobileNumber)
            dict.setValue(country_Code, forKey: Global.macros.kCountryCode)

            
            if self.checkInternetConnection()
            {
                DispatchQueue.main.async {
                    self.pleaseWait()
                }
                AuthenticationAPI.sharedInstance.ResendOtpPhone(dict: dict, completion: {(response) in
                    
                    switch response.0{
                        
                    case 200:
                        
                        DispatchQueue.main.async {
                            self.showAlert(Message: Global.macros.kResentOtp, vc: self)

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
            
            
        } */
        
        
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
    @IBAction func Action_Next(_ sender: UIButton) {
        
        if textfield_Otp.text != ""
        {
            if (textfield_Otp.text?.characters.count)! >= 6 {
     
     // if bool_fromMobile == true {
      if self.checkInternetConnection()
      {
        
        //API Response 
        let dict = NSMutableDictionary()
        dict.setValue(SavedPreferences.value(forKey: Global.macros.kUserId)as! NSNumber, forKey:Global.macros.kUserId )
        dict.setValue(textfield_Otp.text, forKey: "emailVerificationOtp")
        
        
        DispatchQueue.main.async {
            self.pleaseWait()
        }
        
        AuthenticationAPI.sharedInstance.VerifyOTP(dict: dict, completion: {(response) in
           
            switch response {
                
            case 200:
               
                DispatchQueue.main.async {
                    self.showAlert(Message: "User registered successfully.", vc: self)

//                    if bool_fromVerificationMobile == true {
//                        str_Confirmation = "true"
//                        let vc = Global.macros.Storyboard.instantiateViewController(withIdentifier: "PhoneNumber") as! EnterPhoneNumberVC
//                        _ = self.navigationController?.pushViewController(vc, animated: true)
//  
//                        
//                    }
//                    else {
//                        str_Confirmation = "true"
//                        let vc = Global.macros.Storyboard.instantiateViewController(withIdentifier: "Email") as! EnterEmailVC
//                        _ = self.navigationController?.pushViewController(vc, animated: true)
//
//                    }
//                   
                    SavedPreferences.set("yes", forKey: "user_verified")
                    self.navigationController?.navigationBar.isHidden = true
                    self.performSegue(withIdentifier: "email_present_reveal", sender: self)

                    
                }
                
                
            case 400:
                DispatchQueue.main.async {
                    self.showAlert(Message: "Incorrect verification code.", vc: self)
                }
                break
                
            default:break
                
            }
            
            DispatchQueue.main.async {
                self.clearAllNotice()
            }
        }, errorBlock: {(err) in
            
            DispatchQueue.main.async {
                self.clearAllNotice()
                self.showAlert(Message: (err?.localizedDescription)!, vc: self)

                
            }
            
        })
        
        
                }
        else
      {
        self.showAlert(Message: Global.macros.kInternetConnection, vc: self)

        
        }
    /*    }
        
        else{
            
            if self.checkInternetConnection()
            {
                
                //API Response
                let dict = NSMutableDictionary()
                dict.setValue(SavedPreferences.value(forKey: Global.macros.kUserId)as! NSNumber, forKey:Global.macros.kUserId )
                dict.setValue(textfield_Otp.text, forKey: "smsVerificationOtp")
                
                
                DispatchQueue.main.async {
                    self.pleaseWait()
                }
                
                AuthenticationAPI.sharedInstance.VerifyOTPPhoneNumber(dict: dict, completion: {(response) in
                    
                    switch response {
                        
                    case 200:
                        
                        DispatchQueue.main.async {
                            self.showAlert(Message: "User registered successfully.", vc: self)
                            
                            if bool_fromVerificationMobile == true {
                                str_Confirmation = "true"
                                let vc = Global.macros.Storyboard.instantiateViewController(withIdentifier: "PhoneNumber") as! EnterPhoneNumberVC
                                _ = self.navigationController?.pushViewController(vc, animated: true)
                                
                                
                            }
                            else {
                                str_Confirmation = "true"
                                let vc = Global.macros.Storyboard.instantiateViewController(withIdentifier: "Email") as! EnterEmailVC
                                _ = self.navigationController?.pushViewController(vc, animated: true)
                                
                            }
                        }
                    case 400:
                        DispatchQueue.main.async {
                            self.showAlert(Message: "Incorrect verification code.", vc: self)
                        }
                        break
                    default:break
                        
                    }
                    
                    DispatchQueue.main.async {
                        self.clearAllNotice()
                    }
                }, errorBlock: {(err) in
                    
                    DispatchQueue.main.async {
                        self.clearAllNotice()
                        self.showAlert(Message: Global.macros.kError, vc: self)

                    }
                    
                })
                
                
            }
            else
            {
                self.showAlert(Message: Global.macros.kInternetConnection, vc: self)

                
            }

        } */
            }
            else {
                self.showAlert(Message: "Otp must contain 6 characters.", vc: self)

                
            }
    }
        
        else
        {
            self.showAlert(Message: "Please enter otp.", vc: self)
            
            
        }
        
    }

}
extension EnterOtpVC:UITextFieldDelegate
{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textfield_Otp.text == "\n"
        {
            textfield_Otp.resignFirstResponder()
      //  Validation()
        
        }
        
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
    //    textField.text?.capitalizeFirstLetter()
        
        
        
        let string: NSString = (textField.text! as NSString).replacingCharacters(in: range, with: string) as NSString
        
        if (string.length > 0) {
            
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
            return string.length <= 6
        }
        else{
            btn_Next.isUserInteractionEnabled = false
            return string.length <= 6
            
        }
        
        
        
        return true
    }
 
    
}
