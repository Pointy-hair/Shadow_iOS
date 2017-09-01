//
//  ProfileAPI.swift
//  Shadow
//
//  Created by Sahil Arora on 6/5/17.
//  Copyright © 2017 Atinderjit Kaur. All rights reserved.
//

import UIKit

class ProfileAPI: NSObject {

    static let sharedInstance = ProfileAPI()
    typealias CompletionBlockDict = (_ status:NSDictionary) -> Void

    typealias completionHandler = (_ status:NSNumber,_ dictionary:NSDictionary)-> Void
     typealias ErrorBlock = (NSError?)->Void
    
    //API To retrieve User Profile
    
    func RetrieveUserProfile(dict:NSMutableDictionary,completion:@escaping completionHandler,errorBlock:@escaping ErrorBlock){
        
        ServerCall.sharedInstance.postService({(response) in
            
            let status = (response as! NSDictionary).value(forKey: Global.macros.KStatus)as? NSNumber
            
            if status == 200
            {
                
            let tempDict = (response as! NSDictionary).value(forKey: "data") as! NSDictionary
                
              completion(status!,tempDict)
            }
            else
            {
             completion(status!,NSDictionary())
            }
      
            
        }, error_block: {(err) in
            
            errorBlock(err)
            clearAllNotice()

            
            
        }, paramDict: dict, is_synchronous: false, url: "getProfile")
        
        
        
    }
    
    
    //API to getting rating information
    
    func RatingInformation(postDict:NSMutableDictionary,completion_Block:@escaping CompletionBlockDict,error_Block:@escaping ErrorBlock) {
        
        ServerCall.sharedInstance.postService({
            (response) in
            //print(response!)
            let status = (response as! NSDictionary).value(forKey: "status") as? NSNumber
            DispatchQueue.main.async {
                
                //  self.clearAllNotice()
                if status == 200{
                    completion_Block(response as! NSDictionary)
                    
                }
                else if status == 301{
                    completion_Block(response as! NSDictionary)
                }
                    
                else if status == 302 {
                    print(response as! NSDictionary)
                    completion_Block(response as! NSDictionary)
                    
                }
            }
            
        }, error_block: {
            (err) in
            error_Block(err)
            print(err as Any)
            clearAllNotice()

            
        }, paramDict: postDict, is_synchronous: true, url: "get-notification-list")
    }

    func addRating(postDict:NSMutableDictionary,completion_Block:@escaping CompletionBlockDict,error_Block:@escaping ErrorBlock) {
        
        ServerCall.sharedInstance.postService({
            (response) in
            //print(response!)
            let status = (response as! NSDictionary).value(forKey: "status") as? NSNumber
            DispatchQueue.main.async {
                
               
                if status == 200{
                    completion_Block(response as! NSDictionary)
                    
                }
                else if status == 301{
                    completion_Block(response as! NSDictionary)
                }
                    
                else if status == 302 {
                    print(response as! NSDictionary)
                    completion_Block(response as! NSDictionary)
                    
                }
            }
            
        }, error_block: {
            (err) in
            error_Block(err)
            print(err as Any)
            clearAllNotice()

            
        }, paramDict: postDict, is_synchronous: true, url: "addUpdateAllTypeOfRatingOrComment")
    }

    
    func getListOfSchools(dict:NSMutableDictionary,completion:@escaping completionHandler,errorBlock:@escaping ErrorBlock)
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
            
        }, paramDict: dict, is_synchronous: false, url: Global.macros.api_getschools)
    }
    
    
    func getListOfCompanies(dict:NSMutableDictionary,completion:@escaping completionHandler,errorBlock:@escaping ErrorBlock)
    {
        
        ServerCall.sharedInstance.postService({(response) in
            let status = (response as! NSDictionary).value(forKey: Global.macros.KStatus)as! NSNumber

            switch status {
                
            case 200:
                let tempDict = (response as! NSDictionary).value(forKey: "data")as! NSDictionary
                completion(status,tempDict)
                break
                
            case 210:
                let tempDict = (response as! NSDictionary).value(forKey: "data")as! NSDictionary
                completion(status,tempDict)

                break
                
            case 400:
                completion(status,NSDictionary())

                break
                
            default:
                completion(status,NSDictionary())

                break
                
            }
            
        }, error_block: {(err) in
            
            errorBlock(err)
            
        }, paramDict: dict, is_synchronous: false, url: Global.macros.api_getAllAvailCompanies)
    }
    
    
    
    
    
    
    
    //Get all data from search
    
    
    func AllSearchData(dict:NSMutableDictionary,completion:@escaping CompletionBlockDict,errorBlock:@escaping ErrorBlock)
    {
        
        ServerCall.sharedInstance.postService({(response) in
            let status = (response as! NSDictionary).value(forKey: Global.macros.KStatus)as! NSNumber
            
            if status == 200
            {
                completion(response as! NSDictionary)

                
                
            }
                
            else if status == 210 {
                
                completion(response as! NSDictionary)

                
            }
                
            else if status == 400 {
                
                completion(response as! NSDictionary)
                
                
            }
            
            
            else if status == 401 {
                
                completion(response as! NSDictionary)
                
                
            }

            
            
        }, error_block: {(err) in
            
            errorBlock(err)
            
            clearAllNotice()

        }, paramDict: dict, is_synchronous: false, url: "searchFilter")
        
        
    }
    
    //Get all data for search as location
    
    
    func AllSearchDataAsLocation(dict:NSMutableDictionary,completion:@escaping CompletionBlockDict,errorBlock:@escaping ErrorBlock)
    {
        
        ServerCall.sharedInstance.postService({(response) in
            let status = (response as! NSDictionary).value(forKey: Global.macros.KStatus)as! NSNumber
            
            if status == 200
            {
                completion(response as! NSDictionary)
                
                
                
            }
                
            else if status == 210 {
                
                completion(response as! NSDictionary)
                
                
            }
                
            else if status == 400 {
                
                completion(response as! NSDictionary)
                
                
            }
            
            else if status == 401 {
                
                completion(response as! NSDictionary)
                
                
            }

            
            
        }, error_block: {(err) in
            
            errorBlock(err)
            clearAllNotice()

            
        }, paramDict: dict, is_synchronous: false, url: "getAllTypeTopRatingListUsingLocation")
        
        
    }

   // getAllTypeTopRatingListbyType
    func getAllTypeTopRatingListbyType(dict:NSMutableDictionary,completion:@escaping CompletionBlockDict,errorBlock:@escaping ErrorBlock)
    {
        
        ServerCall.sharedInstance.postService({(response) in
            let status = (response as! NSDictionary).value(forKey: Global.macros.KStatus)as! NSNumber
            
            if status == 200
            {
                completion(response as! NSDictionary)
                
                
                
            }
                
            else if status == 210 {
                
                completion(response as! NSDictionary)
                
                
            }
                
            else if status == 400 {
                
                completion(response as! NSDictionary)
                
                
            }
            
            else if status == 401 {
                
                completion(response as! NSDictionary)
                
                
            }

            
            
        }, error_block: {(err) in
            
            errorBlock(err)
            clearAllNotice()

            
        }, paramDict: dict, is_synchronous: false, url: "getAllTypeTopRatingListbyType")
        
        
    }
 
    //get all ratings of user
    
    func RatingList(dict:NSMutableDictionary,completion:@escaping CompletionBlockDict,errorBlock:@escaping ErrorBlock)
    {
        
        ServerCall.sharedInstance.postService({(response) in
            let status = (response as! NSDictionary).value(forKey: Global.macros.KStatus)as! NSNumber
            
            if status == 200
            {
                completion(response as! NSDictionary)
                
                
                
            }
                
            else if status == 210 {
                
                completion(response as! NSDictionary)
                
                
            }
                
            else if status == 400 {
                
                completion(response as! NSDictionary)
                
                
            }
            
            
        }, error_block: {(err) in
            
            errorBlock(err)
            clearAllNotice()

            
        }, paramDict: dict, is_synchronous: false, url: "getRatingListbyId")
        
        
    }
    
// Get Occupation Detail by Id
    //Get all data from search
    
    
    func OccupationDetail(dict:NSMutableDictionary,completion:@escaping CompletionBlockDict,errorBlock:@escaping ErrorBlock)
    {
        
        ServerCall.sharedInstance.postService({(response) in
            let status = (response as! NSDictionary).value(forKey: Global.macros.KStatus)as! NSNumber
            
            if status == 200
            {
                completion(response as! NSDictionary)
                
                
                
            }
                
            else if status == 210 {
                
                completion(response as! NSDictionary)
                
                
            }
                
            else if status == 400 {
                
                completion(response as! NSDictionary)
                
                
            }
                
                
            else if status == 401 {
                
                completion(response as! NSDictionary)
                
                
            }
            
            
            
        }, error_block: {(err) in
            
            errorBlock(err)
            
            clearAllNotice()
            
        }, paramDict: dict, is_synchronous: false, url: "getOccupationDetailByOccupationId")
        
        
    }

    
}
