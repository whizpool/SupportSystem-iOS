//
//  ViewController.swift
//  LogFilePodProj
//
//  Created by Uzair Masood on 18/02/2022.
//

import UIKit
import MessageUI
import SSZipArchive

public class MainViewController: UIViewController {
    
    // ********************* Outlets *********************//
    // MARK: - View controller Outlets
    
    // Tittle Label Outlet
    @IBOutlet var titile_lbl: UILabel!
    
    // Send Button outlet
    @IBOutlet var send_btn_outlet: UIButton!
    
    // skip button outlet
    @IBOutlet var skip_btn_outlet: UIButton!
    
    // main view outlet
    @IBOutlet var main_dialogBox_view: UIView!
    
    // Email Button Outlet
    @IBOutlet var email_btn_outlet: UIButton!
    
    // Bugs TextView Outlet
    @IBOutlet var BugsTextview: UITextView!
    
    // ********************* Variables *********************//
    
    // zip folder path
    var appendZipFolderPath = "/NewZip"
    
    // log folder path
    var appendRootFolderPath = "Logs/"
    
    // Email Subject for mail composer
    var emailSubject = "Email Sends To Developers"
    
    // Textview Placeholder
    var prefilledTextviewText = "Write here about your bug detail"
    
    // ********************* ViewDidLoad *********************//
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        // dailog box hidden
        main_dialogBox_view.isHidden = true
        
        // initilization and create Folder in Directory
        SLog.shared.initilization()
        
        // Write Logs in Logs File with message
        SLog.shared.log(text: "Hello Buddy")
        SLog.shared.log(text: "Hi")
        SLog.shared.log(text: "Yes Please")
        SLog.shared.log(text: "No")
        
        // function Textview Editing Calls
        SLog.shared.setpassword(password: "QWERTY")
        
        // Textview Editing function
        textviewEditing()
    }
    
    // ********************* Actions *********************//
    
    // Send Button Action where we can check textview is empty or check text is equal to placeholder when both condition are ture we can show alert message Bug Detail is Missing if condition is false then we can proceed further
    
    @IBAction func send_btn_action(_ sender: UIButton) {
        if BugsTextview.text.isEmpty || BugsTextview.text == prefilledTextviewText{
            
            // show alert when textview is empty
            let alert = UIAlertController(title: "Alert", message: "Bug Detail is Missing", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else{
            let recieverEmail = SLog.shared.sendToEmail
            guard MFMailComposeViewController.canSendMail()  else {
                return
            }
            let composer = MFMailComposeViewController()
            composer.mailComposeDelegate = self
            composer.setToRecipients([recieverEmail])
            composer.setSubject(emailSubject)
            composer.setMessageBody(BugsTextview.text, isHTML: true)
            let filePath = SLog.shared.getRootDirPath()
            let url = URL(string: filePath)
            let zipPath = url!.appendingPathComponent(appendZipFolderPath)
            do {
                self.createPasswordProtectedZipLogFile(at: zipPath.path, composer: composer)
                
                if MFMailComposeViewController.canSendMail() {
                    self.present(composer, animated: true)
                }
            }
            
        }
    }
    
    // Skip Button Action where we cannot check textview text is equal to textview placeholder then send messageBody empty
    @IBAction func skip_btn_action(_ sender: UIButton) {
        let recieverEmail = SLog.shared.sendToEmail
        guard MFMailComposeViewController.canSendMail()  else {
            return
        }
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients([recieverEmail])
        composer.setSubject(emailSubject)
        composer.setMessageBody("", isHTML: true)
        let filePath = SLog.shared.getRootDirPath()
        let url = URL(string: filePath)
        let zipPath = url!.appendingPathComponent(appendZipFolderPath)
        do {
            self.createPasswordProtectedZipLogFile(at: zipPath.path, composer: composer)
            
            if MFMailComposeViewController.canSendMail() {
                self.present(composer, animated: true)
            }
        }
    }
    
    // close Button Action will close the main view
    @IBAction func close_btn_action(_ sender: UIButton) {
        main_dialogBox_view.isHidden = true
        view.backgroundColor = UIColor.init(named: "gray5")
    }
    
    // Email Button Show main view
    @IBAction func email_log_action(_ sender: UIButton) {
        main_dialogBox_view.isHidden = false
        view.backgroundColor = UIColor(white: 1, alpha: 0.4)
    }
    
    // ********************* Functions *********************//
    
    // combine two files into one and set that file name is finalLog and at the end we can call makeJsonFile function which will create json file
    func combineLogFiles(){
        
        // Delete Zip Folder
        _ = SLog.shared.deleteFile(fileName: SLog.shared.LOG_FILE_New_Folder_DIR_NAME)
        
        let fileManager = FileManager.default
        var files = [String]()
        files.removeAll()
        
        // getting files from Slog Function
        files = SLog.shared.listFilesFromDocumentsFolder()
        
        // arrange Files in orderedAscending
        files = files.sorted(by: { $0.compare($1) == .orderedAscending })
        for file in files{
            //if you get access to the directory
            if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                
                //prepare file url
                let fileURL = dir.appendingPathComponent(appendRootFolderPath)
                
                
                let DirPath = fileURL.appendingPathComponent(SLog.shared.LOG_FILE_New_Folder_DIR_NAME)
                do
                {
                    try FileManager.default.createDirectory(atPath: DirPath.path, withIntermediateDirectories: true, attributes: nil)
                }
                catch let error as NSError
                {
                    print("Unable to create directory \(error.debugDescription)")
                }
                print("Dir Path = \(DirPath)")
                
                
                
                
                
                let newZipDirURL = fileURL.appendingPathComponent(file)
                
                let fileCombine = DirPath.appendingPathComponent(SLog.shared.finalLogFileName_After_Combine)
                
                do{
                    var result = ""
                    result = try String(contentsOf: newZipDirURL, encoding: .utf8)
                    print(result)
                    if fileManager.fileExists(atPath: fileCombine.path){
                        
                        do {
                            if fileManager.fileExists(atPath: fileCombine.path) {
                                // File Available
                                if let fileUpdater = try? FileHandle(forUpdating: fileCombine) {
                                    // Function which when called will cause all updates to start from end of the file
                                    fileUpdater.seekToEndOfFile()
                                    
                                    // Which lets the caller move editing to any position within the file by supplying an offset
                                    fileUpdater.write(result.data(using: .utf8)!)
                                    
                                    // Once we convert our new content to data and write it, we close the file and that’s it!
                                    fileUpdater.closeFile()
                                }
                            }
                        }
                    }
                    else{
                        
                        if (FileManager.default.createFile(atPath: fileCombine.path, contents: nil, attributes: nil)) {
                            print("File created successfully.")
                            do{
                                try result.write(to: fileCombine, atomically: true, encoding: String.Encoding.utf8)
                                
                            }
                            catch{
                                print(error.localizedDescription)
                            }
                        }
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
        
        // make json file
        makeJsonFile()
        
    }
    
    
    
    // Function create zip and create password on it
    func createPasswordProtectedZipLogFile(at logfilePath: String, composer viewController: MFMailComposeViewController)
    {
        var isZipped:Bool = false
        // calling combine all files into one file
        combineLogFiles()
        
        let contentsPath = logfilePath
        
        // create a json file and call a function of makeJsonFile
        if FileManager.default.fileExists(atPath: contentsPath)
        {
            let createZipPath = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(SLog.shared.temp_zipFileName).path
            if SLog.shared.password.isEmpty{
                isZipped = SSZipArchive.createZipFile(atPath: createZipPath, withContentsOfDirectory: contentsPath)
            }
            else{
                isZipped = SSZipArchive.createZipFile(atPath: createZipPath, withContentsOfDirectory: contentsPath, keepParentDirectory: true, withPassword: SLog.shared.password)
            }
            
            if isZipped {
                var data = NSData(contentsOfFile: createZipPath) as Data?
                if let data = data
                {
                    viewController.addAttachmentData(data, mimeType: "application/zip", fileName: SLog.shared.zipFileName)
                }
                data = nil
            }
        }
    }
    
    // Fuction make Json file
    func makeJsonFile(){
        // -> URL
        
        // create empty dict
        var myDict = [String: String]()
        
        // calling function of manufacture,deviceModel,OSInstalled,appVersion and set that functions value in dict
        let manufacture = SLog.getDeviceManufacture()
        let deviceModel = UIDevice.modelName
        let OSInstalled = SLog.getOSInfo()
        let appVersion = SLog.getVersionName()
        var freeSpace:String = ""
        
        // calculate free space of device
        if let Space = SLog.deviceRemainingFreeSpaceInBytes() {
            print("free space: \(Space)")
            print(Units(bytes: Space).getReadableUnit())
            freeSpace = Units(bytes: Space).getReadableUnit()
        } else {
            print("failed")
        }
        
        // Add Values in Dict
        myDict = ["appVersion":appVersion,"OSInstalled":OSInstalled,"deviceModel":deviceModel,"manufacture":manufacture,"freeSpace":freeSpace]
        do{
            try  saveJsonFileInDirectory(jsonObject: myDict, toFilename: SLog.shared.jsonFileName)
        }catch{
            print(error.localizedDescription)
        }
    }
    
    // create json file in directory with specific information of device
    func saveJsonFileInDirectory(jsonObject: Any, toFilename filename: String) throws{
        let fm = FileManager.default
        let urls = fm.urls(for: .documentDirectory, in: .userDomainMask)
        if let url = urls.first {
            var fileURL = url.appendingPathComponent(appendRootFolderPath)
            let zipFolder = fileURL.appendingPathComponent("NewZip/")
            let zipFolderUrl = zipFolder.appendingPathComponent(filename)
            fileURL = zipFolderUrl.appendingPathExtension("json")
            let data = try JSONSerialization.data(withJSONObject: jsonObject, options: [.prettyPrinted])
            try data.write(to: fileURL, options: [.atomicWrite])
        }
    }
    
}

// ********************* Extensions *********************//

// Extension for mail composing delegate
extension MainViewController:MFMailComposeViewControllerDelegate{
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        if let _ = error{
            controller.dismiss(animated: true, completion: nil)
        }
        switch result {
        case .cancelled:
            print("cancel")
        case .saved:
            print("saved")
        case .sent:
            print("sent")
        case .failed:
            print("failed")
        default:
            print("default")
        }
        controller.dismiss(animated: true, completion: nil)
    }
}


// Extension for Textview Editing or Delegate
extension MainViewController:UITextViewDelegate{
    
    // setting textview, buttons colors and set app name to tittle label
    func textviewEditing(){
        
        // set textview delegate to self
        BugsTextview.delegate = self
        
        // set predefine or placeholder text to textview
        BugsTextview.text = prefilledTextviewText
        
        // setting textview cornerRadius and give background color
        BugsTextview.layer.cornerRadius = 8
        BugsTextview.layer.masksToBounds = true
        BugsTextview.backgroundColor = SLog.shared.backgroundColor
        
        // setting Email Button background color and tint color
        email_btn_outlet.backgroundColor = UIColor.white
        email_btn_outlet.tintColor  = SLog.shared.textColor
        BugsTextview.textColor = SLog.shared.textColor
        
        // Textview Border or corner radius
        BugsTextview.layer.borderColor = SLog.shared.borderColor
        BugsTextview.layer.borderWidth = 1.5
        BugsTextview.layer.cornerRadius = 8.0
        
        // Send Button Border or corner radius
        send_btn_outlet.layer.borderColor = SLog.shared.borderColor
        send_btn_outlet.layer.borderWidth = 1.5
        send_btn_outlet.layer.cornerRadius = 8.0
        
        // Skip Button Border or corner radius
        skip_btn_outlet.layer.borderColor = SLog.shared.borderColor
        skip_btn_outlet.layer.borderWidth = 1.5
        skip_btn_outlet.layer.cornerRadius = 8.0
        
        // main view corner radius
        main_dialogBox_view.layer.cornerRadius = 8.0
        main_dialogBox_view.backgroundColor = SLog.shared.backgroundColor
        
        // set appName to tittle label
        if SLog.shared.titleText == ""{
            let appName = Bundle.main.infoDictionary!["CFBundleName"] as! String
            titile_lbl.text = appName
        }
        else{
            titile_lbl.text = SLog.shared.titleText
        }
    }
    
    // when textview is Editing
    public func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == prefilledTextviewText{
            textView.text = ""
        }
    }
    
    // when textview text is change
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n"{
            textView.resignFirstResponder()
        }
        return true
    }
    
    // when textview text is end
    public func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == ""{
            textView.text = prefilledTextviewText
        }
    }
    // function for setting color of theme
    func setThemeColor(backgroundColor:UIColor,textColor:UIColor,BorderColor:UIColor){
        
        titile_lbl.textColor = textColor
        send_btn_outlet.tintColor = textColor
        send_btn_outlet.backgroundColor = backgroundColor
        send_btn_outlet.layer.borderColor = BorderColor.cgColor
        
        skip_btn_outlet.tintColor = textColor
        skip_btn_outlet.backgroundColor = backgroundColor
        skip_btn_outlet.layer.borderColor = BorderColor.cgColor
        
        main_dialogBox_view.backgroundColor = backgroundColor
        
        email_btn_outlet.tintColor = textColor
        email_btn_outlet.backgroundColor = backgroundColor
        email_btn_outlet.layer.borderColor = BorderColor.cgColor
        
        BugsTextview.textColor = textColor
        BugsTextview.backgroundColor = backgroundColor
        BugsTextview.layer.borderColor = BorderColor.cgColor
    }
}

