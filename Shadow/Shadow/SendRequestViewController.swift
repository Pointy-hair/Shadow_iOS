//
//  SendRequestViewController.swift
//  Shadow
//
//  Created by Aditi on 18/08/17.
//  Copyright © 2017 Atinderjit Kaur. All rights reserved.
//

import UIKit

class SendRequestViewController: UIViewController {

    @IBOutlet var btn_SelectLocation: UIButton!
    @IBOutlet var btn_SelectVirtualOption: UIButton!
    @IBOutlet var calender: FSCalendar!
    @IBOutlet var txtView_Message: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.btn_SelectLocation.layer.cornerRadius = 3.0
            self.btn_SelectLocation.layer.borderColor = Global.macros.themeColor_pink.cgColor
            self.btn_SelectLocation.layer.borderWidth = 1.0
            
            self.btn_SelectVirtualOption.layer.cornerRadius = 3.0
            self.btn_SelectVirtualOption.layer.borderColor = Global.macros.themeColor_pink.cgColor
            self.btn_SelectVirtualOption.layer.borderWidth = 1.0
            
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func Action_CheckBtnLocation(_ sender: UIButton) {
    }
    
    @IBAction func Action_CheckBtnVirtualOption(_ sender: UIButton) {
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
