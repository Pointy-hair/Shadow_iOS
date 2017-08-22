//
//  OccupationDetailViewController.swift
//  Shadow
//
//  Created by Atinderjit Kaur on 22/08/17.
//  Copyright © 2017 Atinderjit Kaur. All rights reserved.
//

import UIKit

class OccupationDetailViewController: UIViewController {
    
    
    @IBOutlet weak var lbl_avgRating: UILabel!
    
    @IBOutlet weak var lbl_AvgSalary: UILabel!
    
    @IBOutlet weak var lbl_GrowthPercentage: UILabel!
    
    @IBOutlet weak var lbl_UsersWithThisOccupation: UILabel!
    
    @IBOutlet weak var lbl_UserThatShadowedThis: UILabel!
    
    @IBOutlet weak var txtfield_Occupation: UITextView!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
