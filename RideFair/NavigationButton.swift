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
      self.hue = 0.4
      self.saturation = 0.3
      self.brightness = 0.8
      
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
        // Outer Path Gradient:
        // 1
        let outerTop = UIColor(hue: hue, saturation: saturation,
          brightness: brightness, alpha: 1.0)
        let outerBottom = UIColor(hue: hue, saturation: saturation,
          brightness: brightness * 0.8, alpha: 1.0)

        // 2
        context.saveGState()
        context.addPath(outerPath)
        context.clip()
        drawGlossAndGradient(context: context, rect: outerRect,
                             startColor: outerTop.cgColor, endColor: outerBottom.cgColor)
        context.restoreGState()
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
    
    func drawLinearGradient(
      context: CGContext, rect: CGRect, startColor: CGColor, endColor: CGColor) {
      // 1
      let colorSpace = CGColorSpaceCreateDeviceRGB()
      
      // 2
      let colorLocations: [CGFloat] = [0.0, 1.0]
      
      // 3
      let colors: CFArray = [startColor, endColor] as CFArray
      
      // 4
      let gradient = CGGradient(
        colorsSpace: colorSpace, colors: colors, locations: colorLocations)!

      // 5
      let startPoint = CGPoint(x: rect.midX, y: rect.minY)
      let endPoint = CGPoint(x: rect.midX, y: rect.maxY)

      context.saveGState()

      // 6
      context.addRect(rect)
      // 7
      context.clip()

      // 8
      context.drawLinearGradient(
        gradient, start: startPoint, end: endPoint, options: [])

      context.restoreGState()
    }
    
    func drawGlossAndGradient(
      context: CGContext, rect: CGRect, startColor: CGColor, endColor: CGColor) {

      // 1
      drawLinearGradient(
        context: context, rect: rect, startColor: startColor, endColor: endColor)
      
      let glossColor1 = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.35)
      let glossColor2 = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.1)
      
      let topHalf = CGRect(origin: rect.origin,
        size: CGSize(width: rect.width, height: rect.height/2))
      
      drawLinearGradient(context: context, rect: topHalf,
        startColor: glossColor1.cgColor, endColor: glossColor2.cgColor)
    }
    
}
