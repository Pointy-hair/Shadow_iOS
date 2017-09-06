//
//  OccupationDetailViewController.swift
//  Shadow
//
//  Created by Atinderjit Kaur on 22/08/17.
//  Copyright © 2017 Atinderjit Kaur. All rights reserved.
//

import UIKit
import Charts

class OccupationDetailViewController: UIViewController {
    
  //   var NoOfEmployees: [String]!
    
    
    @IBOutlet weak var barChartView: BarChartView!
    @IBOutlet weak var lbl_avgRating: UILabel!
    @IBOutlet weak var lbl_AvgSalary: UILabel!
    @IBOutlet weak var lbl_GrowthPercentage: UILabel!
    @IBOutlet weak var lbl_UsersWithThisOccupation: UILabel!
    @IBOutlet weak var lbl_UserThatShadowedThis: UILabel!
    @IBOutlet weak var txtfield_Occupation: UILabel!
    @IBOutlet weak var scroll_View: UIScrollView!
    @IBOutlet weak var collectionViewCompany: UICollectionView!
    @IBOutlet weak var collectionViewSchool: UICollectionView!
    var dic_Occupation = NSMutableDictionary()
     var arr_school = NSMutableArray()
     var arr_company = NSMutableArray()
    
    var arr_NoOfEmployees = NSMutableArray() //x axis
    var arr_Salary = NSMutableArray() //y axis
    
    public var occupationId : NSNumber?
    
    @IBOutlet weak var kheightViewBehindCompany: NSLayoutConstraint!
    
    @IBOutlet weak var kheightViewBehindSchool: NSLayoutConstraint!
    
    @IBOutlet weak var kHeightCC: NSLayoutConstraint!
    @IBOutlet weak var kHeightSC: NSLayoutConstraint!
    
    @IBOutlet weak var kheight_DescriptionView: NSLayoutConstraint!
    @IBOutlet weak var kHeightlblDescription: NSLayoutConstraint!

    
    @IBOutlet weak var lbl_RatingCount: UILabel!
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            self.GetData()
        }

        
        self.barChartView.xAxis.drawGridLinesEnabled = false
        self.barChartView.rightAxis.drawGridLinesEnabled = false
        self.barChartView.rightAxis.drawAxisLineEnabled = false
        self.barChartView.rightAxis.drawLabelsEnabled = false
        self.barChartView.leftAxis.drawGridLinesEnabled = false
        self.barChartView.leftAxis.drawAxisLineEnabled = false
        self.barChartView.leftAxis.drawLabelsEnabled = false
        self.barChartView.xAxis.drawAxisLineEnabled = false
        self.barChartView.xAxis.drawLabelsEnabled = false
             //chartDataSet.colors = [.green, .yellow, .red]
        self.barChartView.legend.enabled = false
       self.barChartView.highlightPerTapEnabled = false
        self.barChartView.highlightFullBarEnabled = false
        
      


        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
//        self.navigationItem.setHidesBackButton(false, animated:true)
//        self.tabBarController?.tabBar.isHidden = true
     
        let myBackButton:UIButton = UIButton()
        myBackButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        myBackButton.setImage(UIImage(named:"back-new"), for: UIControlState())
        myBackButton.addTarget(self, action: #selector(self.PopToRootViewController), for: UIControlEvents.touchUpInside)
        let leftBackBarButton:UIBarButtonItem = UIBarButtonItem(customView: myBackButton)
        self.navigationItem.leftBarButtonItem = leftBackBarButton
       
        // Do any additional setup after loading the view.
 
    }
    
    func GetData() {
        
        let dict = NSMutableDictionary()
        dict.setValue(SavedPreferences.value(forKey: Global.macros.kUserId) as? NSNumber, forKey: Global.macros.kUserId)
        dict.setValue(occupationId, forKey: "occupationId")

        print(dict)
        
        if self.checkInternetConnection(){
            
            DispatchQueue.main.async {
                self.pleaseWait()
            }
            
            
            ProfileAPI.sharedInstance.OccupationDetail(dict: dict, completion: { (response) in
                print(response)
                DispatchQueue.main.async {
                    self.clearAllNotice()
                }
                let status = response.value(forKey: "status") as? NSNumber
                switch(status!){
                    
                case 200:
                    print(response)
                    
                    self.dic_Occupation = (response.value(forKey: "data") as! NSDictionary).mutableCopy() as! NSMutableDictionary
                       DispatchQueue.main.async {
                    
                    self.navigationItem.title = (self.dic_Occupation.value(forKey: "name") as? String)?.capitalizingFirstLetter()
                    self.lbl_avgRating.text = "\((self.dic_Occupation.value(forKey: "avgRating")!))"
                     self.lbl_RatingCount.text = "\((self.dic_Occupation.value(forKey: "ratingCount")!))"
                    // self.lbl_AvgSalary.text = (self.dic_Occupation.value(forKey: "salary") as? String)
                      // print(self.suffixNumber(number: NSNumber(long: 24000)));
                        
                      
                        
                        self.lbl_UsersWithThisOccupation.text = "\((self.dic_Occupation.value(forKey: "avgRating")!))"
                        self.lbl_UserThatShadowedThis.text = "\((self.dic_Occupation.value(forKey: "avgRating")!))"
                      
                        self.txtfield_Occupation.text = (self.dic_Occupation.value(forKey: "description") as? String)
                        DispatchQueue.main.async {
                       self.txtfield_Occupation.frame.size.height = self.txtfield_Occupation.intrinsicContentSize.height
                        self.kheight_DescriptionView.constant = self.txtfield_Occupation.frame.size.height + 42
                        }
                        
                        let morePrecisePI = Double((self.dic_Occupation.value(forKey: "salary") as? String)!)

                         let myInteger = Int(morePrecisePI!)
                            let myNumber = NSNumber(value:myInteger)
                            print(myNumber)
                            self.lbl_AvgSalary.text = self.suffixNumber(number: myNumber) as String
                            print(self.lbl_AvgSalary.text!) //companys
                        
                        if self.dic_Occupation.value(forKey: "companys") != nil {
                        self.arr_company = (self.dic_Occupation.value(forKey: "companys") as! NSArray).mutableCopy() as! NSMutableArray
                            print("atinder")
                            print( self.arr_company)
                            
                            }
                       if  self.arr_company.count == 0 {
                            
                            self.collectionViewCompany.isHidden = true
                        }
                            
                      if self.dic_Occupation.value(forKey: "schools") != nil {
                        self.arr_school = (self.dic_Occupation.value(forKey: "schools") as! NSArray).mutableCopy() as! NSMutableArray
                            }
                      if self.arr_school.count == 0 {
                        
                         self.collectionViewSchool.isHidden = true
                        }

                        self.setChart()

                        self.collectionViewSchool.reloadData()
                        self.collectionViewCompany.reloadData()
                    }
                    
                    break
                    
                case 404:
                    DispatchQueue.main.async {
                        self.collectionViewSchool.isHidden = true
                        self.collectionViewCompany.isHidden = false
                    }
                    
                    break
                    
                default:
                    self.showAlert(Message: Global.macros.kError, vc: self)
                    break
                    
                    
                }
                
            }, errorBlock: { (error) in
                DispatchQueue.main.async {
                    self.clearAllNotice()
                    self.showAlert(Message: Global.macros.kError, vc: self)
                }
            })
        }else{
            self.showAlert(Message: Global.macros.kInternetConnection, vc: self)
        }

        
    }
    
    func suffixNumber(number:NSNumber) -> NSString {
        
        var num:Double = number.doubleValue;
        let sign = ((num < 0) ? "-" : "" );
        
        num = fabs(num);
        
        if (num < 1000.0){
            return "\(sign)\(num)" as NSString;
        }
        
        let exp:Int = Int(log10(num) / 3.0 ); //log10(1000));
        
        let units:[String] = ["K","M","G","T","P","E"];
        
        let roundedNum:Double = round(10 * num / pow(1000.0,Double(exp))) / 10;
        
        return "\(sign)\(roundedNum)\(units[exp-1])" as NSString;
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    func setChart() {
        
        let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        let unitsSold = [20.0, 4.0, 3.0, 6.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
        barChartView.setBarChartData(xValues: months, yValues: unitsSold, label: "")
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        bool_Occupation = true

    }
    
    override func viewDidLayoutSubviews() {
        scroll_View.contentSize = CGSize.init(width: view.frame.size.width, height:  900)
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
extension OccupationDetailViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 8
        let size:CGSize?
        if Global.DeviceType.IS_IPHONE_6 || Global.DeviceType.IS_IPHONE_6P{
            size = CGSize(width: ((collectionView.frame.width/3 - 5) ), height: 45)
        }
        else{
            size = CGSize(width: ((collectionView.frame.width/2 - 5) ), height: 45)
            
        }
        return size!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        var cell = UICollectionViewCell()
        
        if collectionView == collectionViewCompany {
            let company_cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "company", for: indexPath)as! CompanyCollectionViewCell
            
            if arr_company.count > 0 {
                
                if  let dict =  (arr_company[indexPath.row]as! NSDictionary).value(forKey: "userDTO") as? NSDictionary {
                    DispatchQueue.main.async {
                        //let dict = (self.arr_company[indexPath.row]as! NSDictionary).value(forKey: "userDTO") as! NSMutableDictionary
                        
                        company_cell.lbl_CompanyName.text = dict.value(forKey: "companyName") as? String

                    }
                    
                }
            }
            
            cell = company_cell
            
        }
        
        if collectionView == collectionViewSchool{
            let school_cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "school", for: indexPath)as! SchoolCollectionViewCell
            
            if arr_school.count > 0 {
                if  let dict =  (arr_school[indexPath.row]as! NSDictionary).value(forKey: "userDTO") as? NSDictionary {
                    DispatchQueue.main.async {
               
                
               school_cell.lbl_SchoolName.text = dict.value(forKey: "schoolName") as? String
                    }
                }
            }
            
            cell = school_cell
            
        }

      return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        var count:Int?
        
        if collectionView == collectionViewCompany{
            
            count = arr_company.count
            if count! <= 2 {
                self.kheightViewBehindCompany.constant = 100
                
            }
                
                
            else if count == 4 {
                self.kheightViewBehindCompany.constant = 150
                
            }
            else {
                
                DispatchQueue.main.async {
                    
                    self.kHeightCC.constant =  self.collectionViewCompany.contentSize.height
                    self.kheightViewBehindCompany.constant =  self.collectionViewCompany.contentSize.height + 35
                }
            }
            
            if Global.DeviceType.IS_IPHONE_5 {
                
                if count == 3 {
                    self.kheightViewBehindCompany.constant = 150
                    
                }
                
                
            }
            
            
        }
        
        if collectionView == collectionViewSchool{
            
            count = arr_school.count
            if count! <= 2 {
                self.kheightViewBehindSchool.constant = 100
            }
            else if count == 4 {
                self.kheightViewBehindSchool.constant = 150
                
            }
            else {
                DispatchQueue.main.async {
                    
                    self.kHeightSC.constant =  self.collectionViewSchool.contentSize.height
                    self.kheightViewBehindSchool.constant =  self.collectionViewSchool.contentSize.height + 35
                }
                
            }
            
            if Global.DeviceType.IS_IPHONE_5 {
                
                if count == 3 {
                    self.kheightViewBehindSchool.constant = 150
                    
                }
            }
        }
        
         DispatchQueue.main.async {
        self.scroll_View.contentSize = CGSize(width: self.view.frame.size.width, height: 350 + self.kheight_DescriptionView.constant + self.kheightViewBehindCompany.constant + self.kheightViewBehindSchool.constant)
        }
        
        return count!
        

   }
}
extension BarChartView {
    
     class BarChartFormatter: NSObject, IAxisValueFormatter {
        
        var labels: [String] = []
        
        func stringForValue(_ value: Double, axis: AxisBase?) -> String {
            return labels[Int(value)]
        }
        
        init(labels: [String]) {
            super.init()
            self.labels = labels
        }
    }
    
    func setBarChartData(xValues: [String], yValues: [Double], label: String) {
        
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<yValues.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: yValues[i])
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: label)
        let color = UIColor.init(red: 180.0/255.0, green: 90.0/255.0, blue: 200.0/255.0, alpha: 1.0)
        chartDataSet.setColors(color)
        
        let chartData = BarChartData(dataSet: chartDataSet)
        
        let chartFormatter = BarChartFormatter(labels: xValues)
        let xAxis = XAxis()
        xAxis.valueFormatter = chartFormatter
        self.xAxis.valueFormatter = xAxis.valueFormatter
        
        self.data = chartData
        
       
    }
}

