//
//  EnterPasswordViewController.swift
//  Shadow
//
//  Created by Atinderjit Kaur on 31/05/17.
//  Copyright © 2017 Atinderjit Kaur. All rights reserved.
//

import UIKit

class EnterPasswordViewController: UIViewController {

    @IBOutlet weak var btn_Next: UIButton!
    @IBOutlet weak var textfield_ConfirmPassword: UITextField!
    @IBOutlet weak var textfield_Password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        
     //   self.navigationItem.hidesBackButton = true //Hide default back button
        let myBackButton:UIButton = UIButton()
        myBackButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        myBackButton.setImage(UIImage(named:"backpurple"), for: UIControlState())
        myBackButton.addTarget(self, action: #selector(self.PopToRootViewController), for: UIControlEvents.touchUpInside)
        let leftBackBarButton:UIBarButtonItem = UIBarButtonItem(customView: myBackButton)
        self.navigationItem.leftBarButtonItem = leftBackBarButton
        
        self.SetButtonCustomAttributes(btn_Next)
        
        textfield_Password.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControlEvents.editingChanged)
        
        textfield_ConfirmPassword.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControlEvents.editingChanged)
        
    }
    func textFieldDidChange(textField:UITextField)
    {
        if textfield_Password.text != "" && textfield_ConfirmPassword.text != "" && self.isPasswordLength(password: textfield_Password.text!) &&  self.isPasswordSame(Password: textfield_Password.text!, ConfirmPassword: textfield_ConfirmPassword.text!)
        {
            SetButtonCustomAttributesPurple(btn_Next)
            
        }
        else
        {
            SetButtonCustomAttributes(btn_Next)

        }
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        add_padding(textfield: textfield_Password)
        add_padding(textfield: textfield_ConfirmPassword)       //To set user interaction of next button
        //To set user interaction of next button
      Validation()
        
    }
  
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
        
    
    
    fileprivate func Validation()
    {
        if textfield_Password.text != "" && textfield_ConfirmPassword.text != "" && self.isPasswordLength(password: textfield_Password.text!)
        {
            btn_Next.isUserInteractionEnabled = true

        }
        else
        {
            btn_Next.isUserInteractionEnabled = false
        }
    }
    
    
    
    //MARK:- Button Actions
    
    @IBAction func Action_Next(_ sender: UIButton) {
        
        if textfield_Password.text != ""
        {
            if textfield_ConfirmPassword.text != "" {
                
                if self.isPasswordLength(password: textfield_ConfirmPassword.text!) {
        
        if self.checkInternetConnection()
        {
            if self.isPasswordSame(Password: textfield_Password.text!, ConfirmPassword: textfield_ConfirmPassword.text!)
            {
                password = textfield_Password.text!
                
                switch registeringAs! {
                case "USER":
                    self.performSegue(withIdentifier: "PasswordToFirstname", sender: self)
                case "COMPANY":
                    self.performSegue(withIdentifier: "PasswordToCompany", sender: self)
                case "SCHOOL":
                    self.performSegue(withIdentifier: "PasswordToSchool", sender: self)
                default:
                    break
                }
            }
            else
            {
                self.showAlert(Message: Global.macros.KPasswordMatch, vc: self)

            }
        }
        else
        {
            self.showAlert(Message: Global.macros.kInternetConnection, vc: self)

            
        }
                    
                }
                else {
                    self.showAlert(Message: Global.macros.KPasswordLength, vc: self)

                }
        
    }
        
        else {
                self.showAlert(Message: "Please enter confirm password.", vc: self)

        }
    }
    
    
        else {
            self.showAlert(Message: "Please enter password.", vc: self)

        }
    }

}
extension EnterPasswordViewController:UITextFieldDelegate
{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        
        if textField == textfield_Password
        {
            
            textfield_ConfirmPassword.becomeFirstResponder()
        }
        else
        {
            textfield_ConfirmPassword.resignFirstResponder()
            
        }
        return true
        
    }
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        let string: NSString = (textField.text! as NSString).replacingCharacters(in: range, with: string) as NSString
            
        
            if (string.length > 0) {
                btn_Next.isUserInteractionEnabled = true

                return string.length <= 15
            }
        
            else{
                btn_Next.isUserInteractionEnabled = false
                return string.length <= 15

            }
    }
}



    
    
    

