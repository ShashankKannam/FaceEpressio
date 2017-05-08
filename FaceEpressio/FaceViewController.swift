//
//  ViewController.swift
//  FaceEpressio
//
//  Created by shashank kannam on 5/7/17.
//  Copyright © 2017 developer. All rights reserved.
//

import UIKit

class FaceViewController: UIViewController {
    
    @IBOutlet weak var faceView: FaceView!  {
        didSet{
            
            let pinchGesture = UIPinchGestureRecognizer(target: faceView, action: #selector(faceView.changedByPinchGesture(pinch:)))
            faceView.addGestureRecognizer(pinchGesture)
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.toggleEyes(byReactingTo:)))
            tapGesture.numberOfTapsRequired = 1
            faceView.addGestureRecognizer(tapGesture)
            
            let swipeUpGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.increaseHapiness))
            swipeUpGesture.direction = .up
            let swipeDownGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.decreaseHapiness))
            swipeDownGesture.direction = .down
            faceView.addGestureRecognizer(swipeUpGesture)
            faceView.addGestureRecognizer(swipeDownGesture)
            
            updateUI()
        }
    }
    
    
    var expression = FacialExpression(eyes: .closed, mouth: .neutral) {
        didSet{
            updateUI()
        }
    }
    
    func increaseHapiness() {
        expression = expression.happier
    }
    
    func decreaseHapiness() {
        expression = expression.sadder
    }
    
    func toggleEyes(byReactingTo tapGesture: UITapGestureRecognizer) {
        if tapGesture.state == .ended {
            let eyes: FacialExpression.Eyes = (expression.eyes == .open) ? .closed : .open
            expression = FacialExpression(eyes: eyes, mouth: expression.mouth)
        }
    }
    
    private let mouthCurvatures: [FacialExpression.Mouth: CGFloat] = [.grin : 0.5, .neutral : 0.0, .frown : -1.0, .smile : 1.0, .smirk : -0.5]

    
    private func updateUI(){
        switch expression.eyes {
        case .open:
            faceView?.isEyesClosed = false
        case .closed:
            faceView?.isEyesClosed = true
        case .squinting:
            faceView?.isEyesClosed = true
        }
        faceView?.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0.0
    }
}

