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
      
      // 1
      let outerColor = UIColor(
        hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
      let shadowColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.5)
      
      // 2
      let outerMargin: CGFloat = 5.0
      let outerRect = rect.insetBy(dx: outerMargin, dy: outerMargin)
      // 3
      let outerPath = createRoundedRectPath(for: outerRect, radius: 6.0)
      
      // 4
      if state != .highlighted {
        context.saveGState()
        context.setFillColor(outerColor.cgColor)
        context.setShadow(offset: CGSize(width: 0, height: 2),
          blur: 3.0, color: shadowColor.cgColor)
        context.addPath(outerPath)
        context.fillPath()
        context.restoreGState()
      }
    }
    
    func createRoundedRectPath(for rect: CGRect, radius: CGFloat) -> CGMutablePath {
        let path = CGMutablePath()
        
        // 1
        let midTopPoint = CGPoint(x: rect.midX, y: rect.minY)
        path.move(to: midTopPoint)
        
        // 2
        let topRightPoint = CGPoint(x: rect.maxX, y: rect.minY)
        let bottomRightPoint = CGPoint(x: rect.maxX, y: rect.maxY)
        let bottomLeftPoint = CGPoint(x: rect.minX, y: rect.maxY)
        let topLeftPoint = CGPoint(x: rect.minX, y: rect.minY)
        
        // 3
        path.addArc(tangent1End: topRightPoint,
          tangent2End: bottomRightPoint,
          radius: radius)

        path.addArc(tangent1End: bottomRightPoint,
          tangent2End: bottomLeftPoint,
          radius: radius)

        path.addArc(tangent1End: bottomLeftPoint,
          tangent2End: topLeftPoint,
          radius: radius)

        path.addArc(tangent1End: topLeftPoint,
          tangent2End: topRightPoint,
          radius: radius)

        // 4
        path.closeSubpath()
        
        return path
    }

//    override func draw(_ rect: CGRect) {
//      guard let context = UIGraphicsGetCurrentContext() else {
//        return
//      }
//
//      let color = UIColor(hue: hue,
//        saturation: saturation,
//        brightness: brightness,
//        alpha: 1.0)
//
//      context.setFillColor(color.cgColor)
//      context.fill(bounds)
//    }
    
    
}
