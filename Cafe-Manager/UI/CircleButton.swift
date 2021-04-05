//
//  CircleButton.swift
//  Cafe-Manager
//
//  Created by Nishain on 4/4/21.
//  Copyright © 2021 Nishain. All rights reserved.
//

import UIKit
@IBDesignable
class CircleButton: UIButton {
    
    override func contentRect(forBounds bounds: CGRect) -> CGRect {
        self.layer.cornerRadius = bounds.size.height / 2
        return bounds
    }

}
