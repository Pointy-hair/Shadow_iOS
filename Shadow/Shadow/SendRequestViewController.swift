//
//  SendRequestViewController.swift
//  Shadow
//
//  Created by Aditi on 18/08/17.
//  Copyright © 2017 Atinderjit Kaur. All rights reserved.
//

import UIKit
import CoreLocation
import GooglePlaces
import GooglePlacePicker

class SendRequestViewController: UIViewController,GMSAutocompleteViewControllerDelegate {

    @IBOutlet var imgView_InPerson: UIImageView!
    @IBOutlet var btn_SelectLocation: UIButton!
    @IBOutlet var imgView_Virtually: UIImageView!
    @IBOutlet var btn_SelectVirtualOption: UIButton!
    @IBOutlet var calender: FSCalendar!
    @IBOutlet var txtView_Message: UITextView!
    
    @IBOutlet var lbl_MessagePlaceholder: UILabel!
    
    @IBOutlet var tblView_VirtualWays: UITableView!
    
    var user_Name:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            
            self.navigationItem.title = self.user_Name!
            self.btn_SelectLocation.layer.cornerRadius = 3.0
            self.btn_SelectLocation.layer.borderColor = Global.macros.themeColor_pink.cgColor
            self.btn_SelectLocation.layer.borderWidth = 1.0
            
            self.btn_SelectVirtualOption.layer.cornerRadius = 3.0
            self.btn_SelectVirtualOption.layer.borderColor = Global.macros.themeColor_pink.cgColor
            self.btn_SelectVirtualOption.layer.borderWidth = 1.0
            
            self.CreateNavigationBackBarButton()
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - Button Actions
    @IBAction func Action_CheckBtnLocation(_ sender: UIButton) {
        
        self.imgView_InPerson.image = UIImage.init(named: "checked")
        self.imgView_Virtually.image = UIImage.init(named: "unchecked")
        
        self.btn_SelectLocation.isHidden = false
        self.btn_SelectVirtualOption.isHidden = true

        
        
    }
    
    @IBAction func Action_CheckBtnVirtualOption(_ sender: UIButton) {
        
        self.imgView_Virtually.image = UIImage.init(named: "checked")
        self.imgView_InPerson.image = UIImage.init(named: "unchecked")

        self.btn_SelectLocation.isHidden = true
        self.btn_SelectVirtualOption.isHidden = false
    }
    

    @IBAction func Action_SelectLocation(_ sender: Any) {
        
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        present(autocompleteController, animated: true, completion: nil)
        
    }
    
    @IBAction func Action_SelectVirtualOption(_ sender: UIButton) {
        
        
    }
    
    
    
    // MARK: - Delegate GMSAutocompleteViewController
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        print("Place name: \(place.name)")
        print("Place address: \(place.formattedAddress)")
        print("Place attributions: \(place.attributions)")
        self.btn_SelectLocation.setTitle(place.name, for: .normal)
        dismiss(animated: true, completion: nil)
   
    }
    
    
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        //  handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
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

extension SendRequestViewController:UITextViewDelegate{
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if text == "\n"
        {
            textView.resignFirstResponder()
        }
        return true
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
       // lbl_PlaceholderComments.isHidden = true
        
        if Global.DeviceType.IS_IPHONE_5{
            DispatchQueue.main.async {
                UIView.animate(withDuration: 1.0, animations: {
                   // self.k_Constraint_Top_MainView.constant = -20.0
                })
            }
            
            
        }
        if Global.DeviceType.IS_IPHONE_4_OR_LESS{
            DispatchQueue.main.async {
                UIView.animate(withDuration: 1.0, animations: {
                   // self.k_Constraint_Top_MainView.constant = -40
                })
            }
        }
    }

    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        let str = textView.text.trimmingCharacters(in: .whitespaces)
        
        if str == ""
        {
            self.txtView_Message.text = ""
            //lbl_PlaceholderComments.isHidden = false
            
        }
        else{
            txtView_Message.text = textView.text
        }
        
        if Global.DeviceType.IS_IPHONE_5{
            DispatchQueue.main.async {
                UIView.animate(withDuration: 1.0, animations: {
                    //self.k_Constraint_Top_MainView.constant = 0.0
                })
            }
            
            
        }
        if Global.DeviceType.IS_IPHONE_4_OR_LESS{
            DispatchQueue.main.async {
                UIView.animate(withDuration: 1.0, animations: {
                   // self.k_Constraint_Top_MainView.constant = 0.0
                })
            }
            
            
        }
    }

    
    
    
}




