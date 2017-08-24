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
    
     var months: [String]!
    
    @IBOutlet weak var barChartView: BarChartView!
    @IBOutlet weak var lbl_avgRating: UILabel!
    @IBOutlet weak var lbl_AvgSalary: UILabel!
    @IBOutlet weak var lbl_GrowthPercentage: UILabel!
    @IBOutlet weak var lbl_UsersWithThisOccupation: UILabel!
    @IBOutlet weak var lbl_UserThatShadowedThis: UILabel!
    @IBOutlet weak var txtfield_Occupation: UITextView!
    @IBOutlet weak var scroll_View: UIScrollView!
    @IBOutlet weak var collectionViewCompany: UICollectionView!
    @IBOutlet weak var collectionViewSchool: UICollectionView!

    override func viewDidLoad() {
        
        super.viewDidLoad()
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
        setChart()
 
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    func setChart() {
        
        let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        let unitsSold = [20.0, 4.0, 3.0, 6.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
        barChartView.setBarChartData(xValues: months, yValues: unitsSold, label: "Monthly Sales")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
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
            
//            if array_UserSkills.count > 0 {
//                
//                skills_cell.lbl_Skill.text = (array_UserSkills[indexPath.row]as! NSDictionary).value(forKey: "name")as? String
//            }
            
            cell = company_cell
            
        }
        
        if collectionView == collectionViewSchool{
            let school_cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "school", for: indexPath)as! SchoolCollectionViewCell
            
//            if array_UserInterests.count > 0 {
//                
//                interest_cell.lbl_InterestName.text = (array_UserInterests[indexPath.row]as! NSDictionary).value(forKey: "name")as? String
//                
//            }
            
            cell = school_cell
            
        }

      return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
//        var count:Int?
//        
//        if collectionView == collectionView_Skills{
//            
//            count = array_UserSkills.count
//            if count! <= 2 {
//                self.kheightViewBehindSkill.constant = 100
//                
//            }
//                
//                
//            else if count == 4 {
//                self.kheightViewBehindSkill.constant = 150
//                
//            }
//            else {
//                
//                self.kheightViewBehindSkill.constant = CGFloat(count! * 32) + CGFloat(10)
//                
//            }
//            
//            if Global.DeviceType.IS_IPHONE_5 {
//                
//                if count == 3 {
//                    self.kheightViewBehindSkill.constant = 150
//                    
//                }
//                
//                
//            }
//            
//            
//        }
//        
//        if collectionView == collectionView_Interests{
//            
//            count = array_UserInterests.count
//            if count! <= 2 {
//                self.kheightViewBehindInterest.constant = 100
//            }
//            else if count == 4 {
//                self.kheightViewBehindInterest.constant = 150
//                
//            }
//            else {
//                self.kheightViewBehindInterest.constant = CGFloat(count! * 32) + CGFloat(10)
//                
//            }
//            
//            if Global.DeviceType.IS_IPHONE_5 {
//                
//                if count == 3 {
//                    self.kheightViewBehindInterest.constant = 150
//                    
//                }
//                
//                
//            }
//            
//        }
//        self.scrollbar.contentSize = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height + self.kheightViewBehindSkill.constant + self.kheightViewBehindInterest.constant + 15)
//        
//        return count!
        
        return 10

   }
}
extension BarChartView {
    
    private class BarChartFormatter: NSObject, IAxisValueFormatter {
        
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
        let chartData = BarChartData(dataSet: chartDataSet)
        
        let chartFormatter = BarChartFormatter(labels: xValues)
        let xAxis = XAxis()
        xAxis.valueFormatter = chartFormatter
        self.xAxis.valueFormatter = xAxis.valueFormatter
        
        self.data = chartData
    }
}

