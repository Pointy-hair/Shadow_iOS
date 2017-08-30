//
//  Requests_API.swift
//  Shadow
//
//  Created by Aditi on 29/08/17.
//  Copyright © 2017 Atinderjit Kaur. All rights reserved.
//

import Foundation

class Requests_API: NSObject {
    
    static let sharedInstance = Requests_API()
    
    typealias completionHandler = (_ status:NSNumber,_ dictionary:NSDictionary)-> Void
    typealias completion_Handler = (_ status:NSNumber,_ array:NSArray)-> Void

    typealias ErrorBlock = (NSError?)->Void


    
    func sendRequest(completionBlock:@escaping completionHandler,errorBlock:@escaping ErrorBlock,dict:NSMutableDictionary)  {
        
        ServerCall.sharedInstance.postService({ (response) in
            
            let status = (response as! NSDictionary).value(forKey: "status") as? NSNumber
            if status == 200
            {
                let dict_Info = ((response as! NSDictionary).value(forKey: "data") as? NSDictionary)?.mutableCopy() as! NSMutableDictionary
                completionBlock(status!,dict_Info)
            }
            else
            {
                completionBlock(status!,[:])

            }
            
        }, error_block: {(err) in
            
            errorBlock(err)
        }, paramDict: dict, is_synchronous: false, url: "sendRequest")
        
    }
    
    func getRequestByType(completionBlock:@escaping completion_Handler,errorBlock:@escaping ErrorBlock,dict:NSMutableDictionary)  {
        
        ServerCall.sharedInstance.postService({ (response) in
            
            let status = (response as! NSDictionary).value(forKey: "status") as? NSNumber
            if status == 200
            {
                let array_Info = ((response as! NSDictionary).value(forKey: "data") as! NSArray).mutableCopy() as! NSMutableArray
                completionBlock(status!,array_Info)
            }
            else
            {
                completionBlock(status!,[])
                
            }
            
        }, error_block: {(err) in
            
            errorBlock(err)
        }, paramDict: dict, is_synchronous: false, url: "getRequestByType")
    }
    
    func deleteRequests(completionBlock:@escaping completionHandler,errorBlock:@escaping ErrorBlock,dict:NSMutableDictionary)  {
        
        ServerCall.sharedInstance.postService({ (response) in
            
            let status = (response as! NSDictionary).value(forKey: "status") as? NSNumber
            if status == 200
            {
                let dict_Info = ((response as! NSDictionary).value(forKey: "data") as? NSDictionary)?.mutableCopy() as! NSMutableDictionary
                completionBlock(status!,dict_Info)
            }
            else
            {
                completionBlock(status!,[:])
                
            }
            
        }, error_block: {(err) in
            
            errorBlock(err)
        }, paramDict: dict, is_synchronous: false, url: "")
    }
    
    
    func requestAcceptReject(completionBlock:@escaping completionHandler,errorBlock:@escaping ErrorBlock,dict:NSMutableDictionary){
        
        ServerCall.sharedInstance.postService({ (response) in
            
            let status = (response as! NSDictionary).value(forKey: "status") as? NSNumber
            if status == 200
            {
                let dict_Info = ((response as! NSDictionary).value(forKey: "data") as? NSDictionary)?.mutableCopy() as! NSMutableDictionary
                completionBlock(status!,dict_Info)
            }
            else
            {
                completionBlock(status!,[:])
                
            }
            
        }, error_block: {(err) in
            
            errorBlock(err)
            
        }, paramDict: dict, is_synchronous: false, url:"acceptRejectRequest")
        
    }
    
    
    
    func viewRequest(completionBlock:@escaping completionHandler,errorBlock:@escaping ErrorBlock,dictionary:NSMutableDictionary)  {
        
          ServerCall.sharedInstance.postService({ (response) in
            
            let status = (response as! NSDictionary).value(forKey: "status") as? NSNumber
            if status == 200
            {
                let dict_Info = ((response as! NSDictionary).value(forKey: "data") as? NSDictionary)?.mutableCopy() as! NSMutableDictionary
                completionBlock(status!,dict_Info)
            }
            else
            {
                completionBlock(status!,[:])
                
            }
            
          }, error_block: {
            (error) in
            
            errorBlock(error)
            
          }, paramDict: dictionary, is_synchronous: false, url: "viewRequest")
     }
    
    
}
    
