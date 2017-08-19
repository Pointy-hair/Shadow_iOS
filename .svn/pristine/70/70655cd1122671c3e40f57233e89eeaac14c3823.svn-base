//
//  AuthenticationAPI.swift
//  Shadow
//
//  Created by Sahil Arora on 6/1/17.
//  Copyright © 2017 Atinderjit Kaur. All rights reserved.
//

import UIKit

public var SavedPreferences = UserDefaults.standard


class AuthenticationAPI: NSObject {
    typealias completionBlock = (_ status:NSNumber)->Void
    typealias completionHandler = (_ status:NSNumber,_ dictionary:NSDictionary)-> Void
    typealias ErrorBlock = (NSError?)->Void
    
    static let sharedInstance = AuthenticationAPI()
    
    //API To check availability of Username
    
    
    func CheckAvailabilityOfUsername(dict:NSMutableDictionary,completion:@escaping completionBlock,errorBlock:@escaping ErrorBlock)
    {
        ServerCall.sharedInstance.postService({(response) in
            
           let status = (response as! NSDictionary).value(forKey: Global.macros.KStatus) as? NSNumber
            
            completion(status!)
            
        }, error_block: {(err) in
            
            errorBlock(err)
            
            clearAllNotice()
            
        }, paramDict: dict, is_synchronous: false, url: "checkAvailabilityOfEmail")
     
    }
    
    func CheckAvailabilityOfCampanyname(dict:NSMutableDictionary,completion:@escaping completionBlock,errorBlock:@escaping ErrorBlock)
    {
        ServerCall.sharedInstance.postService({(response) in
            
            let status = (response as! NSDictionary).value(forKey: Global.macros.KStatus) as? NSNumber
            
            completion(status!)
            
        }, error_block: {(err) in
            
            errorBlock(err)
            clearAllNotice()

            
        }, paramDict: dict, is_synchronous: false, url: "checkAvailablityOfCompany")
        
    }
    
    
   //API To Register
    
    func Register(dict:NSMutableDictionary,completion:@escaping completionBlock,errorBlock:@escaping ErrorBlock)
    {
     
        ServerCall.sharedInstance.postService({(response) in
            
            let status = (response as! NSDictionary).value(forKey: Global.macros.KStatus)as? NSNumber
            if status == 200
            {
                let tempDict = (response as! NSDictionary).value(forKey: "data")as! NSDictionary
                self.SaveDataToUserDefaults(dict: tempDict.value(forKey: "user") as! NSDictionary)
                
            } 
            completion(status!)
            
        }, error_block: {(error) in
            
            clearAllNotice()

            errorBlock(error!)
            
        }, paramDict: dict, is_synchronous: false, url: "signUp")
        
        
        
    }
    
   //APT To Verify Otp
    
    func VerifyOTP(dict:NSMutableDictionary,completion:@escaping completionBlock,errorBlock:@escaping ErrorBlock){
        
        ServerCall.sharedInstance.postService({(response) in
            
            let status = (response as! NSDictionary).value(forKey: Global.macros.KStatus)as? NSNumber
            
            completion(status!)
            
        }, error_block: {(err) in
            
            errorBlock(err)
            clearAllNotice()

            
        }, paramDict: dict, is_synchronous: false, url: "verifyEmailOtp")
    }
    
    //API To Verify Otp with phone number
    
    func VerifyOTPPhoneNumber(dict:NSMutableDictionary,completion:@escaping completionBlock,errorBlock:@escaping ErrorBlock){
        
        ServerCall.sharedInstance.postService({(response) in
            
            let status = (response as! NSDictionary).value(forKey: Global.macros.KStatus)as? NSNumber
            
            completion(status!)
            
        }, error_block: {(err) in
            
            errorBlock(err)
            clearAllNotice()

            
        }, paramDict: dict, is_synchronous: false, url: "verifyPhoneOtp")
        
        
    }
    
  //API To Login
    
    
    func Login(dict:NSMutableDictionary,completion:@escaping completionHandler,errorBlock:@escaping ErrorBlock)
    {
        
        ServerCall.sharedInstance.postService({(response) in
            let status = (response as! NSDictionary).value(forKey: Global.macros.KStatus)as! NSNumber
            let message = (response as! NSDictionary).value(forKey: "message")as! String
            str_messageInWrongCeredentials = message

            if status == 200
            {
                let tempDict = (response as! NSDictionary).value(forKey: "data")as! NSDictionary
                self.SaveDataToUserDefaults(dict: tempDict)
                completion(status,tempDict)
                

            }
            
            else if status == 210 {
                
                let tempDict = (response as! NSDictionary).value(forKey: "data")as! NSDictionary
                
                completion(status,tempDict)
                
            }
            
            else if status == 400 {
                
                completion(status,NSDictionary())

                
            }
            
            
        }, error_block: {(err) in
            
            errorBlock(err)
            clearAllNotice()


        }, paramDict: dict, is_synchronous: false, url: "login")
        
        
    }
    
    //API To resend OTP Email
    
    func ResendOtp(dict:NSMutableDictionary,completion:@escaping completionHandler,errorBlock:@escaping ErrorBlock)
    {
        
        ServerCall.sharedInstance.postService({(response) in
            
            let status = (response as! NSDictionary).value(forKey: Global.macros.KStatus)as? NSNumber
            
            if status == 200
            {
                let tempDict = (response as! NSDictionary).value(forKey: "data")as! NSDictionary
                
                completion(status!,tempDict)
            }
            else
            {
                completion(status!,NSDictionary())
            }
            
            
            
        }, error_block: {(err) in
            
            errorBlock(err)
            clearAllNotice()

            
        }, paramDict: dict, is_synchronous: false, url: "resendEmailOtp")
        
    }

   //API To Log Out
    
    func LogOut(dict:NSMutableDictionary,completion:@escaping completionBlock, errorBlock:@escaping ErrorBlock)
    {
        
        
        ServerCall.sharedInstance.postService({(response) in
            
            
            let status = (response as! NSDictionary).value(forKey: Global.macros.KStatus)as! NSNumber
                completion(status)
            
            
        }, error_block: {(err) in
            
            errorBlock(err)
            clearAllNotice()

            
        }, paramDict: dict, is_synchronous: false, url: "")
        
    }
    
    
    //API To resend OTP Phone
    
    func ResendOtpPhone(dict:NSMutableDictionary,completion:@escaping completionHandler,errorBlock:@escaping ErrorBlock)
    {
        
        ServerCall.sharedInstance.postService({(response) in
            
            let status = (response as! NSDictionary).value(forKey: Global.macros.KStatus)as? NSNumber
            
            if status == 200
            {
                let tempDict = (response as! NSDictionary).value(forKey: "data")as! NSDictionary
                
                completion(status!,tempDict)
            }
            else
            {
                completion(status!,NSDictionary())
            }
            
            
            
        }, error_block: {(err) in
            
            errorBlock(err)
            clearAllNotice()

            
        }, paramDict: dict, is_synchronous: false, url: "resendPhoneOtp")
        
    }

    
    //API To resend OTP
    
    func ResendOtpPhoneNumber(dict:NSMutableDictionary,completion:@escaping completionHandler,errorBlock:@escaping ErrorBlock)
    {
        
        ServerCall.sharedInstance.postService({(response) in
            
            let status = (response as! NSDictionary).value(forKey: Global.macros.KStatus)as? NSNumber
            
            if status == 200
            {
                let tempDict = (response as! NSDictionary).value(forKey: "data")as! NSDictionary
                
                completion(status!,tempDict)
            }
            else
            {
                completion(status!,NSDictionary())
            }
            
            
            
        }, error_block: {(err) in
            
            errorBlock(err)
            clearAllNotice()

        }, paramDict: dict, is_synchronous: false, url: "resendPhoneOtp")
        
    }
    
    

    //API To resend OTP
    
    func ForgetPassword(dict:NSMutableDictionary,completion:@escaping completionBlock,errorBlock:@escaping ErrorBlock)
    {
        
        ServerCall.sharedInstance.postService({(response) in
            
            let status = (response as! NSDictionary).value(forKey: Global.macros.KStatus)as? NSNumber
            completion(status!)
            
            
        }, error_block: {(err) in
            
            errorBlock(err)
            clearAllNotice()

            
        }, paramDict: dict, is_synchronous: false, url: "forgotPassword")
        
    }
    

    //API FOR EDIT PROFILE 
    func editProfile(dict:NSMutableDictionary,completion:@escaping completionBlock,errorBlock:@escaping ErrorBlock){
        
        ServerCall.sharedInstance.postService({(response) in
            
            let status = (response as! NSDictionary).value(forKey: Global.macros.KStatus)as? NSNumber
            
            completion(status!)
            
        }, error_block: {(err) in
            
            errorBlock(err)
            clearAllNotice()
        }, paramDict: dict, is_synchronous: false, url: "editProfile")
        
        
    }

    //Get all schools which are available
    //API To Login
    
    
    func AvailableSchools(dict:NSMutableDictionary,completion:@escaping completionHandler,errorBlock:@escaping ErrorBlock)
    {
        
        ServerCall.sharedInstance.postService({(response) in
            let status = (response as! NSDictionary).value(forKey: Global.macros.KStatus)as! NSNumber
            
            if status == 200
            {
                let tempDict = (response as! NSDictionary).value(forKey: "data")as! NSDictionary
                completion(status,tempDict)
               
            }
                
            else if status == 210 {
                
                let tempDict = (response as! NSDictionary).value(forKey: "data")as! NSDictionary
                completion(status,tempDict)
            }
                
            else if status == 400 {
                completion(status,NSDictionary())
            }
            
            
        }, error_block: {(err) in
            
            errorBlock(err)
            clearAllNotice()
  
        }, paramDict: dict, is_synchronous: false, url: "getAvailableSchoolList")
    }

   
    
    //Method to Save data to UserDefaults
    
    func SaveDataToUserDefaults(dict:NSDictionary)
    {
        let userId = dict.value(forKey: "userId") as! NSNumber
        let userName = "\(dict.value(forKey: "Username"))"
        
        let role = dict.value(forKey: "role")as! String
        let firstname = dict.value(forKey: "firstName")as! String
        let lastname = dict.value(forKey: "lastName")as! String
        let email = dict.value(forKey: "email")as? String
        let school = dict.value(forKey: "schoolName") as? String
        let company = dict.value(forKey: "companyName")as! String
        let session = dict.value(forKey: "sessionToken")as! String
        let mobileNumber = dict.value(forKey: "mobileNumber")as? String

        SavedPreferences.set(mobileNumber, forKey: "mobileNumber")
        SavedPreferences.set(userId, forKey: Global.macros.kUserId)
        SavedPreferences.setValue(session, forKey: "sessionToken")
        SavedPreferences.set(role, forKey: "role")
        SavedPreferences.set(firstname, forKey: "firstname")
        SavedPreferences.set(lastname, forKey: "lastname")
        SavedPreferences.set(email, forKey: "email")
        SavedPreferences.set(role, forKey: "role")
        SavedPreferences.set(userName, forKey: Global.macros.kUserName)
        SavedPreferences.set(school, forKey: "schoolName")
        SavedPreferences.set(company, forKey: "companyName")
    }
    
}
