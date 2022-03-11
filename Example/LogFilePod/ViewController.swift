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
        
    }
    @IBAction func Click_action(_ sender: UIButton) {
        let secondView = NewController(nibName: "NewController", bundle: nil)
        secondView.modalPresentationStyle = .fullScreen
        self.present(secondView, animated: true, completion: nil)
    }
    
}

