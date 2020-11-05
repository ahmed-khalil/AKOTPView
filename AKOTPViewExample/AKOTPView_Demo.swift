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
    public var fieldSizeWidth: CGFloat = 40
    public var fieldSizeHeight: CGFloat = 60
    public var separatorSpace: CGFloat = 16
    public var fieldBorderWidth: CGFloat = 1
    public var fieldackgroundColor: UIColor = .clear
    public var filledBackgroundColor: UIColor = .clear
    public var fieldBorderColor: UIColor = .gray
    public var fieldCornerRadius: CGFloat = 5
    public var shouldShowCursor: Bool = true
    public var cursorColor: UIColor = .systemBlue
    
    private var otpTextFields: [AKOTPTextField] = []
    
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
        
        for i in 0...(fieldsCount - 1) {
            let otpTextField = createOTPTextField(forIndex: i)
            addSubview(otpTextField)
            otpTextFields.append(otpTextField)
        }
    }
    
    private func createOTPTextField(forIndex index: Int) -> AKOTPTextField {
        let otpTextField = AKOTPTextField()
        otpTextField.frame = getFieldFrame(index: index)
        otpTextField.delegate = self
        otpTextField.tag = index
        
        if shouldShowCursor {
            otpTextField.tintColor = cursorColor
        }
        else {
            otpTextField.tintColor = UIColor.clear
        }
        
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
        let totalSeparatorSpace = CGFloat((fieldsCount - 1)) * separatorSpace
        let calculatedWidth = (bounds.size.width - totalSeparatorSpace) / CGFloat(fieldsCount)
        let width = min(calculatedWidth, fieldSizeWidth)
        let x = CGFloat(index) * (width + separatorSpace)
        return CGRect(x: x, y: 0, width: fieldSizeWidth, height: fieldSizeHeight)
    }
    
    public func getOTPString() -> String {
        var otpString = ""
        for textField in otpTextFields {
            otpString += textField.text ?? ""
        }
        return otpString
    }
}

extension AKOTPView: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let otpString = getOTPString()
        if otpString.count == 0 {
            if textField.tag == otpTextFields.first?.tag {
                return true
            } else {
                otpTextFields.first?.becomeFirstResponder()
            }
        } else if otpString.count == fieldsCount {
            if textField.tag == otpTextFields.last?.tag {
                return true
            } else {
                otpTextFields.last?.becomeFirstResponder()
            }
        } else {
            if textField.tag == otpString.count || textField.tag == (otpString.count - 1) {
                return true
            }
        }
        
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // writing text
        if textField.text == "" && string.count == 1 {
            textField.text = string
            textField.backgroundColor = filledBackgroundColor
            if textField.tag == fieldsCount - 1 {
                textField.resignFirstResponder()
            } else {
                let nextOTPField = otpTextFields[textField.tag + 1]
                nextOTPField.becomeFirstResponder()
            }
        }
        
        // removing text
        else {
            let currentText = textField.text ?? ""
            if textField.tag > 0 && currentText.isEmpty {
                let prevOTPField = otpTextFields[textField.tag - 1]
                deleteText(in: prevOTPField)
            } else {
                deleteText(in: textField )
            }
        }
        
        return false
    }
    
    private func deleteText(in textField: UITextField) {
        // If deleting the text, then move to previous text field if present
        textField.text = ""
        textField.backgroundColor = fieldackgroundColor
        textField.becomeFirstResponder()
    }
}
