//
//  FaceView.swift
//  FaceEpressio
//
//  Created by shashank kannam on 5/7/17.
//  Copyright © 2017 developer. All rights reserved.
//

import UIKit

@IBDesignable
class FaceView: UIView {
    
    @IBInspectable
    var contentScale: CGFloat = 0.9
    
    @IBInspectable
    var isEyesClosed: Bool = false
    
    @IBInspectable
    var faceColor: UIColor = UIColor.red
    
    @IBInspectable
    var faceLineWidth: CGFloat = 5.0
    
    @IBInspectable
    var mouthCurvature: CGFloat = 0.5
    
    private var skullCenter: CGPoint {
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    private var skullRadius: CGFloat {
        return min(bounds.height, bounds.width)/2 * contentScale
    }
    
    private var facePath: UIBezierPath {
        let facePath = UIBezierPath(arcCenter: skullCenter, radius: skullRadius, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: false)
        facePath.lineWidth = faceLineWidth
        return facePath
    }
    
    private enum Eye {
        case left
        case right
    }
    
    enum Mouth {
        case smiled
        case frown
        case normal
    }
    
    private func eyePath(eye: Eye) -> UIBezierPath {
        
        func eyeCenter(eyeIn: Eye) -> CGPoint {
            let eyeOffset = skullRadius/Ratios.skullRadiusToEyeOffset
            var eyecenter = skullCenter
            eyecenter.y -= eyeOffset
            eyecenter.x += ((eyeIn == .left) ? -1 : 1) * eyeOffset
            return eyecenter
        }
        
        let eyePath: UIBezierPath
        let centerOfEye: CGPoint = eyeCenter(eyeIn: eye)
        let eyeRadius = skullRadius/Ratios.skullRadiusToEyeRadius
        
        if isEyesClosed {
           eyePath = UIBezierPath()
           eyePath.move(to: CGPoint(x: centerOfEye.x - eyeRadius, y: centerOfEye.y))
           eyePath.addLine(to: CGPoint(x: centerOfEye.x + eyeRadius, y: centerOfEye.y))
        } else {
            eyePath = UIBezierPath(arcCenter: centerOfEye, radius: eyeRadius, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: false)
        }
        eyePath.lineWidth = faceLineWidth
        return eyePath
    }
  
    private func pathForMouth(mouth: Mouth) -> UIBezierPath {
        //let mouthPath: UIBezierPath
        
        let mouthOffset = skullRadius/Ratios.skullRadiusToMouthOffset
        let mouthWidth = skullRadius/Ratios.skullRadiusToMouthWidth
        let mouthHeight = skullRadius/Ratios.skullRadiusToMouthHeight
        
        let mouthRect = CGRect(x: skullCenter.x - mouthWidth/2, y: skullCenter.y + mouthOffset, width: mouthWidth, height: mouthHeight)
        //mouthPath = UIBezierPath(rect: mouthRect)
        
        let startPoint = CGPoint(x: mouthRect.minX, y: mouthRect.midY)
        let endPoint = CGPoint(x: mouthRect.maxX, y: mouthRect.midY)
        
        let smileOffset = max(-1, min(mouthCurvature,1)) * mouthRect.height
        
        let controlPoint1: CGPoint
        let controlPoint2: CGPoint
        
        switch mouth {
        case .smiled:
            controlPoint1 = CGPoint(x: startPoint.x + mouthWidth/3, y: startPoint.y + smileOffset)
            controlPoint2 = CGPoint(x: endPoint.x - mouthWidth/3, y: startPoint.y + smileOffset)
        case .frown:
            controlPoint1 = CGPoint(x: startPoint.x + mouthWidth/3, y: startPoint.y - smileOffset)
            controlPoint2 = CGPoint(x: endPoint.x - mouthWidth/3, y: startPoint.y - smileOffset)
        case .normal:
            controlPoint1 = CGPoint(x: startPoint.x + mouthWidth/3, y: startPoint.y)
            controlPoint2 = CGPoint(x: endPoint.x - mouthWidth/3, y: startPoint.y)
        }
        
        let path = UIBezierPath()
        path.move(to: startPoint)
        path.addCurve(to: endPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
        path.lineWidth = faceLineWidth
        return path
    }
    
    override func draw(_ rect: CGRect) {
        // Drawing code
       faceColor.set()
       facePath.stroke()
       eyePath(eye: .left).stroke()
       eyePath(eye: .right).stroke()
       pathForMouth(mouth: .smiled).stroke()
    }
 
    private struct Ratios {
        static let skullRadiusToEyeOffset: CGFloat = 3
        static let skullRadiusToEyeRadius: CGFloat = 10
        static let skullRadiusToMouthOffset: CGFloat = 3
        static let skullRadiusToMouthWidth: CGFloat = 1
        static let skullRadiusToMouthHeight: CGFloat = 3
    }

}
