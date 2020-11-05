//
//  AKOTPTextField_Demo.swift
//  AKOTPViewExample
//
//  Created by Ahmed Khalil on 05.11.20.
//

import UIKit.UITextField

class AKOTPTextField: UITextField {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func deleteBackward() {
        super.deleteBackward()
        _ = delegate?.textField?(self, shouldChangeCharactersIn: NSMakeRange(0, 0), replacementString: "")
    }
}
