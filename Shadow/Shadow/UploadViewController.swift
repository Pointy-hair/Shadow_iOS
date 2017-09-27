//
//  UploadViewController.swift
//  CameraDemo
//
//  Created by Atinderjit Kaur on 01/06/17.
//  Copyright © 2017 Aditi. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import Alamofire
import ICGVideoTrimmer
import MobileCoreServices

var thumbnail : UIImage?

class UploadViewController: UIViewController, ICGVideoTrimmerDelegate {
    
    @IBOutlet weak var img_Back: UIImageView!
    @IBOutlet weak var btn_Back: UIButton!
    @IBOutlet weak var btn_Upload: UIButton!
    @IBOutlet var btn_PlayAgain: UIButton!
    @IBOutlet weak var btn_Cancel: UIButton!
    @IBOutlet weak var view_Popup: UIView!
    
    //MARK: - Variables
    var videoPath:String?
    var avplayeritem:AVPlayerItem!
    var avplayer = AVPlayer()
    var player = AVPlayer()
    var videoData:Data?
    var playing : Bool?
    var url = NSURLRequest()
    private var newVideoPath:String?
    public  var outputURL_new : String?
    
    var playerLayer = AVPlayerLayer()
   var avplayerlayer = AVPlayerLayer()
    
    var videoPlaybackPosition:CGFloat!
    var trimmerView = ICGVideoTrimmerView()
    var StartTime:CGFloat!
    var stopTime: CGFloat!
    var storestopTime: CGFloat!
    
    var trimmedStart=""
    var trimmedStop=""
    var trimmedvideourl : URL?
    var alertcloild = UIAlertView()

    @IBOutlet weak var btn_VideoPlayFromGallery: UIButton!
    @IBOutlet weak var img_Thumbnail: UIImageView!
    
    @IBOutlet weak var btn_PlayFromGallary: UIButton!
    @IBOutlet weak var btn_UploadFromGallary: UIButton!
    @IBOutlet weak var btn_CancelFromGallary: UIButton!
    
    var getthumpforvideo : String?
    var Finalvideoplayerpath : String?
    var playbackTimeCheckerTimer : Timer?
    var exportSession :  AVAssetExportSession!
    var counter : Int = 1
    
    override var shouldAutorotate : Bool {
        // Lock autorotate
        return false
    }
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        // Only allow Portrait
        return UIInterfaceOrientationMask.portrait
    }
    
    override var preferredInterfaceOrientationForPresentation : UIInterfaceOrientation {
        
        // Only allow Portrait
        return UIInterfaceOrientation.portrait
    }
    
    //MARK: - View default methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SetButtonCustomAttributesPurple(self.btn_PlayAgain)
        SetButtonCustomAttributes(self.btn_Upload)
        SetButtonCustomAttributesPurple(self.btn_Cancel)
        DispatchQueue.main.async {
        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")

        if bool_PlayFromProfile == false  && bool_VideoFromGallary == false{
            

             DispatchQueue.main.async {
            
            if self.videoPath != nil || self.videoPath != ""{
                self.newVideoPath = self.videoPath
                _ = try! Data(contentsOf: NSURL(fileURLWithPath: self.newVideoPath!) as URL)
            }
            
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy-HH-mm-ss"
        let dateTimePrefix: String = formatter.string(from: Date())
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0] as String
        
        let  CompressedVideoPath = "\(documentsDirectory)/\(dateTimePrefix).mov"
        let CompressedURL = NSURL(fileURLWithPath: CompressedVideoPath)
        self.compressVideo(NSURL(fileURLWithPath:self.newVideoPath!) as URL, outputURL: CompressedURL as URL,handler: {
            (response) in
            

        })
            do{
                try self.playVideo()
            }
            catch {
                print("Try Again")
            }
        }
           }
            
        else if bool_VideoFromGallary == true {
            
            DispatchQueue.main.async {
                self.img_Thumbnail.isHidden = false
                self.btn_VideoPlayFromGallery.isHidden = false
                self.btn_PlayAgain.isHidden = true
                self.btn_Cancel.isHidden = true
                self.btn_Upload.isHidden = true
                
                self.btn_VideoPlayFromGallery.isHidden = false
                self.btn_PlayFromGallary.isHidden = false
                self.btn_UploadFromGallary.isHidden = false
                self.btn_CancelFromGallary.isHidden = false
                
                self.SetButtonCustomAttributesPurpleGallery(self.btn_PlayFromGallary)
                self.SetButtonCustomAttributesPurpleGallery(self.btn_UploadFromGallary)
                self.SetButtonCustomAttributesPurpleGallery(self.btn_CancelFromGallary)
                self.SetButtonCustomAttributesPurpleGallery(self.btn_VideoPlayFromGallery)


            self.img_Thumbnail.image = thumbnail
            //self.trimmerView = ICGVideoTrimmerView()
            self.trimmerView.frame = CGRect(x:0, y: 0, width: self.view.frame.size.width, height: 85)
                self.trimmerView.maxLength = 60.0
                self.trimmerView.minLength = 10.0
            self.view.addSubview(self.trimmerView)
            self.view.bringSubview(toFront: self.trimmerView)
            let asset = AVAsset(url: video_url!)
            self.videoPlaybackPosition = 0
            self.trimmerView.themeColor = UIColor.lightGray
            self.trimmerView.asset = asset
            self.trimmerView.showsRulerView = true
            self.trimmerView.trackerColor = UIColor.cyan
            self.trimmerView.delegate = self
            // important: reset subviews
            self.trimmerView.resetSubviews()
            
                self.btn_PlayFromGallary.setTitle("PLAY", for: .normal)
                
                DispatchQueue.main.async(execute: {() -> Void in
                    if self.videoPath != nil || self.videoPath != ""{
                        self.newVideoPath = self.videoPath
                        _ = try! Data(contentsOf: NSURL(fileURLWithPath: self.newVideoPath!) as URL)
                    }
                    
                    let formatter: DateFormatter = DateFormatter()
                    formatter.dateFormat = "dd-MM-yyyy-HH-mm-ss"
                    let dateTimePrefix: String = formatter.string(from: Date())
                    let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
                    let documentsDirectory = paths[0] as String
                    
                    let  CompressedVideoPath = "\(documentsDirectory)/\(dateTimePrefix).mov"
                    let CompressedURL = NSURL(fileURLWithPath: CompressedVideoPath)
                    self.compressVideo(NSURL(fileURLWithPath:self.newVideoPath!) as URL, outputURL: CompressedURL as URL,handler: {
                        (response) in
                        
                        
                    })
                    do{
                        self.playing = true
                      //  try self.playVideo()
                        
                        
                        
                    }
                    catch {
                        print("Try Again")
                    }
                    
                })


            }
           // self.trimButton.isHidden = false //forthetime

        }
            
            
        else  {
            
            self.navigationController?.setNavigationBarHidden(true, animated: false)
            self.tabBarController?.tabBar.isHidden = true
            self.view_Popup.isHidden = true
             self.playVideoFromProfile()
        }
    }
    
    }
    
    
    
    @IBAction func VideoPlayFromGallary(_ sender: Any) {
       
        DispatchQueue.main.async {
            self.videoTrim()

           
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.async {

        Global.macros.statusBar.isHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationItem.setHidesBackButton(true, animated:true)
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        
        bool_VideoFromGallary = false
        bool_PlayFromProfile = false
        self.navigationController?.setNavigationBarHidden(false, animated: false)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    enum AppError : Error{
        case invalidResource(String, String)
    }
    
      //Video Trimmer Delegate Method
    func trimmerView(_ trimmerView: ICGVideoTrimmerView, didChangeLeftPosition startTime: CGFloat, rightPosition endTime: CGFloat) {
        
        self.btn_PlayFromGallary.setTitle("PLAY", for: .normal)
        self.avplayer.pause()
       // self.playing = false
        stopPlaybackTimeChecker()
        trimmerView.hideTracker(true)
        if StartTime != startTime {
            //then it moved the left position, we should rearrange the bar
           // counter = counter + 1
            seekVideoToPos(startTime)
        }
        else {
            // right has changed
            counter = counter + 1

            //self.playing = false
            seekVideoToPos(endTime)
        }
        StartTime = startTime
        stopTime = endTime


    }
    
    //  Converted with Swiftify v1.0.6423 - https://objectivec2swift.com/
    func stopPlaybackTimeChecker() {
        if (playbackTimeCheckerTimer != nil) {
            playbackTimeCheckerTimer?.invalidate()
            playbackTimeCheckerTimer? = Timer()
        }
    }

    
    func seekVideoToPos(_ pos: CGFloat) {
        self.videoPlaybackPosition = pos
        let time: CMTime = CMTimeMakeWithSeconds(Float64(self.videoPlaybackPosition),  self.avplayer.currentTime().timescale)
         self.avplayer.seek(to: time, toleranceBefore: kCMTimeZero, toleranceAfter: kCMTimeZero)
    }
    
    func startPlaybackTimeChecker() {
        stopPlaybackTimeChecker()
        playbackTimeCheckerTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.onPlaybackTimeCheckerTimer), userInfo: nil, repeats: true)
    }

    func onPlaybackTimeCheckerTimer() {
        let curTime: CMTime = player.currentTime()
        var seconds: Float64 = CMTimeGetSeconds(curTime)
        if seconds < 0 {
            seconds = 0
            // this happens! dont know why.
        }
        videoPlaybackPosition = CGFloat(seconds)
        trimmerView.seek(toTime: videoPlaybackPosition)
        if videoPlaybackPosition >= stopTime {
            videoPlaybackPosition = StartTime
            seekVideoToPos(StartTime)
            trimmerView.seek(toTime: StartTime)
        }
    }
    
    func deleteTempFile() {
        let url = URL(fileURLWithPath: self.videoPath!)
        let fm = FileManager.default
        let exist: Bool = fm.fileExists(atPath: url.path)
        var err: Error?
        if exist {
            try? fm.removeItem(at: url)
            print("file deleted")
            if err != nil {
                print("file remove error, \(err?.localizedDescription)")
            }
        }
        else {
            print("no file by that name")
        }
    }

    func videoTrim(){ //AVAssetExportPresetMediumQuality
        
        self.deleteTempFile()
        let asset = AVAsset(url: video_url!)
        let compatiblePresets: [Any] = AVAssetExportSession.exportPresets(compatibleWith: asset)
        
        if compatiblePresets.contains(where: { (AVAssetExportPresetMediumQuality) -> Bool in
            return true
        }) {
            exportSession = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetPassthrough)
            
            // Implementation continues.  URL.fileURL(withPath: self.videoPath)
            let furl = URL.init(fileURLWithPath: self.videoPath!)
            exportSession.outputURL = furl
            exportSession?.outputFileType = AVFileTypeQuickTimeMovie
            
            let start: CMTime = CMTimeMakeWithSeconds(Float64(StartTime), asset.duration.timescale)
            let duration: CMTime = CMTimeMakeWithSeconds(Float64(stopTime) - Float64(StartTime), asset.duration.timescale)
            let range: CMTimeRange = CMTimeRangeMake(start, duration)
            exportSession.timeRange = range
            
            exportSession.exportAsynchronously(completionHandler: {() -> Void in
                switch self.exportSession.status {
                case .failed:
                    print("Export failed: \(self.exportSession.error?.localizedDescription)")
                case .cancelled:
                    print("Export canceled")
                default:
                    print("NONE")
                }
                self.playVideoFromGallery()
            })
        }
        
    
    }
    
    
    //MARK: -  Button actions
    @IBAction func Action_PlayAgain(_ sender: UIButton) {
        
        img_Thumbnail.isHidden = true
        
        if bool_VideoFromGallary == true {
          
            
            if self.avplayer.rate == 1.0 {
                    self.playing = false
                    self.btn_PlayFromGallary.setTitle("PLAY", for: .normal)
                    self.avplayer.pause()
                } else {
                    
                    if self.playing == true  || counter == 1 {
                        
                        do{
                             self.playing = false
                            counter = counter + 1
                            try self.playVideo()
                        }
                        catch{
                            print("Try Again")
                        }
                    }
                    else{
                        
                        self.avplayer.play()
                        self.btn_PlayFromGallary.setTitle("PAUSE", for: .normal)
                        
                    
                }
                }
                
         
        }
            
        else {
            
            if self.avplayer.rate == 1.0 {
                playing = false
                btn_PlayAgain.setTitle("PLAY", for: .normal)
                self.avplayer.pause()
                //               if bool_VideoFromGallary == true {
                //            self.stopPlaybackTimeChecker()
                //            }
                //
            } else {
                
                if playing == true   {
                    
                    do{
                        try self.playVideo()
                    }
                    catch{
                        print("Try Again")
                    }
                }
                else{
                    
                    self.avplayer.play()
                    btn_PlayAgain.setTitle("PAUSE", for: .normal)
                    
                }
            }
            
        }
    }
    
    //When upload video
    @IBAction func UploadVideo(_ sender: UIButton) {
        
        if self.checkInternetConnection(){
            DispatchQueue.main.async {
                self.pleaseWait()
            }
            
            
            
            
            let formatter: DateFormatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy-HH-mm-ss"
            let dateTimePrefix: String = formatter.string(from: Date())
            
            do
            {
                
                let headers : HTTPHeaders = [
                    "Application-Token" : "IPHONE_6zJxK4AMDpahM3Yd7xARGPfRhcWbAkcY9dsfhu1sdF",
                    "Application-Type" : "IPHONE",
                    "Session-Token" :(SavedPreferences.value(forKey:"sessionToken")as? String)!,
                    "Device-Token":deviceTokenString
                ]
                
                print(headers)
                
                let user_id = "\(((SavedPreferences.object(forKey: Global.macros.kUserId))!))"
                
                
                //  self.url = try URLRequest(url: "http://115.248.100.76:8013/user/api/uploadVideo", method: .post) as NSURLRequest
                self.url = try URLRequest(url: "http://115.248.100.76:8013/user/api/uploadVideo", method: .post , headers: headers) as NSURLRequest
                
                
                Alamofire.upload(multipartFormData:{
                    (multipartFormData)-> Void in
                    
                    
                    if self.videoData != nil {
                        
                        (multipartFormData.append(self.videoData!, withName: "video", fileName: "\(dateTimePrefix).mov", mimeType: "video/mov"))
                        multipartFormData.append((user_id.data(using:String.Encoding.utf8)!), withName: Global.macros.kUserId)
                    }
                    else {
                        self.clearAllNotice() //hide loader
                        self.showAlert(Message: "Unable to upload video. Please try again.", vc: self)
                        
                        
                    }
                    
                    
                }, with:url as URLRequest, encodingCompletion: {
                    (encodingResult) in
                    switch encodingResult
                    {
                    case .success(let upload, _, _):
                        upload.responseString(completionHandler:{  (response) in
                            
                            print(response)
                            //to get status code
                            if let status = response.response?.statusCode {
                                switch(status){
                                case 200:
                                    // move to newsfeed screen
                                 
                   if (SavedPreferences.value(forKey: "role") as? String) == "USER" {
                    
                    self.performSegue(withIdentifier: "a", sender: self)
                    self.showAlert(Message: "Uploaded successfully", vc: self)
                    self.avplayer.pause()
                    Global.macros.statusBar.isHidden = false

                    
                   }
                   
                   else {
                    
                    self.navigationController?.setNavigationBarHidden(false, animated: false)
                    self.performSegue(withIdentifier: "b", sender: self)
                    
                    self.showAlert(Message: "Uploaded successfully", vc: self)
                    self.avplayer.pause()
                    Global.macros.statusBar.isHidden = false

                   }
                                    break
                                case 401:
                                    self.AlertSessionExpire()
                                    break
                                case 400:
                                    
                                    self.showAlert(Message: "Something went wrong.Please try again later.", vc: self)
      
                                    break
                                    
                                default:
                                    break
                                }
                            }
                           
                          
                           
                            
                        })
                        upload.uploadProgress(closure:
                            {
                                (progress) in
                        })
                    case .failure(let encodingError):
                        print(encodingError)
                    }
                })
            }
            catch{
                print(error)
            }
        }else{
            
            self.showAlert(Message: Global.macros.kInternetConnection, vc: self)
            
            
        }
    }
    
    @IBAction func Action_Cancel(_ sender: UIButton) {
        DispatchQueue.main.async {
            self.player.pause()
            self.avplayer.pause()
            Global.macros.statusBar.isHidden = false

        self.view_Popup.isHidden = true
        let vc = Global.macros.Storyboard.instantiateViewController(withIdentifier: "SWRevealViewController")as!  SWRevealViewController
        Global.macros.kAppDelegate.window?.rootViewController = vc
        }
        
    }
    
    @IBAction func Action_BackButton(_ sender: Any) {
        DispatchQueue.main.async {
       
        self.playerLayer.removeFromSuperlayer()
        self.avplayerlayer.removeFromSuperlayer()
            self.avplayer.pause()
            self.avplayer = AVPlayer()
            self.player.pause()
            self.player = AVPlayer()
            Global.macros.statusBar.isHidden = false

        let vc = Global.macros.Storyboard.instantiateViewController(withIdentifier: "SWRevealViewController")as!  SWRevealViewController
        Global.macros.kAppDelegate.window?.rootViewController = vc
        }
    }
    
    //MARK: - AVAssetExportSession Functions
    func compressVideo(_ inputURL: URL,outputURL:URL ,handler completion: @escaping (AVAssetExportSession) -> Void) {
        
        uploadVideo_rightOrientation(inputURL)
//
//        let urlAsset = AVURLAsset.init(url: inputURL)
//        let exportSession = AVAssetExportSession(asset: urlAsset, presetName: AVAssetExportPresetMediumQuality)
//        
//        exportSession?.outputURL = outputURL
//        
//        
//        exportSession?.outputFileType = AVFileTypeMPEG4
//        exportSession?.shouldOptimizeForNetworkUse = true
//        
//        exportSession?.exportAsynchronously(completionHandler: {() -> Void in
//            completion(exportSession!)
//            
//          
//            
//        })
    }
    
    //MARK: - Functions
    //When only play video from profile
    func playVideoFromProfile() {
        
        player = AVPlayer(url: video_url!)
        if bool_PlayFromProfile == true {
        
        DispatchQueue.main.async {
            
            self.pleaseWait()
        }
        }
        
        //  player.addObserver(self, forKeyPath: "status", options: [], context: nil)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame =  CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        
        self.view.layer.addSublayer(playerLayer)
        
        if bool_PlayFromProfile == true {
            DispatchQueue.main.async {

        self.view.bringSubview(toFront: self.btn_Back)
        self.view.bringSubview(toFront: self.img_Back)
        
        self.btn_Back.isHidden = false
        self.img_Back.isHidden = false
            
                
                
            }
        }
        else{
            DispatchQueue.main.async {

            self.SetButtonCustomAttributesPurple(self.btn_Upload)
            self.btn_Upload.isUserInteractionEnabled = true

            self.view.addSubview(self.view_Popup)
            self.view_Popup.addSubview(self.btn_PlayAgain)
            self.view_Popup.addSubview(self.btn_Upload)
            self.view_Popup.addSubview(self.btn_Cancel)
                
                self.SetButtonCustomAttributesPurpleGallery(self.btn_UploadFromGallary)
                self.btn_UploadFromGallary.isUserInteractionEnabled = true
                
                self.view_Popup.addSubview(self.btn_PlayFromGallary)
                self.view_Popup.addSubview(self.btn_UploadFromGallary)
                self.view_Popup.addSubview(self.btn_CancelFromGallary)
                self.view_Popup.addSubview(self.btn_VideoPlayFromGallery)

                
            }
        }
        
        
        NotificationCenter.default
            .addObserver(self, selector: #selector(playerItemDidStart), name:NSNotification.Name.AVPlayerItemNewAccessLogEntry , object: nil)
        
        NotificationCenter.default
            .addObserver(self, selector: #selector(playerItemDidReachEnd), name:NSNotification.Name.AVPlayerItemDidPlayToEndTime , object: nil)
        
        player.play()
        
    }
    
    func playVideoFromGallery() {
        

        DispatchQueue.main.async(execute: {() -> Void in
            if self.videoPath != nil || self.videoPath != ""{
                self.newVideoPath = self.videoPath
                _ = try! Data(contentsOf: NSURL(fileURLWithPath: self.newVideoPath!) as URL)
            }
            
            let formatter: DateFormatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy-HH-mm-ss"
            let dateTimePrefix: String = formatter.string(from: Date())
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            let documentsDirectory = paths[0] as String
            
            let  CompressedVideoPath = "\(documentsDirectory)/\(dateTimePrefix).mov"
            let CompressedURL = NSURL(fileURLWithPath: CompressedVideoPath)
            self.compressVideo(NSURL(fileURLWithPath:self.newVideoPath!) as URL, outputURL: CompressedURL as URL,handler: {
                (response) in
                
                
            })
            do{
                
                try self.playVideo()
                
                
                
            }
            catch {
                print("Try Again")
            }
            
        })

    }
    
    // When upload video
    func playVideo() throws {
        
        btn_PlayAgain.setTitle("PAUSE", for: .normal)
        btn_PlayFromGallary.setTitle("PAUSE", for: .normal)

        
        guard let path = newVideoPath // path for the video file
            else
        {
            throw AppError.invalidResource("video", "mov")
        }
        let avasset = AVAsset(url: URL(fileURLWithPath: path))
        self.avplayeritem = AVPlayerItem.init(asset: avasset) // player item is initalised with the path of file
        self.avplayer = AVPlayer.init(playerItem: self.avplayeritem)// player is initialised with the player item`
         avplayerlayer = AVPlayerLayer.init(player: self.avplayer)    // player layer is initialised with the player
        avplayerlayer.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        avplayerlayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        self.view.layer.addSublayer(avplayerlayer) // sublayer is added on the view
        
        self.view.addSubview(self.view_Popup)
        self.view_Popup.addSubview(self.btn_PlayAgain)
        self.view_Popup.addSubview(self.btn_Upload)
        self.view_Popup.addSubview(self.btn_Cancel)
        self.view.bringSubview(toFront: self.trimmerView)
        
        self.view_Popup.addSubview(self.btn_PlayFromGallary)
        self.view_Popup.addSubview(self.btn_CancelFromGallary)
        self.view_Popup.addSubview(self.btn_UploadFromGallary)
        self.view_Popup.addSubview(self.btn_VideoPlayFromGallery)

 
        NotificationCenter.default
            .addObserver(self, selector: #selector(playerItemDidReachEnd), name:NSNotification.Name.AVPlayerItemDidPlayToEndTime , object: nil)
        self.avplayer.play()
        
    }
    
    func playerItemDidReachEnd(notification: NSNotification) {
        
        if bool_PlayFromProfile == false || bool_VideoFromGallary == true {
            playing = true
            btn_PlayAgain.setTitle("PLAY", for: .normal)
            btn_PlayFromGallary.setTitle("PLAY", for: .normal)
        }
            
        else  {
            
            let vc = Global.macros.Storyboard.instantiateViewController(withIdentifier: "SWRevealViewController")as!  SWRevealViewController
            Global.macros.kAppDelegate.window?.rootViewController = vc
        }
        
    }
    
    func playerItemDidStart(notification: NSNotification) {
        
        if player.status == .readyToPlay {
            DispatchQueue.main.async {
                
                self.clearAllNotice()
                
            }
        }
    }

    
    func uploadVideo_rightOrientation(_ videoToTrimURL: URL)
    {
        let videoAsset = AVURLAsset(url: videoToTrimURL, options: nil)
        
        let sourceAudioTrack: AVAssetTrack? = (videoAsset.tracks(withMediaType: AVMediaTypeAudio)[0])// as? AVAssetTrack
        let composition = AVMutableComposition()
        let compositionAudioTrack: AVMutableCompositionTrack? = composition.addMutableTrack(withMediaType: AVMediaTypeAudio, preferredTrackID: kCMPersistentTrackID_Invalid)
        try? compositionAudioTrack?.insertTimeRange(CMTimeRangeMake(kCMTimeZero, videoAsset.duration), of: sourceAudioTrack!, at: kCMTimeZero)
        let assetExport = AVAssetExportSession(asset: composition, presetName: AVAssetExportPresetMediumQuality)
        
//        let paths: [String] = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
//        outputURL_new = paths[0]
//        outputURL_new = URL(fileURLWithPath: outputURL_new!).appendingPathComponent("output.mp4").absoluteString
        
        let documentsDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let myDocumentPath = NSURL(fileURLWithPath: documentsDirectory).appendingPathComponent("video.mp4")?.absoluteString
        let url = NSURL(fileURLWithPath: myDocumentPath!)
        
        let documentsDirectory2 = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0] as NSURL
        
        let filePath = documentsDirectory2.appendingPathComponent("video.mp4")
        deleteFile(filePath: filePath! as NSURL)
        
        //Check if the file already exists then remove the previous file
        if FileManager.default.fileExists(atPath: myDocumentPath!) {
            do {
                try FileManager.default.removeItem(atPath: myDocumentPath!)
            }
            catch let error {
                print(error)
            }
        }

        assetExport?.outputFileType = AVFileTypeMPEG4
        assetExport?.outputURL = filePath
        assetExport?.shouldOptimizeForNetworkUse = true
        assetExport?.videoComposition = getVideoComposition(videoAsset, composition: composition)
        let timeRange: CMTimeRange = CMTimeRangeMake(kCMTimeZero, videoAsset.duration)
        assetExport?.timeRange = timeRange
        assetExport?.exportAsynchronously(completionHandler: {
            
            //case is always .failed
            switch assetExport!.status {
            case .completed:
                let urlString: String = filePath!.path
                self.videoData = FileManager.default.contents(atPath: urlString )
                
                DispatchQueue.main.async {
                    self.SetButtonCustomAttributesPurple(self.btn_Upload)
                    self.btn_Upload.isUserInteractionEnabled = true
 
                    self.SetButtonCustomAttributesPurpleGallery(self.btn_UploadFromGallary)
                    self.btn_UploadFromGallary.isUserInteractionEnabled = true
                  
                }
             
            case .failed:
                print("failed")
                print(assetExport!.error!)
            default:
                print("something else")
            }
        })

//        assetExport?.exportAsynchronously(completionHandler: {(_: Void) -> Void in
//            switch assetExport?.status {
//            case .completed:
//                videoData = FileManager.default.contents(atPath: outputURL_new)
//                print("Export Complete \(Int(assetExport.status)) \(assetExport.error)")
//            case .failed:
//                print("Failed:\(assetExport?.error)")
//            case .cancelled:
//                print("Canceled:\(assetExport?.error)")
//            default:
//                break
//            }
//            
//        })

    }
    func getVideoComposition(_ asset: AVAsset, composition: AVMutableComposition) -> AVMutableVideoComposition
    {
        let isPortrait_: Bool = isVideoPortrait(asset)
        let compositionVideoTrack: AVMutableCompositionTrack? = composition.addMutableTrack(withMediaType: AVMediaTypeVideo, preferredTrackID: kCMPersistentTrackID_Invalid)
        let videoTrack: AVAssetTrack? = (asset.tracks(withMediaType: AVMediaTypeVideo)[0])// as? AVAssetTrack
        try? compositionVideoTrack?.insertTimeRange(CMTimeRangeMake(kCMTimeZero, asset.duration), of: videoTrack!, at: kCMTimeZero)
        let layerInst = AVMutableVideoCompositionLayerInstruction(assetTrack: compositionVideoTrack!)
        let transform: CGAffineTransform? = videoTrack?.preferredTransform
        layerInst.setTransform(transform!, at: kCMTimeZero)
        let inst: AVMutableVideoCompositionInstruction = AVMutableVideoCompositionInstruction()
       // let inst = AVMutableVideoCompositionInstruction.videoCompositionInstruction
        inst.timeRange = CMTimeRangeMake(kCMTimeZero, asset.duration)
        inst.layerInstructions = [layerInst]
        let videoComposition: AVMutableVideoComposition = AVMutableVideoComposition()

//        let videoComposition = AVMutableVideoComposition.videoComposition
        videoComposition.instructions = [inst]
        var videoSize: CGSize = videoTrack!.naturalSize
        if isPortrait_ {
            print("video is portrait ")
            videoSize = CGSize(width: CGFloat(videoSize.height), height: CGFloat(videoSize.width))
        }
        videoComposition.renderSize = videoSize
        videoComposition.frameDuration = CMTimeMake(1, 30)
        videoComposition.renderScale = 1.0
        return videoComposition

    }
    
    func isVideoPortrait(_ asset: AVAsset) -> Bool {
        var isPortrait: Bool = false
        let tracks: [Any] = asset.tracks(withMediaType: AVMediaTypeVideo)
        if tracks.count > 0 {
            let videoTrack: AVAssetTrack? = (tracks[0] as? AVAssetTrack)
            let t: CGAffineTransform? = videoTrack?.preferredTransform
            // Portrait
            if t?.a == 0 && t?.b == 1.0 && t?.c == -1.0 && t?.d == 0 {
                isPortrait = true
            }
            // PortraitUpsideDown
            if t?.a == 0 && t?.b == -1.0 && t?.c == 1.0 && t?.d == 0 {
                isPortrait = true
            }
            // LandscapeRight
            if t?.a == 1.0 && t?.b == 0 && t?.c == 0 && t?.d == 1.0 {
                isPortrait = false
            }
            // LandscapeLeft
            if t?.a == -1.0 && t?.b == 0 && t?.c == 0 && t?.d == -1.0 {
                isPortrait = false
            }
        }
        return isPortrait
    }
    
    func getVideoOrientation(from asset: AVAsset) -> UIImageOrientation {
        
        let videoTrack: AVAssetTrack? = (asset.tracks(withMediaType: AVMediaTypeVideo)[0])// as? AVAssetTrack
        let size: CGSize? = videoTrack?.naturalSize
        let txf: CGAffineTransform? = videoTrack?.preferredTransform
        if size?.width == txf?.tx && size?.height == txf?.ty {
            return .left
        }
        else if txf?.tx == 0 && txf?.ty == 0 {
            return .right
        }
        else if txf?.tx == 0 && txf?.ty == size?.width {
            return .down
        }
        else {
            return .up
        }
        
        //return UIInterfaceOrientationPortrait;
    }
    
    
    func deleteFile(filePath:NSURL) {
        guard FileManager.default.fileExists(atPath: filePath.path!) else {
            return
        }
        
        
        do {
            try FileManager.default.removeItem(atPath: filePath.path!)
        }catch{
            fatalError("Unable to delete file: \(error) : \(#function).")
        }
    }


//    func clearTmpDirectory() {
//        do {
//             let exportPath: NSString = NSTemporaryDirectory().appendingFormat("video.mp4")
//            let tmpDirectory = try FileManager.default.contentsOfDirectory(atPath: exportPath as String)
//            try tmpDirectory.forEach { file in
//                let path = String.init(format: "%@%@", NSTemporaryDirectory(), file)
//                try FileManager.default.removeItem(atPath: path)
//            }
//        } catch {
//            print(error)
//        }
//    }

    
//    func removeVideo(_ filename: String)
//
//    {
//        
//        let filemanager = FileManager.default
//        _ = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask,true)[0] as NSString
//        let exportPath: NSString = NSTemporaryDirectory().appendingFormat("video.mp4")
//        try filemanager.removeItem(atPath: exportPath as String)
//        
//        
////        if success != nil
////        {
////            
////        }
////        else {
////            print("Could not delete file ")
////        }
//
//    }
//    
   

}

