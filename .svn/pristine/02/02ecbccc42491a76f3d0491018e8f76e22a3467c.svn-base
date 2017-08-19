//
//  AddRatingViewController.swift
//  Shadow
//
//  Created by Atinderjit Kaur on 21/06/17.
//  Copyright © 2017 Atinderjit Kaur. All rights reserved.
//

import UIKit

class AddRatingViewController: UIViewController,UIGestureRecognizerDelegate,FloatRatingViewDelegate {
    
    
    @IBOutlet weak var txtview_Comment: UITextView!
    @IBOutlet weak var lbl_Counter: UILabel!
    var str_rating : String?
    var view_stars = FloatRatingView()
    
    
    @IBOutlet weak var lbl_Placeholder: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CreateNavigationBackBarButton() //Create custom ack button

        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(handle_Tap(_:))) // Tap gesture to resign keyboard
        tap.delegate = self
        self.view.addGestureRecognizer(tap)
        
        // Do any additional setup after loading the view.
        let btn_addRating = UIButton(type: .custom)
        btn_addRating.setImage(UIImage(named: "send-icon"), for: .normal)
        btn_addRating.frame = CGRect(x: self.view.frame.size.width - 25, y: 0, width: 25, height: 25)
        btn_addRating.addTarget(self, action: #selector(AddRating), for: .touchUpInside)
        let item4 = UIBarButtonItem(customView: btn_addRating)
        self.navigationItem.setRightBarButton(item4, animated: true)
        custom_Star_View()
        
    }
    
    func custom_Star_View () {
        
        view_stars.frame = CGRect(x: 0, y: 10, width: 110, height: 25)
        view_stars.backgroundColor = UIColor.clear
        self.view.addSubview(view_stars)
        
        self.navigationItem.titleView = view_stars
        
        // Required float rating view params
        view_stars.emptyImage = UIImage(named: "whitestar")
       view_stars.fullImage = UIImage(named: "StarFull")
        // Optional params
        view_stars.delegate = self
        view_stars.contentMode = UIViewContentMode.scaleAspectFit
        view_stars.maxRating = 5
        view_stars.minRating = 0
        
        view_stars.rating = 0
        str_rating = "0"
        view_stars.editable = true
        view_stars.halfRatings = false
        view_stars.floatRatings = false
        
    }
    
    
    // MARK: FloatRatingViewDelegate
    
    func floatRatingView(_ ratingView: FloatRatingView, isUpdating rating:Float) {
       str_rating = NSString(format: "%.2f",rating) as String
      print(str_rating!)
    }
    
    func floatRatingView(_ ratingView: FloatRatingView, didUpdate rating: Float) {
        str_rating = NSString(format: "%.2f", rating) as String
      print(str_rating!)
    }


    
    func AddRating() {
        
        
        if txtview_Comment.text == "" {
            
            self.showAlert(Message: "Please add your comment.", vc: self)
        }
            
        else if txtview_Comment.text.characters.count < 6  || txtview_Comment.text.characters.count > 256{
            
            self.showAlert(Message: "Comment limit should be between 6 to 255 characters.", vc: self)

        }
            
          
        else {
        
        API_addRating()
            
        }

    }
    
    //MARK : API to add rating and comment
    
    func API_addRating() {
        
        let dict = NSMutableDictionary()
        print((SavedPreferences.object(forKey: Global.macros.kUserId))!)

        dict.setValue("\(((SavedPreferences.object(forKey: Global.macros.kUserId))!))", forKey: "userId")
        dict.setValue(userIdFromSearch, forKey: "ratedUserId")
        dict.setValue(str_rating, forKey: "rating")
        dict.setValue(txtview_Comment.text, forKey: "comment")
        
        print(dict)
        if self.checkInternetConnection()
        {
            DispatchQueue.main.async {
                 self.pleaseWait()
            }
            
            ProfileAPI.sharedInstance.addRating(postDict: dict, completion_Block: {
                (Response) in
                
                let status = (Response).value(forKey: "status") as? NSNumber
              
              
                    if status == 200 {
                        print(Response)
                        
                        DispatchQueue.main.async{

                        self.clearAllNotice()

                                let TitleString = NSAttributedString(string: "Shadow", attributes: [
                                    NSFontAttributeName : UIFont.systemFont(ofSize: 18),
                                    NSForegroundColorAttributeName : Global.macros.themeColor
                                    ])
                                let MessageString = NSAttributedString(string: "Your rating has added successfully.", attributes: [
                                    NSFontAttributeName : UIFont.systemFont(ofSize: 15),
                                    NSForegroundColorAttributeName : Global.macros.themeColor
                                    ])
                                
                                let alert = UIAlertController(title: "Shadow", message: "Your rating has added successfully.", preferredStyle: .alert)
                                
                                alert.view.layer.cornerRadius = 10.0
                                alert.view.clipsToBounds = true
                                alert.view.backgroundColor = UIColor.white
                                alert.view.tintColor = Global.macros.themeColor
                                alert.setValue(TitleString, forKey: "attributedTitle")
                                alert.setValue(MessageString, forKey: "attributedMessage")
                                
                                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {
                                    (action) in
                                    _ =  self.navigationController?.popViewController(animated: true)
                                }))
                                self.present(alert, animated: true, completion: nil)
                        }
                        
                    }
                        
                    else if status == 301 {
                         DispatchQueue.main.async{
                        self.clearAllNotice()
                        }
                        self.showAlert(Message:(Response.value(forKey: "Message") as? String)!, vc: self)
                        
                    }
                        
                    else if status == 400 {
                         DispatchQueue.main.async{
                        self.clearAllNotice()
                        }
                        self.showAlert(Message:(Response.value(forKey: "Message") as? String)!, vc: self)
                        
                    }
                
                    else if status == 401 {
                        
                        
                        self.AlertSessionExpire()

                }
               
                
            }, error_Block: {
                
                (err) in
                self.clearAllNotice()
                self.showDialogAlert("Error Occurred \n Please try again later.")
                
            })
        }
        else
        {
            self.showDialogAlert(Global.macros.kInternetConnection)
        }

        
        
    }
    
    
    // MARK: Tap gesture to hide keyboard
    func handle_Tap(_ sender: UITapGestureRecognizer) {
        
        self.view.endEditing(true)
        
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


//MARK: UITextView methods

extension AddRatingViewController : UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        lbl_Placeholder.isHidden = true

        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        
        if txtview_Comment.text == ""
        {
            lbl_Placeholder.isHidden = false
        }
        else {
            
            lbl_Placeholder.isHidden = true
            
        }
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if text == "\n"
        {
            textView.resignFirstResponder()
            
        }
        
        let maxLimit = 255
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = maxLimit - newText.characters.count // for Swift use count(newText)
        self.lbl_Counter.text = "\(numberOfChars)"
        print(self.lbl_Counter.text!)
        
        if numberOfChars == 0 {
            
            return false
            
        }
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        lbl_Placeholder.isHidden = !textView.text.isEmpty
    }
    
}

