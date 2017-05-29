//
//  BlinkingViewController.swift
//  FaceEpressio
//
//  Created by shashank kannam on 5/25/17.
//  Copyright © 2017 developer. All rights reserved.
//

import UIKit

class BlinkingViewController: FaceViewController {

    var blinking: Bool = false {
        didSet {
            blinkIfNeeded()
        }
    }
    
    override func updateUI() {
        super.updateUI()
        blinking = expression.eyes == .squinting
    }
    
    private struct BlinkRate {
        static let closeDuration: TimeInterval = 0.4
        static let openduration: TimeInterval = 2.5
    }
    
    private func blinkIfNeeded() {
        if blinking && canBlink && !inABlink {
            faceView.isEyesClosed = false
            Timer.scheduledTimer(withTimeInterval: BlinkRate.closeDuration, repeats: false){ [weak self] timer in
                self?.faceView.isEyesClosed = true
                self?.inABlink = true
                Timer.scheduledTimer(withTimeInterval: BlinkRate.openduration, repeats: false) { [weak self] (timer) in
                    self?.inABlink = false
                    self?.blinkIfNeeded()
                }
            }
        }
    }
    
    private var canBlink = false
    private var inABlink = false
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        canBlink = true
        blinkIfNeeded()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        canBlink = false
    }
    
}
