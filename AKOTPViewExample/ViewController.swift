//
//  ViewController.swift
//  AKOTPViewExample
//
//  Created by Ahmed Khalil on 05.11.20.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var akotpView: AKOTPView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        akotpView.fieldsCount = 6
        akotpView.otpInputType = .numeric
        akotpView.fieldBorderColor = .lightGray
        akotpView.filledBackgroundColor = .lightGray
        akotpView.shouldShowCursor = false
        akotpView.initializeUI()
    }
}

