//
//  AKOTPView.swift
//  AKOTPView
//
//  Created by Ahmed Khalil on 05.11.20.
//

import UIKit

public enum KeyboardType: Int {
    case numeric
    case alphabet
    case alphaNumeric
}

class AKOTPView: UIView {
    
    public var fieldsCount: Int = 4
    public var otpInputType: KeyboardType = .numeric
    public var secureEntry: Bool = false
    public var fieldSizeWidth: CGFloat = 60
    public var fieldSizeHeight: CGFloat = 60
    public var separatorSpace: CGFloat = 16
    public var fieldBorderWidth: CGFloat = 1
    public var fieldackgroundColor: UIColor = UIColor.clear
    public var filledBackgroundColor: UIColor = UIColor.clear
    public var fieldBorderColor: UIColor = UIColor.gray
    public var fieldCornerRadius: CGFloat = 5
    
    private var otpTextFields: [UITextField] = []
    
    override public func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func initializeUI() {
        layer.masksToBounds = true
        layoutIfNeeded()
        setupOTPTextFields()
        layoutIfNeeded()
        otpTextFields.first?.becomeFirstResponder()
    }
    
    private func setupOTPTextFields() {
        otpTextFields.removeAll()
        
        for i in 0...(fieldsCount-1) {
            let otpTextField = createOTPTextField(forIndex: i)
            addSubview(otpTextField)
            otpTextFields.append(otpTextField)
        }
    }
    
    private func createOTPTextField(forIndex index: Int) -> UITextField {
        let otpTextField = UITextField()
        otpTextField.frame = getFieldFrame(index: index)
        otpTextField.delegate = self
        otpTextField.tag = index
        
        // Set input type for OTP fields
        switch otpInputType {
        case .numeric:
            otpTextField.keyboardType = .numberPad
        case .alphabet:
            otpTextField.keyboardType = .alphabet
        case .alphaNumeric:
            otpTextField.keyboardType = .namePhonePad
        }
        
        // Set border & corner values
        otpTextField.layer.borderColor = fieldBorderColor.cgColor
        otpTextField.layer.borderWidth = fieldBorderWidth
        otpTextField.layer.cornerRadius = fieldCornerRadius
        
        otpTextField.textAlignment = .center
        
        return otpTextField
    }
    
    private func getFieldFrame(index: Int) -> CGRect {
        let x = CGFloat(index) * (fieldSizeWidth + separatorSpace)
        return CGRect(x: x, y: 0, width: fieldSizeWidth, height: fieldSizeHeight)
    }
}

extension AKOTPView: UITextFieldDelegate {
    
}
