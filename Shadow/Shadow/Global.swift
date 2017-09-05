//
//  Global.swift
//  Shadow
//
//  Created by Atinderjit Kaur on 25/11/16.
//  Copyright © 2016 Atinderjit Kaur. All rights reserved.
//

import Foundation

import UIKit

/**
 :brief: Global is a singleton class which i have used to save all constants variables , methods etc.
 */

class Global: NSObject {
    
    static let sharedInstance = Global()
    
    /**
     
     :brief: Structs are preferable if they are relatively small and copiable because copying is way safer than having multiple reference to the same instance as happens with classes. This is especially important when passing around a variable to many classes and/or in a multithreaded environment. If you can always send a copy of your variable to other places, you never have to worry about that other place changing the value of your variable underneath you.
     
     With Structs there is no need to worry about memory leaks or multiple threads racing to access/modify a single instance of a variable.
     
     */
    func countryCode() -> NSMutableArray {
        
        let mArr = NSMutableArray()
        
        let arr = [["name":"Nigeria","code":"234"],["name":"Afghanistan","code":"93"], ["name":"Albania","code":"355"], ["name":"Algeria","code":"213"], ["name":"American Samoa","code":"1-684"], ["name":"Andorra","code":"376"], ["name":"Angola","code":"244"], ["name":"Anguilla","code":"1-264"], ["name":"Antarctica","code":"672"], ["name":"Antigua and Barbuda","code":"1-268"], ["name":"Argentina","code":"54"], ["name":"Armenia","code":"374"], ["name":"Aruba","code":"297"], ["name":"Australia","code":"61"], ["name":"Austria","code":"43"], ["name":"Azerbaijan","code":"994"], ["name":"Bahamas","code":"1-242"], ["name":"Bahrain","code":"973"], ["name":"Bangladesh","code":"880"], ["name":"Barbados","code":"1-246"], ["name":"Belarus","code":"375"], ["name":"Belgium","code":"32"], ["name":"Belize","code":"501"], ["name":"Benin","code":"229"], ["name":"Bermuda","code":"1-441"], ["name":"Bhutan","code":"975"], ["name":"Bolivia","code":"591"], ["name":"Bonaire","code":"599"], ["name":"Bosnia and Herzegovina","code":"387"], ["name":"Botswana","code":"267"], ["name":"Bouvet Island","code":"47"], ["name":"Brazil","code":"55"], ["name":"British Indian Ocean Territory","code":"246"], ["name":"Brunei Darussalam","code":"673"], ["name":"Bulgaria","code":"359"], ["name":"Burkina Faso","code":"226"], ["name":"Burundi","code":"257"], ["name":"Cambodia","code":"855"], ["name":"Cameroon","code":"237"], ["name":"Canada","code":"1"], ["name":"Cape Verde","code":"238"], ["name":"Cayman Islands","code":"1-345"], ["name":"Central African Republic","code":"236"], ["name":"Chad","code":"235"], ["name":"Chile","code":"56"], ["name":"China","code":"86"], ["name":"Christmas Island","code":"61"], ["name":"Cocos (Keeling) Islands","code":"61"], ["name":"Colombia","code":"57"], ["name":"Comoros","code":"269"], ["name":"Congo","code":"242"], ["name":"Democratic Republic of the Congo","code":"243"], ["name":"Cook Islands","code":"682"], ["name":"Costa Rica","code":"506"], ["name":"Croatia","code":"385"], ["name":"Cuba","code":"53"], ["name":"CuraÃ§ao","code":"599"], ["name":"Cyprus","code":"357"], ["name":"Czech Republic","code":"420"], ["name":"CÃ´te d'Ivoire","code":"225"], ["name":"Denmark","code":"45"], ["name":"Djibouti","code":"253"],
                   ["name":"Dominica","code":"1-767"], ["name":"Dominican Republic","code":"1-809"],["name":"Dominican Republic","code":"1-829"],["name":"Dominican Republic","code":"1-849"], ["name":"Ecuador","code":"593"],
                   ["name":"Egypt","code":"20"], ["name":"El Salvador","code":"503"], ["name":"Equatorial Guinea","code":"240"], ["name":"Eritrea","code":"291"], ["name":"Estonia","code":"372"], ["name":"Ethiopia","code":"251"], ["name":"Falkland Islands (Malvinas)","code":"500"], ["name":"Faroe Islands","code":"298"], ["name":"Fiji","code":"679"], ["name":"Finland","code":"358"], ["name":"France","code":"33"], ["name":"French Guiana","code":"594"], ["name":"French Polynesia","code":"689"], ["name":"French Southern Territories","code":"262"], ["name":"Gabon","code":"241"], ["name":"Gambia","code":"220"], ["name":"Georgia","code":"995"], ["name":"Germany","code":"49"], ["name":"Ghana","code":"233"], ["name":"Gibraltar","code":"350"], ["name":"Greece","code":"30"], ["name":"Greenland","code":"299"], ["name":"Grenada","code":"1-473"], ["name":"Guadeloupe","code":"590"], ["name":"Guam","code":"1-671"], ["name":"Guatemala","code":"502"], ["name":"Guernsey","code":"44"], ["name":"Guinea","code":"224"], ["name":"Guinea-Bissau","code":"245"], ["name":"Guyana","code":"592"], ["name":"Haiti","code":"509"], ["name":"Heard Island and McDonald Mcdonald Islands","code":"672"], ["name":"Holy See (Vatican City State)","code":"379"], ["name":"Honduras","code":"504"], ["name":"Hong Kong","code":"852"], ["name":"Hungary","code":"36"], ["name":"Iceland","code":"354"], ["name":"India","code":"91"], ["name":"Indonesia","code":"62"], ["name":"Iran, Islamic Republic of","code":"98"], ["name":"Iraq","code":"964"], ["name":"Ireland","code":"353"], ["name":"Isle of Man","code":"44"], ["name":"Israel","code":"972"], ["name":"Italy","code":"39"], ["name":"Jamaica","code":"1-876"], ["name":"Japan","code":"81"], ["name":"Jersey","code":"44"], ["name":"Jordan","code":"962"], ["name":"Kazakhstan","code":"7"], ["name":"Kenya","code":"254"], ["name":"Kiribati","code":"686"], ["name":"Korea, Democratic People's Republic of","code":"850"], ["name":"Korea, Republic of","code":"82"], ["name":"Kuwait","code":"965"], ["name":"Kyrgyzstan","code":"996"], ["name":"Lao People's Democratic Republic","code":"856"], ["name":"Latvia","code":"371"], ["name":"Lebanon","code":"961"], ["name":"Lesotho","code":"266"], ["name":"Liberia","code":"231"], ["name":"Libya","code":"218"], ["name":"Liechtenstein","code":"423"], ["name":"Lithuania","code":"370"], ["name":"Luxembourg","code":"352"], ["name":"Macao","code":"853"], ["name":"Macedonia the Former Yugoslav Republic of","code":"389"], ["name":"Madagascar","code":"261"], ["name":"Malawi","code":"265"], ["name":"Malaysia","code":"60"], ["name":"Maldives","code":"960"], ["name":"Mali","code":"223"], ["name":"Malta","code":"356"], ["name":"Marshall Islands","code":"692"], ["name":"Martinique","code":"596"], ["name":"Mauritania","code":"222"], ["name":"Mauritius","code":"230"], ["name":"Mayotte","code":"262"], ["name":"Mexico","code":"52"], ["name":"Micronesia, Federated States of","code":"691"], ["name":"Moldova, Republic of","code":"373"], ["name":"Monaco","code":"377"], ["name":"Mongolia","code":"976"], ["name":"Montenegro","code":"382"], ["name":"Montserrat","code":"1-664"], ["name":"Morocco","code":"212"], ["name":"Mozambique","code":"258"], ["name":"Myanmar","code":"95"], ["name":"Namibia","code":"264"], ["name":"Nauru","code":"674"], ["name":"Nepal","code":"977"], ["name":"Netherlands","code":"31"], ["name":"New Caledonia","code":"687"], ["name":"New Zealand","code":"64"], ["name":"Nicaragua","code":"505"], ["name":"Niger","code":"227"],  ["name":"Niue","code":"683"], ["name":"Norfolk Island","code":"672"], ["name":"Northern Mariana Islands","code":"1-670"], ["name":"Norway","code":"47"], ["name":"Oman","code":"968"], ["name":"Pakistan","code":"92"], ["name":"Palau","code":"680"], ["name":"Palestine, State of","code":"970"], ["name":"Panama","code":"507"], ["name":"Papua New Guinea","code":"675"], ["name":"Paraguay","code":"595"], ["name":"Peru","code":"51"], ["name":"Philippines","code":"63"], ["name":"Pitcairn","code":"870"], ["name":"Poland","code":"48"], ["name":"Portugal","code":"351"], ["name":"Puerto Rico","code":"1"], ["name":"Qatar","code":"974"], ["name":"Romania","code":"40"], ["name":"Russian Federation","code":"7"], ["name":"Rwanda","code":"250"], ["name":"Reunion","code":"262"], ["name":"Saint Barthelemy","code":"590"], ["name":"Saint Helena","code":"290"], ["name":"Saint Kitts and Nevis","code":"1-869"], ["name":"Saint Lucia","code":"1-758"], ["name":"Saint Martin (French part)","code":"590"], ["name":"Saint Pierre and Miquelon","code":"508"], ["name":"Saint Vincent and the Grenadines","code":"1-784"], ["name":"Samoa","code":"685"], ["name":"San Marino","code":"378"], ["name":"Sao Tome and Principe","code":"239"], ["name":"Saudi Arabia","code":"966"], ["name":"Senegal","code":"221"], ["name":"Serbia","code":"381"], ["name":"Seychelles","code":"248"], ["name":"Sierra Leone","code":"232"], ["name":"Singapore","code":"65"], ["name":"Sint Maarten (Dutch part)","code":"1-721"], ["name":"Slovakia","code":"421"], ["name":"Slovenia","code":"386"], ["name":"Solomon Islands","code":"677"], ["name":"Somalia","code":"252"], ["name":"South Africa","code":"27"], ["name":"South Georgia and the South Sandwich Islands","code":"500"], ["name":"South Sudan","code":"211"], ["name":"Spain","code":"34"], ["name":"Sri Lanka","code":"94"], ["name":"Sudan","code":"249"], ["name":"Suriname","code":"597"], ["name":"Svalbard and Jan Mayen","code":"47"], ["name":"Swaziland","code":"268"], ["name":"Sweden","code":"46"], ["name":"Switzerland","code":"41"], ["name":"Syrian Arab Republic","code":"963"], ["name":"Taiwan, Province of China","code":"886"], ["name":"Tajikistan","code":"992"], ["name":"United Republic of Tanzania","code":"255"], ["name":"Thailand","code":"66"], ["name":"Timor-Leste","code":"670"], ["name":"Togo","code":"228"], ["name":"Tokelau","code":"690"], ["name":"Tonga","code":"676"], ["name":"Trinidad and Tobago","code":"1-868"], ["name":"Tunisia","code":"216"], ["name":"Turkey","code":"90"], ["name":"Turkmenistan","code":"993"], ["name":"Turks and Caicos Islands","code":"1-649"], ["name":"Tuvalu","code":"688"], ["name":"Uganda","code":"256"], ["name":"Ukraine","code":"380"], ["name":"United Arab Emirates","code":"971"], ["name":"United Kingdom","code":"44"], ["name":"United States","code":"1"], ["name":"United States Minor Outlying Islands","code":"1"], ["name":"Uruguay","code":"598"], ["name":"Uzbekistan","code":"998"], ["name":"Vanuatu","code":"678"], ["name":"Venezuela","code":"58"], ["name":"Viet Nam","code":"84"], ["name":"British Virgin Islands","code":"1-284"], ["name":"US Virgin Islands","code":"1-340"], ["name":"Wallis and Futuna","code":"681"], ["name":"Western Sahara","code":"212"], ["name":"Yemen","code":"967"], ["name":"Zambia","code":"260"], ["name":"Zimbabwe","code":"263"], ["name":"Aland Islands","code":"358"]]
        
        mArr.addObjects(from: arr)
        return mArr
    }

    struct macros {
       
        static let kAppDelegate = UIApplication.shared.delegate as! AppDelegate
        static let Storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        static let AppWindow:UIWindow = Global.macros.kAppDelegate.window!
        static let KPasswordLength:String = "Password must contain 6-15 characters."
        static let KUsernameLength:String = "Username must contain 6 characters."
        static let KPasswordMatch:String = "Confirm Password does not match."
        static let KInvalidEmail:String = "Please enter correct email."
        static let KInvalidPhoneNumber:String = "Please enter valid phone number."
        static let kEmailExist:String = "Email already exist."
        static let kResentOtp:String = "Otp has been sent successfully."
        static let kUserNotExist:String = "User does not exist in the system."

        //Theme Color
        static let themeColor:UIColor = UIColor.init(red: 153.0/255.0, green: 143.0/255.0, blue: 189.0/255.0, alpha: 1.0)
        
         static let themeColor_pink:UIColor = UIColor.init(red: 156.0/255.0, green: 39.0/255.0, blue: 176.0/255.0, alpha: 1.0)
        
        static let themeColor_Red:UIColor = UIColor.init(red: 177.0/255.0, green: 24.0/255.0, blue: 6.0/255.0, alpha: 1.0)

        static let themeColor_Green:UIColor = UIColor.init(red: 0.0/255.0, green: 125.0/255.0, blue: 23.0/255.0, alpha: 1.0)

        static let themeColor_Yellow:UIColor = UIColor.init(red: 255.0/255.0, green: 174.0/255.0, blue: 30.0/255.0, alpha: 1.0)

        
        //Keys
        static let kUserName:String = "userName"
        static let kPassword:String = "password"
        static let kEmail:String = "email"
        static let kFirstName:String = "firstName"
        static let kLastName:String = "lastName"
        static let kMobileNumber:String = "mobileNumber"
        static let kCountryCode:String = "countryCode"
        static let klatitude:String = "latitude"
        static let klongitude:String = "longitude"
        static let klocation:String = "location"
        static let kotherUsersShadowYou:String = "otherUsersShadowYou"
        static let kprofileImage:String = "profileImage"
        static let kbio:String = "bio"

        
        static let KStatus:String = "status"
        static let kUserId:String = "userId"
        static let kotherUserId:String = "otherUserId"
        static let kAppBuildNumber = "appBuildNumber"
        static let kAppVersion:String = "appVersion"
        
        //Alert Message
        static let kError:String = "Error Occurred. \n Please try again later."
        static let kInternetConnection:String = "Please check your Internet Connection."
        static let kIncorrectCredentials:String = "Please enter correct credentials."
        static let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView

        
        //Keywords
        static let kschoolName:String = "schoolName"
        static let koccupation:String = "occupations"
        static let kcompanyName:String = "companyName"
        static let kinterest:String = "interest"
        static let kskills:String = "skills"
        static let kdescription:String = "description"
        static let krole:String = "role"
        static let kCompanyURL:String = "companyUrl"
        static let kSchoolURL:String = "schoolUrl"
        static let klinkedInURL:String = "linkedInUrl"
        static let ktwitterURL:String = "twitterUrl"
        static let kfacebookURL:String = "facebookUrl"
        static let kgooglePlusURL:String = "googlePlusUrl"
        static let kgitHubURL:String = "gitHubUrl"
        static let kinstagramURL:String = "instagramUrl"
        static let kname:String = "name"
        static let kschoolCompanyWithTheseOccupations:String = "schoolOrCompanyWithTheseOccupations"
        static let kcount:String = "count"
        static let kcompanyList:String = "companyList"
        static let kschoolList:String = "schoolList"
        static let kschoolCompanyWithTheseUsers:String = "schoolOrCompanyWithTheseUsers"
        static let kReceived:String = "Received"
        static let kSend:String = "Send"
        static let kAll:String = "All"
        static let kAccept:String = "accept"
        static let kReject:String = "Reject"
        static let kId:String = "id"
        static let kSmallReject:String = "reject"



        
        static let kgetUrl:String = "http://115.248.100.76:8013/user/api/"
        static let Array_MenuImages:[UIImage] =     [UIImage(named:"linkedIn")!,
                                                     UIImage(named:"facebook")!,
                                                     UIImage(named:"twitter")!
                                                     
        ]

        
        
        //apis list
        static let api_getschools:String = "getAllSchool"
        static let api_getoccupation:String = "getAllOccupation"
        static let api_getAllSkillType:String = "getAllSkillType"
        static let api_getAllInterestType:String = "getAllInterestType"
        static let api_getAllAvailCompanies:String = "getAllAvailCompanies"
        
        
        
        //apiParams
        static let api_param_pageIndex:String = "pageIndex"
        static let api_param_pageSize:String = "pageSize"

        //Sent Request api_Params
        static let k_location:String = "location"
        static let k_mediumOfCommunication:String = "mediumOfCommunication"
        static let k_SelectedDate:String = "selectedDate"
        static let k_message:String = "message"

        //getrequestsbytype api_params
        static let k_type:String = "type"
        static let k_subType:String = "subType"
        
        
        
        
    }
    struct Platform {
        static let isSimulator: Bool = {
            var isSim = false
            #if arch(i386) || arch(x86_64)
                isSim = true
            #endif
            return isSim
        }()
    }
  
    
    
    struct ScreenSize{
        static let SCREEN_WIDTH = UIScreen.main.bounds.size.width
        static let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
        static let SCREEN_MAX_LENGTH = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
        static let SCREEN_MIN_LENGTH = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    }
    // Device type
    struct DeviceType{
        static let IS_IPHONE_4_OR_LESS =  UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
        static let IS_IPHONE_5 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
        static let IS_IPHONE_6 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
        static let IS_IPHONE_6P = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    }

}


/**
 This is global extension to show toasts rather than Alerts.
 */



/**
 Adding extention to use Hex- code colors.
 */

extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}


/**
 Adding extention for applying different
 */






