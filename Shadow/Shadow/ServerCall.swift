
//
//  Common.swift
//  ShootEmUp
//
//  Created by Sahil Arora on 07/09/16.
//  Copyright © 2016 Sahil Arora. All rights reserved.
//

import Foundation
import UIKit


/*This class consists all the common methods and variables that has been used in varios classes.It is made so that one can define the properties and methods once and can use them wherever needed instead ofwriting them again and again*/

class ServerCall: NSObject
{
    static let sharedInstance = ServerCall()
    
    //variable for pull to refresh
    var refresh_Control: UIRefreshControl!
    var customView: UIView!
    var labelsArray: Array<UILabel> = []
    var isAnimating = false
    var currentColorIndex = 0
    var currentLabelIndex = 0
    var timer: Timer!
    
   // typealias CompletionBlock = (Any?) -> Void
    typealias CompletionBlock = (AnyObject?) -> Void
    typealias ErrorBlock = (NSError?) -> Void
  

    
}


extension ServerCall: URLSessionDelegate,URLSessionTaskDelegate,URLSessionDataDelegate
{
    //MARK: post & get request
    func postService(_ completion_block:CompletionBlock!, error_block:ErrorBlock!,paramDict:AnyObject?,is_synchronous:Bool!,url:String)
    {
        
        let postDict = paramDict as! NSDictionary
        let request : NSMutableURLRequest! = self.createPostRequest("POST", url_string:url, params:postDict)
        self.makeURLRequest(request as URLRequest!, isSynchronous: is_synchronous, completion_block:
            {
                (responseObject) in
                
                print(responseObject!)
                
                completion_block?(self.parseResponseForSuccessBlock(((responseObject as! NSDictionary).value(forKey: "response"))! as AnyObject, url: (responseObject as! NSDictionary).value(forKey: "requestUrl") as! String))
                return
            },error_block:
            {(responseError) in
                
                error_block(responseError)
                return
        })
           }
    
    
    //  MARK:Parse Api request
    func postUploadService(_ completion_block:CompletionBlock!, error_block:ErrorBlock!,paramDict:AnyObject?,is_synchronous:Bool!,url:String,data:Data)
    {
        let request : NSMutableURLRequest! = self.createPostRequest("POST", url_string:url, params:paramDict)
        request.timeoutInterval = 30

        self.makeURLRequest(request as URLRequest!, isSynchronous: is_synchronous, completion_block:
            {
                (responseObject) in
                
                completion_block?(self.parseResponseForSuccessBlock(((responseObject as! NSDictionary).value(forKey: "response"))! as AnyObject, url: (responseObject as! NSDictionary).value(forKey: "requestUrl") as! String))
                
                return
            },
                            error_block:
            {(responseError) in
                
                error_block(responseError)
                return
        })
        
    }
    
    func parseResponseForSuccessBlock(_ responseDict:AnyObject, url:String)->AnyObject
    {
        var parsedDict = NSDictionary()
        
        if(responseDict.value(forKey: "Response") != nil && ((responseDict.value(forKey: "Response") as Any) is NSDictionary))
        {
            parsedDict = (responseDict.value(forKey: "Response") as AnyObject) as! NSDictionary
        }else{
            return responseDict
        }
        return parsedDict
    }
    
    func parseResponse(_ responseObject: AnyObject) -> (Int,NSDictionary?) {
        
        let statusCode = ((responseObject["response_code"])!! as AnyObject).doubleValue
        
        var responseDict = NSDictionary()
        
        if (statusCode == 1)
        {
            if(responseObject["result"] != nil)
            {
                if(responseObject["result"]!! as AnyObject) is NSDictionary
                {
                    if(responseObject["result"] != nil){
                        
                        responseDict = responseObject["result"] as! NSDictionary
                        
                        //                        if(responseObject["result"] != ""){
                        //                            responseDict = responseObject["result"] as! NSDictionary
                        //                        }
                        
                    }
                    else {
                        
                    }
                    
                }
            }
        }
        else {
            
            if(responseObject["response_message"] != nil && responseObject["response_message"] as? String != "") {
                let dict1 = NSMutableDictionary()
                dict1.setValue(responseObject["response_message"] as? String, forKey: "response_message")
                
                responseDict = dict1 as NSDictionary
            }
        }
        
        return (Int(statusCode!),responseDict)
    }
   
    func btnAnimation(sender:UIButton)
    {
        sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 1.0, delay: 0,usingSpringWithDamping: 0.2,initialSpringVelocity: 2.0, options: .allowUserInteraction, animations: {
            () in
            sender.transform = .identity
            },completion: nil)
    }
    
}

// MARK: URL requests
extension ServerCall
{
    
    /**
     createGetRequest is used to make url request with "GET" method.
     
     :param:  httpMethod It can be "GET" or "POST".
     
     :param:  params The dictionary(keys/values) which needs to be posted.
     
     :param:  url_string It contains the url link which is used to hit service.
     
     :returns: URLRequest returns the created request.
     */
    
    func createGetRequest(_ httpMethod:String, url_string:String,params:String) ->URLRequest{
       
        let urlStr:String = url_string // Your Normal URL String
        
        print(urlStr)
        let NSHipster = URL.init(string: "\(url_string.replacingOccurrences(of: " ", with: ""))")
        //let url:URL! = URL(string: urlStr)// Creating URL
        let request:NSMutableURLRequest = NSMutableURLRequest(url: NSHipster!)// Creating Http Request
        request.httpMethod = httpMethod
        // Creating NSOperationQueue to which the handler block is dispatched when the request completes or failed
        request.timeoutInterval = 30
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(DeviceType, forHTTPHeaderField: "Device-Type")
        request.setValue(deviceTokenString, forHTTPHeaderField: "Device-Token")
        request.setValue("IPHONE_6zJxK4AMDpahM3Yd7xARGPfRhcWbAkcY9dsfhu1sdF", forHTTPHeaderField: "Application-Token")
        request.setValue("IPHONE", forHTTPHeaderField: "Application-Type")
        request.setValue("sdbfkjsdj", forHTTPHeaderField: "Vendor-Token")
        request.timeoutInterval = 30

        return request as URLRequest
    }
    
    
    func createPostRequest(_ httpMethod:String, url_string:String,params:AnyObject!) ->NSMutableURLRequest{
        let url : NSString = "http://115.248.100.76:8013/user/api/"
        let urlStr : NSString = url.appending(url_string) as NSString
        let searchURL : URL = URL(string: urlStr as String)!
        
        let request:NSMutableURLRequest = NSMutableURLRequest(url: searchURL) // Creating Http Request
        request.httpMethod = httpMethod
        
        if (params != nil)
        {
        if params is NSArray
            {
                do {
                    var bodyData:Data!
                    bodyData = try JSONSerialization.data(withJSONObject: params, options: [])
                    request.httpBody = bodyData
                    
                } catch {
                    
                    request.httpBody = nil
                }
            }
            else if params is NSDictionary {
                
                do {
                    var bodyData:Data!
                    bodyData = try JSONSerialization.data(withJSONObject: params, options: [JSONSerialization.WritingOptions(rawValue: 0)])
                    request.httpBody = bodyData
                    
                } catch {
                    
                    request.httpBody = nil
                }
            }
            else if (params is String) {
                let bodyData: String! = params as! String;
                request.httpBody = bodyData.data(using: String.Encoding.utf8);
            }
        }
        request.timeoutInterval = 60
        request.setValue("Keep Alive", forHTTPHeaderField: "Connection")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(DeviceType, forHTTPHeaderField: "Device-Type")
        request.setValue(deviceTokenString, forHTTPHeaderField: "Device-Token")
        request.setValue("IPHONE_6zJxK4AMDpahM3Yd7xARGPfRhcWbAkcY9dsfhu1sdF", forHTTPHeaderField: "Application-Token")
        request.setValue("IPHONE", forHTTPHeaderField: "Application-Type")
        request.setValue("sdbfkjsdj", forHTTPHeaderField: "Vendor-Token")
        request.timeoutInterval = 30

        if SavedPreferences.value(forKey: "sessionToken")as? String != nil{
            request.setValue(SavedPreferences.value(forKey: "sessionToken")as? String, forHTTPHeaderField: "Session-Token")
            
        }
        request.setValue(NSString(format:"%d",(request.httpBody?.count)!) as String, forHTTPHeaderField: "Content-Length")
        
        // Creating NSOperationQueue to which the handler block is dispatched when the request completes or failed
        return request
        
    }
    
    func makeURLRequest(_ request:URLRequest!, isSynchronous:Bool!, completion_block:CompletionBlock!, error_block:ErrorBlock!){
    
        URLSession.shared.dataTask(with: request as URLRequest) {( responseData, response, responseError) in
            
            if(responseError != nil) {
                error_block?(responseError as NSError?)
                return
            }
            
            var jsonResult:Any!
            
            do {
                let finalDict = NSMutableDictionary()
               
                jsonResult = try JSONSerialization.jsonObject(with: responseData!, options: [])as? [String: AnyObject]
                
                print("jsonResult is:\(jsonResult)")
                finalDict.setValue(jsonResult, forKey:"response")
                finalDict.setValue(request.url?.absoluteString, forKey:"requestUrl")
                completion_block?(finalDict)
            }
            catch {
                error_block?(responseError as NSError?)
                DispatchQueue.main.async {
                    
                   clearAllNotice()
                    
                }
                                return
            }
            }.resume()
        
    }
    
    /**
     getService is used to hit service with "GET" method.
     
     :param:  completion_block This is used to notify that service has been completed.
     
     :param:  error_block This is used to notify that an error has occured during the operation.
     
     :param:  paramDict In "GET" service this param is optional.
     
     :param:  is_synchronous A bool variable if "true" service will be hit on main thread otherwise on background.
     
     :param:  url It contains the url link which is used to hit service.
     */
    
    func getService(_ completion_block:CompletionBlock!,error_block:ErrorBlock!,is_synchronous:Bool!,url:String,paramDict:String){
        
        let request : URLRequest! = self.createGetRequest("GET", url_string: url, params:paramDict)

        self.makeURLRequest(request, isSynchronous: is_synchronous, completion_block: {(responseObject) in
            
            completion_block(self.parseResponseForSuccessBlock(responseObject!,url: responseObject?.value(forKey: "requestUrl") as! String))
            
            return
        }, error_block: {(responseError) in
            
            error_block(responseError)
            return
        })
        
    }
}



func clearAllNotice() {
    DispatchQueue.main.async(execute: {
        
        SwiftNotice.clear()
        
    })
    
}

