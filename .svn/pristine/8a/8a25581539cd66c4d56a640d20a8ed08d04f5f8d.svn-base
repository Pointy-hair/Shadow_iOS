//
//  CameraViewController.swift
//  CameraDemo
//
//  Created by Atinderjit Kaur on 01/06/17.
//  Copyright © 2017 Aditi. All rights reserved.
//

import UIKit
import AVFoundation


struct Platform
{
    static var isSimulator: Bool
    {
        return TARGET_OS_SIMULATOR != 0
    }
}

class CameraViewController: UIViewController,AVCaptureFileOutputRecordingDelegate {
    
    
    @IBOutlet var btn_Flash: UIButton!
    @IBOutlet var btn_CameraType: UIButton!
    @IBOutlet var btn_CloseCamera: UIButton!
    @IBOutlet var displayTimeLabel: UILabel!
    @IBOutlet var longpressGesture: UILongPressGestureRecognizer!
    @IBOutlet var imgView_recordVideo: UIImageView!
    
    
    var delegate : AVCaptureFileOutputRecordingDelegate?
    var captureSession:AVCaptureSession?
    var input: AVCaptureDeviceInput!
    var backCamera = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
    var audioCaptureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeAudio)
    var stillImageOutput: AVCaptureStillImageOutput?
    var audioInput:AVCaptureDeviceInput!
    var previewLayer: AVCaptureVideoPreviewLayer?
    var torchIsOn = false
    var backcameraOn = true
    var filePath:String?
    var fileOutput : AVCaptureFileOutput!
    var startTime = TimeInterval()
    var timer = Timer()
    var videoPath:String?
    var sec = Int()
    
     override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
            // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
      
         loadCamera()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - Functions
    func loadCamera(){
        
        displayTimeLabel.text = "00:00"
        captureSession = AVCaptureSession()
        captureSession!.sessionPreset = AVCaptureSessionPresetHigh
        var error: NSError?
        do {
            input = try AVCaptureDeviceInput(device: backCamera) // initialising the video input
            audioInput = try AVCaptureDeviceInput(device: audioCaptureDevice) //initialising the audio input
            
        } catch let error1 as NSError {
            error = error1
            input = nil
            //print("Camera" + error!.localizedDescription)
        }
        if (audioInput != nil){
            DispatchQueue.main.async {
                
                self.captureSession?.addInput(self.audioInput)
            }// adding the audio input in the session
        }
        
        if error == nil && captureSession!.canAddInput(input){
            
            DispatchQueue.main.async {
                self.captureSession!.addInput(self.input) // adding the video input in the session
                self.stillImageOutput = AVCaptureStillImageOutput()
                //stillImageOutput!.outputSettings = [AVVideoCodecKey : AVVideoCodecJPEG]
                if self.captureSession!.canAddOutput(self.stillImageOutput){
                    self.captureSession!.addOutput(self.stillImageOutput)
                    self.previewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession) // PreviewLayer for the Video screen
                    self.previewLayer!.videoGravity = AVLayerVideoGravityResizeAspectFill
                    self.previewLayer!.connection.videoOrientation = AVCaptureVideoOrientation.portrait
                    self.previewLayer?.frame = self.view.bounds
                    self.view.layer.addSublayer(self.previewLayer!) // ading the preview layer on he self view
                    // adding required components on the custom camera view
                    self.view.addSubview(self.imgView_recordVideo)
                    self.view.addSubview (self.btn_Flash)
                    self.view.addSubview(self.btn_CameraType)
                    self.view.addSubview(self.displayTimeLabel)
                    self.view.addSubview(self.btn_CloseCamera)
                    self.captureSession!.startRunning()
                }
            }
            
        }
    }
    
    //Video recording starts
    func recordVideo(){
        if Platform.isSimulator{
            
            // SCLAlertView().showInfo("vTube", subTitle: "Simulator cannot run Camera.")
            print("Can't run on simulator")
        }
        else{
            captureSession?.beginConfiguration()
            delegate = self
            let formatter: DateFormatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy-HH-mm-ss"
            let dateTimePrefix: String = formatter.string(from: Date())
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            let documentsDirectory = paths[0] as String
            filePath = "\(documentsDirectory)/\(dateTimePrefix).mov"
            let fileManager = FileManager.default
            fileOutput = AVCaptureMovieFileOutput.init()
            
            let connection = fileOutput.connection(withMediaType: AVMediaTypeVideo)
            connection?.videoOrientation = .portrait
            
            self.captureSession!.addOutput(fileOutput)
            captureSession?.commitConfiguration()
            if !fileManager.fileExists(atPath: filePath!){
               videoPath = filePath
                self.fileOutput.startRecording(toOutputFileURL: URL(fileURLWithPath: filePath!), recordingDelegate: delegate)
            }
            else{
                print("file already exists")
            }
        }
    }
    
    //Updation of Timer on Custom Camera Screen
    func updateTime(){
        let currentTime = Date.timeIntervalSinceReferenceDate
        //Find the difference between current time and start time.
        var elapsedTime: TimeInterval = currentTime - startTime
        //calculate the seconds in elapsed time.
        let seconds = UInt8(elapsedTime)
        elapsedTime -= TimeInterval(seconds)
        //find out the fraction of milliseconds to be displayed.
        let fraction = UInt8(elapsedTime * 100)
        let strSeconds = String(format: "%02d", seconds)
        let strFraction = String(format: "%02d", fraction)
        
        //concatenate minuets, seconds and milliseconds as assign it to the UILabel
        displayTimeLabel.text = "\(strSeconds): \(strFraction)"
        sec = Int(seconds)
        print(sec)
    }
    
    
    //MARK: - Button Actions
    @IBAction func action_CameraFlash(_ sender: UIButton) {
        torchIsOn = true
        // check if the device has torch
        if (backCamera?.hasTorch)! {
            // lock your device for configuration
            do {
                try backCamera?.lockForConfiguration()
            } catch {
                print("aaaa")
            }
            // check if your torchMode is on or off. If on turns it off otherwise turns it on
            if (backCamera?.isTorchActive)! // if torch is ON
            {
                sender.setImage(UIImage(named:"white-icon.png"), for: UIControlState())
                backCamera?.torchMode = AVCaptureTorchMode.off
                torchIsOn = false
            }
            else{
                // if torch is off
                sender.setImage(UIImage(named:"yellow-icon.png"), for: UIControlState())
                // sets the torch intensity to 100%
                do {
                    try backCamera?.setTorchModeOnWithLevel(1.0)
                    torchIsOn = true
                } catch {
                    print("bbb")
                }
            }
            // unlock your device
            backCamera?.unlockForConfiguration()
        }
        
    }
    
    
    @IBAction func action_changeCameraType(_ sender: UIButton) {
        let VideoDevices = AVCaptureDevice.devices(withMediaType: AVMediaTypeVideo)
        self.previewLayer?.removeFromSuperlayer()
        if backcameraOn{
            for device in VideoDevices!{
                let device = device as! AVCaptureDevice
                if device.position == AVCaptureDevicePosition.front // to run front camera
                {
                    backCamera = device
                    backcameraOn = false
                    loadCamera()
                    break
                }
            }
        }
        else{
            for device in VideoDevices!
            {
                let device = device as! AVCaptureDevice
                if device.position == AVCaptureDevicePosition.back // to run backcamera
                {
                    backCamera = device
                    backcameraOn = true
                    loadCamera()
                    break
                }
            }
        }
        
    }
    
    
    @IBAction func action_CloseCameraView(_ sender: UIButton) {
        
      _ = self.navigationController?.popViewController(animated: true)
        
    }
    
    
    @IBAction func gesture_Tap(_ sender: UITapGestureRecognizer) {
        
        print("Please long press to record.")
    }
    
    
    
    @IBAction func gesture_LongPress(_ sender: UILongPressGestureRecognizer) {
        
        if sender.state == UIGestureRecognizerState.began{
            self.recordVideo()
           
        }
        if sender.state == UIGestureRecognizerState.ended{
            
            self.fileOutput.stopRecording()
          
            if sec < 10{
                let TitleString = NSAttributedString(string: "SHADOW", attributes: [
                    NSFontAttributeName : UIFont.systemFont(ofSize: 18),
                    NSForegroundColorAttributeName : Global.macros.themeColor
                    ])
                let MessageString = NSAttributedString(string: "Video should be more than 10 seconds.", attributes: [
                    NSFontAttributeName : UIFont.systemFont(ofSize: 15),
                    NSForegroundColorAttributeName : Global.macros.themeColor
                    ])
                
                DispatchQueue.main.async {
                    self.clearAllNotice()
                    
                    let alert = UIAlertController(title: "SHADOW", message: "Video should be more than 10 seconds.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action) in
                        
                        self.displayTimeLabel.text = "00:00"
                        self.loadCamera()
                        
                    }))
                    
                    alert.view.backgroundColor = UIColor.white
                    alert.view.tintColor = Global.macros.themeColor
                    
                    alert.setValue(TitleString, forKey: "attributedTitle")
                    alert.setValue(MessageString, forKey: "attributedMessage")
                    self.present(alert, animated: true, completion: nil)
                }
            }
           
        }
        
    }
    
    
    //MARK: Delegate Mthods Of AVCaptureFileOutputRecording
    func capture(_ captureOutput: AVCaptureFileOutput!, didFinishRecordingToOutputFileAt outputFileURL: URL!, fromConnections connections: [Any]!, error: Error!)
    {
        if (backCamera?.hasTorch)! {
            // lock your device for configuration
            do {
                try backCamera?.lockForConfiguration()
            } catch {
                //print("aaaa")
            }
            
            // check if your torchMode is on or off. If on turns it off otherwise turns it on
            if (backCamera?.isTorchActive)! {
                //  btn_Flash.setImage(UIImage (named: "White-icon.png"), forState: .Normal)
                backCamera?.torchMode = AVCaptureTorchMode.off
            }
            backCamera?.unlockForConfiguration()
        }
        timer.invalidate()
        let objects = NSArray(contentsOfFile: filePath!)
        objects?.write(toFile: filePath!, atomically: false)
        //Saving video to photo album
        videoPath = filePath
        
        //Moving to the upload Screen
        self.performSegue(withIdentifier: "UploadVideo", sender: self)
        
         return
    }
    
    func capture(_ captureOutput: AVCaptureFileOutput!, didStartRecordingToOutputFileAt fileURL: URL!, fromConnections connections: [Any]!){
        print("recording starts")
        if (backCamera?.hasTorch)! {
            do {
                try backCamera?.lockForConfiguration()
                if torchIsOn{
                    backCamera?.torchMode = AVCaptureTorchMode.on
                }
                else{
                    backCamera?.torchMode = AVCaptureTorchMode.off
                }
            }
            catch {
                print(error)
            }
            backCamera?.unlockForConfiguration()
        }
        //Timer set for video recording
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(CameraViewController.updateTime), userInfo: nil, repeats: true)
        print(timer)
        startTime = Date.timeIntervalSinceReferenceDate
       // captureOutput.maxRecordedDuration = CMTimeMake(10, 1)//
        /* After 60 seconds, let's stop the recording process */
        let delayInSeconds = 54.2
        let delayInNanoSeconds = DispatchTime.now() + Double(Int64(delayInSeconds * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: delayInNanoSeconds, execute: {
            captureOutput.stopRecording()
        })
        return
    }
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "UploadVideo"{
            
            let vc =  segue.destination as! UploadViewController
            vc.videoPath = videoPath
        }
        
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
    
    
}
