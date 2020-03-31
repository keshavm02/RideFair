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

    required init?(coder aDecoder: NSCoder) {
      self.hue = 0.5
      self.saturation = 0.5
      self.brightness = 0.5
      
      super.init(coder: aDecoder)
      
      self.isOpaque = false
      self.backgroundColor = .clear
    }

    override func draw(_ rect: CGRect) {
      guard let context = UIGraphicsGetCurrentContext() else {
        return
      }

      let color = UIColor(hue: hue,
        saturation: saturation,
        brightness: brightness,
        alpha: 1.0)

      context.setFillColor(color.cgColor)
      context.fill(bounds)
    }
}
