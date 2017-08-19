//
//  SignUpViewController+Validations.swift
//
//
//  Created by Atinderjit Kaur on 29/05/17.
//  Copyright © 2016 Sahil Arora. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController
{
    
       
    
    
    /**
     checkInternetConnection is used to check internet connection wether in working state or not.
     
     :return: Bool returns true if connected to internet else false.
     */
    
    func checkInternetConnection() -> Bool {
        // To check internet connection.
        var isInternetActive: Bool!
        var internetConnectionReach: Reachability!
        
        internetConnectionReach = Reachability.reachabilityForInternetConnection()
        
        var netStatus: Reachability.NetworkStatus!
        
        netStatus = internetConnectionReach.currentReachabilityStatus
        
        if(netStatus == Reachability.NetworkStatus.notReachable) {
            isInternetActive = false;
            return isInternetActive
        }
        else {
            isInternetActive = true
            return isInternetActive
        }
    }
    
    
    /**
     verifyUrl will verify the url.
     
     :return: Bool returns true if url is valid else false.
     */
    
    func verifyUrl (urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url  = NSURL(string: urlString) {
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
    
    
    
    
    /**
     This method is used to check whether password and confirm password is same or not.
     
     :param: contains Password text
     :param: contains confirm Password text
     
     :return: true if it is equal , else false
     */
    
    func isPasswordSame(Password:String,ConfirmPassword:String)-> Bool
    {
        if Password == ConfirmPassword
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    /**
     This method is used to check the count password's characters.
     
     :param: contains Password text
     
     :return: true if it is equal , else false
     */
    
    func isPasswordLength(password: String) -> Bool {
        if password.characters.count < 6{


            return false
        }
        else{
            
            return true
        }
    }
    
    /**
     isValidEmail is used to check wether an email is a valid email or not.
     
     :param: Text contains email which is to be validated.
     
     :return: Bool returns true if connected to internet else false.
     */
    
    func isValidEmail(_ Text:String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        if emailTest.evaluate(with: Text)
        {
         return emailTest.evaluate(with: Text)
        }
        else{
            return false
        }
        
    }
    
    /**
     isPhoneNumberLength is used to check the length of the contct number.
     
     :param: Text contains phone number which is to be checked.
     
     :return: Bool returns true if connected to internet else false.
     */
    
    func isPhoneNumberLength(_ text:String)-> Bool   {
        
        let numberString = "0123456789"
        let numberSet = CharacterSet(charactersIn: numberString)
        
    if text.characters.count < 10 || text.characters.count > 12 {
 
       return false
    }
    else
    {
        if text.rangeOfCharacter(from: numberSet) != nil
        {
            if text.hasPrefix("0")
            {
                return false
            }
            else
            {
             return true
            }
            
        }
        else
        {
            self.showAlert(Message: "Please enter valid phone number", vc: self)
            return false
        }
        
        
    }
}
    /**
     This method is used to scroll up the textfield when keyboard appears on the screen
     :param: concerned textfield
     :param: Bool value 
     
     */
    func animateTextField(textField: UITextField, up: Bool, movementDistance:CGFloat,scrollView:UIScrollView)
    {

        var movement:CGFloat = 0
        if up
        {
            movement = movementDistance
        }
        else
        {
            movement = 0
        }
        scrollView.contentOffset = CGPoint(x: 0, y: movement)

    }
    
    
    //for textview
    func animateTextView(textView: UITextView, up: Bool, movementDistance:CGFloat,scrollView:UIScrollView)
    {
        
        var movement:CGFloat = 0
        if up
        {
            movement = movementDistance
        }
        else
        {
            movement = 0
        }
        scrollView.contentOffset = CGPoint(x: 0, y: movement)
        
    }
    
    
    
    /**
     This method is used to present custom back button on navigation bar
     :param:  viewcontroller on which we want to present custom back bar button.
     */
    func CreateNavigationBackBarButton()
    {
        let myBackButton:UIButton = UIButton()
        myBackButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        myBackButton.setImage(UIImage(named:"back-new"), for: UIControlState())
        myBackButton.addTarget(self, action: #selector(self.PopToRootViewController), for: UIControlEvents.touchUpInside)
        let leftBackBarButton:UIBarButtonItem = UIBarButtonItem(customView: myBackButton)
        self.navigationItem.leftBarButtonItem = leftBackBarButton

    }
    
  
    
    /**
     This method is the called when Custom back button is pressed.
     
     */
    func PopToRootViewController()
    {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    

    
    
    /**
     isPhoneNumberLength is used to check the length of the contct number.
     
     :param: Text contains phone number which is to be checked.
     
     :return: Bool returns true if connected to internet else false.
     */
    
    func isZipCodeLength(_ text:String)-> Bool   {
        if text.characters.count < 6 || text.characters.count > 3 {
            
            return true
        }
        else{
            return false
        }
    }
}

extension NSObject{

    /**
     This method is used to create custom alert.
     :param:  text contains message to display on alert.
     :param:  viewcontroller on which we want to presen alert.
     */
func showAlert(Message:String , vc:UIViewController)
    {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "SBVRSL", message: Message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
           
            alert.view.backgroundColor = UIColor.white
            alert.view.tintColor = UIColor.black
            
            
                vc.present(alert, animated: true, completion: nil)
            
        }
    
    
    }
    

    
    
      func setRootViewtotabbar(_ identifier:String) {
        
        let chooseCVC = Global.macros.Storyboard.instantiateViewController(withIdentifier: identifier)
        let kappdelegate = UIApplication.shared.delegate // a shortcut to get Appdelegate reference.
        // Because self.window is an optional you should check it's value first and assign your rootViewController
        if let window = kappdelegate?.window {
            window!.rootViewController = chooseCVC
        }
        
    }
    
    func getCurrentDateTime(dateStr:String)-> String
    {
      
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.init(name: "UTC") as TimeZone!
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = NSLocale.init(localeIdentifier: "en_US_POSIX") as Locale!
        
        let date = dateFormatter.date(from: dateStr)
        
        let timeZone = NSTimeZone.init(abbreviation: "UTC")
        let systemTimeZone = NSTimeZone.system
        
        let utcTimeZoneOffset = timeZone?.secondsFromGMT(for: date!)
        let systemTimeZoneOffset = systemTimeZone.secondsFromGMT(for: date!)
        
        let timeInterval = systemTimeZoneOffset - utcTimeZoneOffset!
        
        let newDate = NSDate.init(timeInterval: TimeInterval(timeInterval), since: date!)
        
        let newDateFormatter = DateFormatter()
        newDateFormatter.timeZone = NSTimeZone.init(name: "UTC") as TimeZone!
        newDateFormatter.dateFormat = "hh:mm a"
        newDateFormatter.locale = NSLocale.init(localeIdentifier: "en_US_POSIX") as Locale!
        return newDateFormatter.string(from: newDate as Date)
        
    }
 
}

class InsetLabel: UILabel {
    override func drawText(in rect: CGRect) {
        super.drawText(in: UIEdgeInsetsInsetRect(rect, UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)))
    }
}
extension String {
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSFontAttributeName: font]
        let size = self.size(attributes: fontAttributes)
        return size.width
    }
    func heightOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSFontAttributeName: font]
        let size = self.size(attributes: fontAttributes)
        return size.height
    }
    
    func capitalizingFirstLetter() -> String {
        let first = String(characters.prefix(1)).capitalized
        let other = String(characters.dropFirst())
        return first + other
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}


