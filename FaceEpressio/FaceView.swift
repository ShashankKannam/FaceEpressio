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
    var contentScale: CGFloat = 0.9 { didSet { setNeedsDisplay() } }
    
    @IBInspectable 
    var isEyesClosed: Bool = false { didSet {
        leftEye.eyesOpen = isEyesClosed
        rightEye.eyesOpen = isEyesClosed
        } }
    
    @IBInspectable
    var faceColor: UIColor = UIColor.red { didSet {
        leftEye.color = faceColor
        rightEye.color = faceColor
        setNeedsDisplay() } }
    
    @IBInspectable
    var faceLineWidth: CGFloat = 5.0 { didSet {
        leftEye.lineWidth = faceLineWidth
        rightEye.lineWidth = faceLineWidth
        setNeedsDisplay() } }
    
    @IBInspectable
    var mouthCurvature: CGFloat = 0.5 { didSet { setNeedsDisplay() } }
    
    func changedByPinchGesture(pinch: UIPinchGestureRecognizer) {
        switch pinch.state {
        case .changed, .ended:
           // print("before : \(pinch.scale)")
            contentScale *= pinch.scale
            pinch.scale = 1
           // print("After : \(pinch.scale)")
        default:
            break
        }
    }
    
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
    
    private func eyeCenter(eyeIn: Eye) -> CGPoint {
            let eyeOffset = skullRadius/Ratios.skullRadiusToEyeOffset
            var eyecenter = skullCenter
            eyecenter.y -= eyeOffset
            eyecenter.x += ((eyeIn == .left) ? -1 : 1) * eyeOffset
            return eyecenter
        }
    
    private lazy var leftEye: EyeView = self.createEye()
    private lazy var rightEye: EyeView = self.createEye()
    
    private func createEye() -> EyeView {
        let eye = EyeView()
        eye.isOpaque = false
        eye.color = faceColor
        eye.lineWidth = faceLineWidth
        addSubview(eye)
        return eye
    }
    
    private func positionEye(_ eye: EyeView, center: CGPoint) {

        let size = skullRadius/Ratios.skullRadiusToEyeRadius * 2
        eye.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: size, height: size))
        eye.center = center
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        positionEye(leftEye, center: eyeCenter(eyeIn: .left))
        positionEye(rightEye, center: eyeCenter(eyeIn: .right)) 
    }
  
    private func pathForMouth() -> UIBezierPath {
        //let mouthPath: UIBezierPath
        
        let mouthOffset = skullRadius/Ratios.skullRadiusToMouthOffset
        let mouthWidth = skullRadius/Ratios.skullRadiusToMouthWidth
        let mouthHeight = skullRadius/Ratios.skullRadiusToMouthHeight
        
        let mouthRect = CGRect(x: skullCenter.x - mouthWidth/2, y: skullCenter.y + mouthOffset, width: mouthWidth, height: mouthHeight)
        //mouthPath = UIBezierPath(rect: mouthRect)
        
        let startPoint = CGPoint(x: mouthRect.minX, y: mouthRect.midY)
        let endPoint = CGPoint(x: mouthRect.maxX, y: mouthRect.midY)
        
        let smileOffset = max(-1, min(mouthCurvature,1)) * mouthRect.height
        
        let controlPoint1: CGPoint = CGPoint(x: startPoint.x + mouthWidth/3, y: startPoint.y + smileOffset)
        let controlPoint2: CGPoint = CGPoint(x: endPoint.x - mouthWidth/3, y: startPoint.y + smileOffset)
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
       //eyePath(eye: .left).stroke()
       //eyePath(eye: .right).stroke()
       pathForMouth().stroke()
    }
 
    private struct Ratios {
        static let skullRadiusToEyeOffset: CGFloat = 3
        static let skullRadiusToEyeRadius: CGFloat = 10
        static let skullRadiusToMouthOffset: CGFloat = 3
        static let skullRadiusToMouthWidth: CGFloat = 1
        static let skullRadiusToMouthHeight: CGFloat = 3
    }
}
