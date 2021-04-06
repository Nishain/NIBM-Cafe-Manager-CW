//
//  UnEditableTextField.swift
//  Cafe-Manager
//
//  Created by Nishain on 4/6/21.
//  Copyright © 2021 Nishain. All rights reserved.
//

import UIKit

class UnEditableTextField: UITextField {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func shouldChangeText(in range: UITextRange, replacementText text: String) -> Bool {
        return false
    }
}
