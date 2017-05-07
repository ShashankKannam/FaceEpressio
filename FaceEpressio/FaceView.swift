//
//  FaceView.swift
//  FaceEpressio
//
//  Created by shashank kannam on 5/7/17.
//  Copyright © 2017 developer. All rights reserved.
//

import UIKit

class FaceView: UIView {
    
    private var contentScale: CGFloat = 0.9
    
    private var skullCenter: CGPoint {
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    private var skullRadius: CGFloat {
        return min(bounds.height, bounds.width)/2 * contentScale
    }
    
    private var facePath: UIBezierPath {
        let facePath = UIBezierPath(arcCenter: skullCenter, radius: skullRadius, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: false)
        facePath.lineWidth = 5.0
        return facePath
    }
    
    private enum Eye {
        case left
        case right
    }
    
    private func eyePath(eye: Eye) -> UIBezierPath {
        
        func eyeCenter(eyeIn: Eye) -> CGPoint {
            let eyeOffset = skullRadius/Ratios.skullRadiusToEyeOffset
            var eyecenter = skullCenter
            eyecenter.y -= eyeOffset
            eyecenter.x += ((eyeIn == .left) ? -1 : 1) * eyeOffset
            return eyecenter
        }
        
        let eyeRadius = skullRadius/Ratios.skullRadiusToEyeRadius
        let eyePath = UIBezierPath(arcCenter: eyeCenter(eyeIn: eye), radius: eyeRadius, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: false)
        eyePath.lineWidth = 3.0
        return eyePath
    }
    
    
    
    override func draw(_ rect: CGRect) {
        // Drawing code
       UIColor.red.set()
       facePath.stroke()
       eyePath(eye: .left).stroke()
       eyePath(eye: .right).stroke()
    }
 
    private struct Ratios {
        static let skullRadiusToEyeOffset: CGFloat = 3
        static let skullRadiusToEyeRadius: CGFloat = 10
        static let skullRadiusToMouthOffset: CGFloat = 3
        static let skullRadiusToMouthWidth: CGFloat = 1
        static let skullRadiusToMouthHeight: CGFloat = 3
    }

}
