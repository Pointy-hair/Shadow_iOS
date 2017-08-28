//
//  Notification_API.swift
//  Shadow
//
//  Created by Aditi on 28/08/17.
//  Copyright © 2017 Atinderjit Kaur. All rights reserved.
//

import UIKit

class Notification_API: NSObject {

    
    static let sharedInstance = Notification_API()
    typealias CompletionBlockDict = (_ status:NSDictionary) -> Void
    typealias ErrorBlock = (NSError?)->Void

    func retrieveNotifications(dict:NSMutableDictionary,completionBlock:@escaping CompletionBlockDict,errorBlock:@escaping ErrorBlock)  {
        
        
        ServerCall.sharedInstance.postService({ (response) in
            
            let dictionary_info = response as! NSDictionary
            completionBlock(dictionary_info)
            
        }, error_block: {(error) in
            errorBlock(error)
        
        
        }, paramDict: dict, is_synchronous: false, url: "getAllNotification")
        

    }
    
    
    func clearNotifications(dict:NSMutableDictionary,completionBlock:@escaping CompletionBlockDict,errorBlock:@escaping ErrorBlock)  {
        
        
        ServerCall.sharedInstance.postService({ (response) in
            
            let dictionary_info = response as! NSDictionary
            completionBlock(dictionary_info)
            
        }, error_block: {(error) in
            errorBlock(error)
            
            
        }, paramDict: dict, is_synchronous: false, url: "clearNotification")
        
        
    }
     
    
}
