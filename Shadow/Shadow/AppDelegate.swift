//
//  AppDelegate.swift
//  Shadow
//
//  Created by Atinderjit Kaur on 29/05/17.
//  Copyright © 2017 Atinderjit Kaur. All rights reserved.
//

import UIKit
import GooglePlaces
import GooglePlacePicker
import AVFoundation

var deviceTokenString = String()       // Device token string used in login and sign ups

public var DeviceType:String = "0"
public var bool_Backntn : Bool = false
public var bool_PushComingFromAppDelegate : Bool = false

public var str_Confirmation:String = ""

public var myCurrentLat : Double?
public var myCurrentLong : Double?



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,CLLocationManagerDelegate {
    
    var window: UIWindow?
    var locManager = CLLocationManager()
    var currentLocation = CLLocation()
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //Code for push notifications
           application.applicationIconBadgeNumber = 1

        let settings = UIUserNotificationSettings(types: [.alert,.badge,.sound], categories: nil)
        application.registerUserNotificationSettings(settings)
        application.registerForRemoteNotifications()
        

        Global.macros.statusBar.backgroundColor = Global.macros.themeColor_pink
        UIApplication.shared.statusBarStyle = .lightContent

        
        //Sleep for splash
        TestFairy.begin("2813e5e8d4b5b274cbdebb5dfc2f013909665937")
        Thread.sleep(forTimeInterval: 3.0)
        
        GMSServices.provideAPIKey("AIzaSyCywl2nqZ6x_NOMRNSGufIF7RKVe-pgj2w")
        GMSPlacesClient.provideAPIKey("AIzaSyCywl2nqZ6x_NOMRNSGufIF7RKVe-pgj2w")
        
       //My current Location
        locManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locManager.delegate = self
            locManager.desiredAccuracy = kCLLocationAccuracyBest
            locManager.startUpdatingLocation()
        }
        
        if SavedPreferences.value(forKey: "userId")as? NSNumber != nil
        {
            DispatchQueue.main.async {
                let vc = Global.macros.Storyboard.instantiateViewController(withIdentifier: "SWRevealViewController") as!  SWRevealViewController
                Global.macros.kAppDelegate.window?.rootViewController = vc
          }
            
        }
        else
        {
            DispatchQueue.main.async {
                let vc = Global.macros.Storyboard.instantiateViewController(withIdentifier: "Login")
                Global.macros.kAppDelegate.window?.rootViewController = vc
            }
        }
        
        //Audio
//        let audio_Session = AVAudioSession.sharedInstance()
//        if audio_Session.isOtherAudioPlaying{
//            
//            _ = try? audio_Session.setCategory(AVAudioSessionCategoryPlayAndRecord, with: AVAudioSessionCategoryOptions.mixWithOthers)
//            
//        }
        if application.applicationState == .active{
            
            let audio_Session = AVAudioSession.sharedInstance()
                    if audio_Session.isOtherAudioPlaying{
            
                        _ = try? audio_Session.setCategory(AVAudioSessionCategoryAmbient, with: AVAudioSessionCategoryOptions.mixWithOthers)
                        
                    }
            
        }
        
        
        return true
    }
    

    
//    @available(iOS 9.0, *)
//    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey: Any] = [:]) -> Bool {
//        
//        //        if LinkedinSwiftHelper.shouldHandle(url) {
//        //            return LinkedinSwiftHelper.application(app, open: url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
//        //        }
//        
//        return true
//    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        
        let audio_Session = AVAudioSession.sharedInstance()
        if audio_Session.isOtherAudioPlaying{
            
            _ = try? audio_Session.setCategory(AVAudioSessionCategoryAmbient, with: AVAudioSessionCategoryOptions.mixWithOthers)
            
        }
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        
        let audio_Session = AVAudioSession.sharedInstance()
        if audio_Session.isOtherAudioPlaying{
            
            _ = try? audio_Session.setCategory(AVAudioSessionCategoryPlayAndRecord, with: AVAudioSessionCategoryOptions.mixWithOthers)
            
        }
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        
                let audio_Session = AVAudioSession.sharedInstance()
                if audio_Session.isOtherAudioPlaying{
        
                    _ = try? audio_Session.setCategory(AVAudioSessionCategoryPlayAndRecord, with: AVAudioSessionCategoryOptions.mixWithOthers)
                    
                }

        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
        application.applicationIconBadgeNumber = 0

        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        
        let audio_Session = AVAudioSession.sharedInstance()
        if audio_Session.isOtherAudioPlaying{
            
            _ = try? audio_Session.setCategory(AVAudioSessionCategoryAmbient, with: AVAudioSessionCategoryOptions.mixWithOthers)
            
        }
        
        
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        // print("locations = \(locValue.latitude) \(locValue.longitude)")
        
        myCurrentLat = locValue.latitude
        myCurrentLong = locValue.longitude
        
    }
    
    //MARK: Push notifications delegates
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data){
     
        deviceTokenString = ""
        
        for i in 0..<deviceToken.count{
            
            deviceTokenString = deviceTokenString + String(format: "%02.2hhx", arguments: [deviceToken[i]])
        }
        
        print("Device Token is \(deviceTokenString)")
        UIPasteboard.general.string = deviceTokenString
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        
        if application.applicationState != .active {
            perform(#selector(self.pushTONext), with: nil, afterDelay: 1.0)
        }

        
        
    }
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        deviceTokenString = "b43c88327277116c7eb398395a96907e744d04ebb288efc970658b63498014ec"
        
    }
    
    func pushTONext() { //requestId

        bool_PushComingFromAppDelegate = true
        let navigationController: SWRevealViewController? = (window?.rootViewController as? SWRevealViewController)
        let controller: RequestDetailsViewController? = (Global.macros.Storyboard.instantiateViewController(withIdentifier: "myrequests_to_requestdetail") as? RequestDetailsViewController)
        navigationController?.frontViewController = controller
        navigationController?.setFrontViewPosition(FrontViewPosition.left, animated: true)
    }
    
}

