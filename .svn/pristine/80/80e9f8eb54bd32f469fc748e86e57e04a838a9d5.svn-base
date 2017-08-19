//
//  ResetPasswordVC.swift
//  Shadow
//
//  Created by Sahil Arora on 6/5/17.
//  Copyright © 2017 Atinderjit Kaur. All rights reserved.
//

import UIKit

class ResetPasswordVC: UIViewController {
    
    @IBOutlet var textfield_Otp:UITextField!
    @IBOutlet var textfield_Password:UITextField!
    @IBOutlet var textfield_ConfirmPassword:UITextField!
    @IBOutlet var btn_Done:UIButton!
    public var user_id : String?
    public var otp : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        
        let myBackButton:UIButton = UIButton()
        myBackButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        myBackButton.setImage(UIImage(named:"backpurple"), for: UIControlState())
        myBackButton.addTarget(self, action: #selector(self.PopToRootViewController), for: UIControlEvents.touchUpInside)
        let leftBackBarButton:UIBarButtonItem = UIBarButtonItem(customView: myBackButton)
        self.navigationItem.leftBarButtonItem = leftBackBarButton

        self.SetButtonCustomAttributes(btn_Done)
        add_padding(textfield: textfield_Otp)
        add_padding(textfield: textfield_Password)
        add_padding(textfield: textfield_ConfirmPassword)
        
        Validation()
        textfield_Otp.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControlEvents.editingChanged)
          textfield_Password.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControlEvents.editingChanged)
          textfield_ConfirmPassword.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControlEvents.editingChanged)
    }
    func textFieldDidChange(textField:UITextField)
    {
        print(textField.text!)
        if textfield_Otp.text != "" && (textfield_Otp.text?.characters.count)! >= 6 &&
         textfield_Password.text != "" && textfield_ConfirmPassword.text != "" && self.isPasswordLength(password: textfield_Password.text!) &&  self.isPasswordSame(Password: textfield_Password.text!, ConfirmPassword: textfield_ConfirmPassword.text!)
        {
            SetButtonCustomAttributesPurple(btn_Done)
            
        }
        else
        {
            SetButtonCustomAttributes(btn_Done)
            
        }    }

    
    
    func Api_ResetPassword() {
        
        let dict = NSMutableDictionary()
        dict.setValue(self.user_id, forKey: Global.macros.kUserId)
        dict.setValue(textfield_ConfirmPassword.text, forKey: Global.macros.kPassword)
        
        
        if self.checkInternetConnection()
        {
            DispatchQueue.main.async {
                self.pleaseWait()
            }
            
            AuthenticationAPI.sharedInstance.ForgetPassword(dict: dict, completion: {(response) in
                switch response{
                    
                case 200:
                    DispatchQueue.main.async {
                        self.setRootView("Login")
                    }
                    
                case 404:
                    DispatchQueue.main.async {
                        self.showAlert(Message: Global.macros.kUserNotExist, vc: self)
                        
                    }
                    
                default:break
                    
                }
                self.clearAllNotice()
                
            }, errorBlock: {(err) in
                
                
                DispatchQueue.main.async{
                    self.clearAllNotice()
                    self.showAlert(Message: Global.macros.kError, vc: self)
                    
                }
                
            })
            
            
        }
        else
        {
            self.showAlert(Message: Global.macros.kInternetConnection, vc: self)
            
        }
        
        
        
    }
    
    
    @IBAction func Action_Done(_ sender: UIButton) {
        
        if textfield_Otp.text != ""
        {
            
            if (textfield_Otp.text?.characters.count)! >= 6
            {
                
                if (textfield_Otp.text == self.otp) {
                    
                    if textfield_Password.text != ""
                    {
                        
                        if self.isPasswordLength(password: textfield_Password.text!) {
                            
                            if textfield_ConfirmPassword.text != ""
                            {
                                
                                if self.isPasswordLength(password: textfield_ConfirmPassword.text!) {
                                    if self.isPasswordSame(Password: textfield_Password.text!, ConfirmPassword: textfield_ConfirmPassword.text!)  {
                                        
                                        Api_ResetPassword()
                                    }
                                    else {
                                        
                                        self.showAlert(Message: "New password does not match with confirm password.", vc: self)
                                        
                                        
                                    }
                                    
                                }
                                    
                                else {
                                    self.showAlert(Message: "Please enter valid confirm password.", vc: self)
                                    
                                    
                                }
                            }
                            else {
                                self.showAlert(Message: "Please enter confirm new password.", vc: self)
                                
                            }
                        }
                            
                            
                        else {
                            self.showAlert(Message: "Please enter valid new password.", vc: self)
                            
                            
                        }
                    }
                    else{
                        
                        self.showAlert(Message: "Please enter new password.", vc: self)
                    }
                }
                    
                else{
                    
                    self.showAlert(Message: "You have entered wrong otp.", vc: self)
                }
                
            }
            else {
                self.showAlert(Message: "Please enter valid otp.", vc: self)
                
            }
        }
        else {
            self.showAlert(Message: "Please enter otp.", vc: self)
            
            
        }
    }
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    fileprivate func Validation()
    {
        
        if textfield_Otp.text != ""  && textfield_Password.text != "" && textfield_ConfirmPassword.text != ""
        {
            btn_Done.isUserInteractionEnabled = true
        }
        else{
            btn_Done.isUserInteractionEnabled = false
        }
        
    }
}


extension ResetPasswordVC:UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == self.textfield_Otp
        {
            self.textfield_Password.becomeFirstResponder()
        }
        
        if textField ==  self.textfield_Password {
            self.textfield_ConfirmPassword.becomeFirstResponder()
        }
            
        else  if textField == self.textfield_ConfirmPassword {
            self.textfield_ConfirmPassword.resignFirstResponder()
        }
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == textfield_Otp {
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
                btn_Done.isUserInteractionEnabled = true
                return string.length <= 6
            }
            else{
                btn_Done.isUserInteractionEnabled = false
                return string.length <= 6
            }
        }
            
        else {
            let string: NSString = (textField.text! as NSString).replacingCharacters(in: range, with: string) as NSString
            if (string.length > 0) {
                btn_Done.isUserInteractionEnabled = true
                return string.length <= 15
            }
            else{
                btn_Done.isUserInteractionEnabled = false
                return string.length <= 15
            }
        }
    }
}

