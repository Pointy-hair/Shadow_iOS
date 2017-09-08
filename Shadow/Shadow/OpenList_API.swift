//
//  OpenList_API.swift
//  Shadow
//
//  Created by Aditi on 08/09/17.
//  Copyright © 2017 Atinderjit Kaur. All rights reserved.
//

import UIKit

class OpenList_API: NSObject {

    static let sharedInstance = OpenList_API()
    typealias completionHandler = (_ status:NSNumber,_ dictionary:NSDictionary)-> Void
    typealias ErrorBlock = (NSError?)->Void
    
    func getListOfUsers(completion_block:@escaping completionHandler,error_block:@escaping ErrorBlock,dict:NSMutableDictionary) {
        
        ServerCall.sharedInstance.postService({ (response) in
            
            let status = (response as! NSDictionary).value(forKey: "status") as? NSNumber
            if status == 200
            {
                let dict_Info = ((response as! NSDictionary).value(forKey: "data") as? NSDictionary)?.mutableCopy() as! NSMutableDictionary
                completion_block(status!,dict_Info)
            }
            else
            {
                completion_block(status!,[:])
            }
        }, error_block: {
            (error) in
            
            error_block(error)
            
        }, paramDict: dict, is_synchronous: false, url: "getSubDetailListOfUser")
        
        
    }
    
    
}
