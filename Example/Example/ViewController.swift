//
//  ViewController.swift
//  Example
//
//  Created by Stanislav Zhukovskiy on 29.06.15.
//  Copyright (c) 2015 andgotravel. All rights reserved.
//

import UIKit
import NGOPassCodeView

class ViewController: UIViewController, NGOPassCodeViewDelegate {

    @IBOutlet weak private var passCodeView: NGOPassCodeView! = NGOPassCodeView()
    @IBOutlet weak private var descLabel: UILabel! = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.passCodeView.delegate          = self
        self.passCodeView.numberOfDigits    = 6
        self.passCodeView.borderColor       = UIColor.whiteColor()
    }
    
    func NGOPassCodeViewDidFinishEnteringPassword(password: String) {
        self.descLabel.text = "Entered password is:\n\(password)"
        self.passCodeView.shouldResignFirstResponder()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
}

