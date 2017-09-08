//
//  ListingViewController.swift
//  Shadow
//
//  Created by Atinderjit Kaur on 06/09/17.
//  Copyright © 2017 Atinderjit Kaur. All rights reserved.
//

import UIKit

class ListingViewController: UIViewController {

    var type:String?
    var navigation_title:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        
        DispatchQueue.main.async {
            self.navigationItem.title = self.navigation_title
            self.navigationItem.setHidesBackButton(false, animated:true)
            self.CreateNavigationBackBarButton()
            self.tabBarController?.tabBar.isHidden = true
        }
        
        
        if type != nil{
            self.getlistofusers()
        }
        
    }
    
    
    
    //MARK: - Functions
    
    func getlistofusers()  {
        
        
        let dict = NSMutableDictionary()
        dict.setValue(SavedPreferences.value(forKey: Global.macros.kUserId) as? NSNumber, forKey: Global.macros.kUserId)
        dict.setValue(self.type!, forKey: Global.macros.k_type)

        print(dict)
        
        if checkInternetConnection(){
            DispatchQueue.main.async {
                self.pleaseWait()
            
            }
        OpenList_API.sharedInstance.getListOfUsers(completion_block: { (status, dict_Info) in
            
            DispatchQueue.main.async {
                self.clearAllNotice()
            }
            
            switch status{
                
            case 200:
                DispatchQueue.main.async {

                
                    
                    
                }
                break
                
            case 401:
                
                break
                
                
            default:
                
                
                break
                
                
            }
            
        }, error_block: { (error) in
            DispatchQueue.main.async {
                self.clearAllNotice()
                self.showAlert(Message: Global.macros.kError, vc: self)
            }
        }, dict: dict)
        }else{
            self.showAlert(Message: Global.macros.kInternetConnection, vc: self)
        }
        
    }
    
    
    
    /**
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ListingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    return 10
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "cell_listing", for: indexPath) as! ListingTableViewCell
        return cell
     
    }
    
    
}
