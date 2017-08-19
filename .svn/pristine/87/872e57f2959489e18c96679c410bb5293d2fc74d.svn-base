//
//  ForgotPasswordByPhone.swift
//  Shadow
//
//  Created by Sahil Arora on 6/5/17.
//  Copyright © 2017 Atinderjit Kaur. All rights reserved.
//

import UIKit

class ForgotPasswordByPhone: UIViewController {

    
    @IBOutlet var textfield_CountryCode: UITextField!
    @IBOutlet var btn_Send: UIButton!
    @IBOutlet var textfield_Phone: UITextField!
    @IBOutlet var view_PickerView: UIView!
    
    fileprivate var userId:String?
    fileprivate var emailOtp:String?
    
    @IBOutlet var textfield_phone: UITextField!
    
    public var countryarr = NSArray()
    public var Code:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    //    self.navigationItem.hidesBackButton = true
        
        self.SetButtonCustomAttributes(btn_Send)
        
        //setting country code of current country
        let countryLocale : NSLocale =  NSLocale.current as NSLocale
        let countryCode  = countryLocale.object(forKey: NSLocale.Key.countryCode)
        let country = countryLocale.displayName(forKey: NSLocale.Key.countryCode, value: countryCode!)
        
        countryarr = Global.sharedInstance.countryCode()
        let predicate = NSPredicate(format:"name = %@", country!)
        let mArr = countryarr.filtered(using: predicate)
        if(mArr.count > 0) {
            let dictionary = mArr[0] as! NSDictionary
            let code = "+" + (dictionary["code"]as? String)!
            textfield_CountryCode.text = code
        }
     
        
        textfield_Phone.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControlEvents.editingChanged)
        
        
    }
    func textFieldDidChange(textField:UITextField)
    {
        print(textField.text!)
        if  textfield_Phone.text != ""  && self.isPhoneNumberLength(textfield_Phone.text!)
        {
            
            SetButtonCustomAttributesPurple(btn_Send)
        }
        else {
            
            SetButtonCustomAttributes(btn_Send)
        }
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let myBackButton:UIButton = UIButton()
        myBackButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        myBackButton.setImage(UIImage(named:"backpurple"), for: UIControlState())
        myBackButton.addTarget(self, action: #selector(self.PopToRootViewController), for: UIControlEvents.touchUpInside)
        let leftBackBarButton:UIBarButtonItem = UIBarButtonItem(customView: myBackButton)
        self.navigationItem.leftBarButtonItem = leftBackBarButton
        add_padding(textfield: textfield_CountryCode)
        add_padding(textfield: textfield_Phone)


        Validations()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       
            self.view.endEditing(true)
         view_PickerView.isHidden = true
    }
    //Validations
    fileprivate func Validations()
    {
        if textfield_Phone.text != "" && textfield_CountryCode.text != ""
        {
            btn_Send.isUserInteractionEnabled = true
           // Action_Send(btn_Send)
        }
        else
        {
            btn_Send.isUserInteractionEnabled = false
        }
    }
    
    //API for forget password
    func Api_toGetOtpOnPhonenumber() {
        
        let dict = NSMutableDictionary()
        dict.setValue(textfield_Phone.text, forKey: Global.macros.kMobileNumber)
        dict.setValue(textfield_CountryCode.text, forKey: Global.macros.kCountryCode)
        
        
        if self.checkInternetConnection()
        {
            if self.isPhoneNumberLength(textfield_Phone.text!)
            {
                DispatchQueue.main.async {
                    self.pleaseWait()
                }
                
                AuthenticationAPI.sharedInstance.ResendOtpPhoneNumber(dict: dict, completion: {(response) in
                    switch response.0{
                        
                    case 200:
                        
                        self.userId = "\((response.1).value(forKey: "userId")!)"
                        self.emailOtp = "\((response.1).value(forKey: "phoneOtp")!)"
                        SavedPreferences.set((response.1).value(forKey: "userId") , forKey: Global.macros.kUserId)
                        DispatchQueue.main.async {
                            
                            self.performSegue(withIdentifier: "PhoneToOTP", sender: self)
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
                self.showAlert(Message: Global.macros.KInvalidPhoneNumber, vc: self)

            }
            
        }
        else
        {
            self.showAlert(Message: Global.macros.kInternetConnection, vc: self)

        }
        
        
        
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "PhoneToOTP"{
            
            let vc =  segue.destination as! ResetPasswordVC
            vc.user_id = self.userId
            vc.otp = self.emailOtp
        }
    }

    
    
    //MARK: Button Actions
    
    @IBAction func Action_TryEmail(_ sender: UIButton) {
        let array = self.navigationController?.viewControllers
        print(array!)
        if (array?.count)! > 2
        {
         _ = self.navigationController?.popViewController(animated: true)
        }
        else
        {
            let vc = Global.macros.Storyboard.instantiateViewController(withIdentifier: "ForgotEmail")as! ForgotPasswordByEmail
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    @IBAction func Action_Send(_ sender: UIButton) {
        
        if self.checkInternetConnection()
        {
            
             Api_toGetOtpOnPhonenumber()              //API To send otp
               //
            
            
        }
        else
        {
            self.showAlert(Message: Global.macros.kInternetConnection, vc: self)

        }
        
  
        
    }
    @IBAction func Action_CancelPicker(_ sender: UIButton) {
    
        view_PickerView.isHidden = true
        
    }

    @IBAction func Action_SelectCOuntryCode(_ sender: UIButton) {
        
        view_PickerView.isHidden = false
        Code = "+" +  (((countryarr[0] as! NSDictionary).value(forKey: "code")as? String)!).replacingOccurrences(of: "-", with: "")
        textfield_CountryCode.text = ""

        textfield_CountryCode.text = Code
    }
    @IBAction func Action_DonePicker(_ sender: UIButton) {
        textfield_CountryCode.text = Code
        view_PickerView.isHidden = true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
extension ForgotPasswordByPhone:UIPickerViewDelegate,UIPickerViewDataSource{
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        
        return countryarr.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let str = (countryarr[row] as! NSDictionary).value(forKey: "name")as! String
        let codeStr = "+" +  (((countryarr[row] as! NSDictionary).value(forKey: "code")as? String)!).replacingOccurrences(of: "-", with: "")
   
        return codeStr + ", " + str
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        Code = "+" +  (((countryarr[row] as! NSDictionary).value(forKey: "code")as? String)!).replacingOccurrences(of: "-", with: "")
        textfield_CountryCode.text = Code

        
    }
    
}
extension ForgotPasswordByPhone:UITextFieldDelegate
{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
       // textField.text?.capitalizeFirstLetter()
        
        let string: NSString = (textField.text! as NSString).replacingCharacters(in: range, with: string) as NSString
        
        
        if string.length > 0 {
            
            if string.hasPrefix(" ") {
                return false
            }
            else if string.hasSuffix(" ") {
                return false
            }
                
            else if string.contains(" ") {
                return false
            }
            btn_Send.isUserInteractionEnabled = true
            
            return string.length <= 12
        }
            
        else{
            btn_Send.isUserInteractionEnabled = false
            return string.length <= 12
        }
        
    }
    
    
}
