//
//  ViewController.swift
//  LogFilePod
//
//  Created by uzair-whizpool on 03/08/2022.
//  Copyright (c) 2022 uzair-whizpool. All rights reserved.
//

import UIKit
import LogFilePod

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // initilization and create Folder in Directory
        SLog.shared.initilization()
        
        // Write Logs in Logs File with message
        SLog.shared.log(text: "Hello Buddy")
        SLog.shared.log(text: "Hi")
        SLog.shared.log(text: "Yes Please")
        SLog.shared.log(text: "No")
        
        // function Textview Editing Calls
        SLog.shared.setpassword(password: "QWERTY")
        
        // set tittle
        SLog.shared.setTittle(title: "Map App")
        
        // set days
        SLog.shared.setDaysForLog(numberOfDays: 8)
        
        // set tag
        SLog.shared.setDefaultTag(tagName: "Logs")
    }
    
    @IBAction func Click_action(_ sender: UIButton) {
//        let amazingBundle = Bundle(for: NewController.self)
//        let secondView = NewController(nibName: "NewController", bundle: amazingBundle)
//        secondView.modalPresentationStyle = .fullScreen
//        self.present(secondView, animated: true, completion: nil)
        
        SLog.shared.getLogFilePath { zipPath in
            //
            print("zippath: \(zipPath)")
        }
    }
    
}

