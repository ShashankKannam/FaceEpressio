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
    
    override func draw(_ rect: CGRect) {
        // Drawing code
       UIColor.red.set()
       facePath.stroke()
    }
 

}
