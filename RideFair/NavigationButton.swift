//
//  NavigationButton.swift
//  RideFair
//
//  Created by Keshav Maheshwari on 3/31/20.
//  Copyright © 2020 Keshav Maheshwari. All rights reserved.
//

import UIKit

class NavigationButton: UIButton {

    var hue: CGFloat {
      didSet {
        setNeedsDisplay()
      }
    }
    
    var saturation: CGFloat {
      didSet {
        setNeedsDisplay()
      }
    }
    
    var brightness: CGFloat {
      didSet {
        setNeedsDisplay()
      }
    }

}
