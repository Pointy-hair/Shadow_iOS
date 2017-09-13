//
//  TabbarController.swift
//  Shadow
//
//  Created by Sahil Arora on 5/31/17.
//  Copyright © 2017 Atinderjit Kaur. All rights reserved.
//

import UIKit

class TabbarController: UITabBarController {

    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        if (SavedPreferences.value(forKey: "role") as? String) == "USER" {
            
            // Create Tab one//search
            let SearchScreen = Global.macros.Storyboard.instantiateViewController(withIdentifier:"nav_search") as! UINavigationController
            let tabOneBarItem = UITabBarItem(title: "", image: UIImage(named: "search-icon"), selectedImage: UIImage(named: ""))
            tabOneBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0)//TLBR
            
            SearchScreen.tabBarItem = tabOneBarItem
            
            
            let NotificationScreen = Global.macros.Storyboard.instantiateViewController(withIdentifier:"nav_Notification") as! UINavigationController
            let tabOneBarItem1 = UITabBarItem(title: "", image: UIImage(named: "Notification_Purple"), selectedImage: UIImage(named: ""))
            tabOneBarItem1.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0)//TLBR
            NotificationScreen.tabBarItem = tabOneBarItem1
            
            
            

            
            // Create Tab three//user
            let HomeScreen = Global.macros.Storyboard.instantiateViewController(withIdentifier:"nav_user") as! UINavigationController
            let tabTwoBarItem3 = UITabBarItem(title: "", image: UIImage(named: "profile-icon"), selectedImage: UIImage(named: ""))
            HomeScreen.tabBarItem = tabTwoBarItem3
            tabTwoBarItem3.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0)//TLBR
            
            self.viewControllers = [SearchScreen,NotificationScreen, HomeScreen]
            self.selectedIndex = 2
            bool_UserIdComingFromSearch = false
            
        }
            
        else {
            
            // Create Tab one//search
            let SearchScreen = Global.macros.Storyboard.instantiateViewController(withIdentifier:"nav_search") as! UINavigationController
            let tabOneBarItem = UITabBarItem(title: "", image: UIImage(named: "search-icon"), selectedImage: UIImage(named: ""))
            tabOneBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0)//TLBR
            
            SearchScreen.tabBarItem = tabOneBarItem
            
            
            let NotificationScreen = Global.macros.Storyboard.instantiateViewController(withIdentifier:"nav_Notification") as! UINavigationController
            let tabOneBarItem1 = UITabBarItem(title: "", image: UIImage(named: "Notification_Purple"), selectedImage: UIImage(named: ""))
            tabOneBarItem1.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0)//TLBR
            NotificationScreen.tabBarItem = tabOneBarItem1
            
            
            
            // Create Tab three//user
            let HomeScreen = Global.macros.Storyboard.instantiateViewController(withIdentifier:"nav_company") as! UINavigationController
            let tabTwoBarItem3 = UITabBarItem(title: "", image: UIImage(named: "profile-icon"), selectedImage: UIImage(named: ""))
            HomeScreen.tabBarItem = tabTwoBarItem3
            tabTwoBarItem3.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0)//TLBR
            
            self.viewControllers = [SearchScreen,NotificationScreen, HomeScreen]
            self.selectedIndex = 2
            bool_UserIdComingFromSearch = false

            
        }
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
     
        
    }
    
    // UITabBarControllerDelegate method
    func tabBarController(_ tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        print("Selected \(viewController.title!)")
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
