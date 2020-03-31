//
//  Drawing.swift
//  RideFair
//
//  Created by Keshav Maheshwari on 3/31/20.
//  Copyright © 2020 Keshav Maheshwari. All rights reserved.
//

import UIKit
import CoreGraphics

extension UIView {
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
}

