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
    
    private struct BlinkRate {
        static let closeDuration: TimeInterval = 0.4
        static let openduration: TimeInterval = 2.5
    }
    
    private func blinkIfNeeded() {
        if blinking {
            faceView.isEyesClosed = false
            Timer.scheduledTimer(withTimeInterval: BlinkRate.closeDuration, repeats: false){ [weak self] timer in
                self?.faceView.isEyesClosed = true
                Timer.scheduledTimer(withTimeInterval: BlinkRate.openduration, repeats: false) { [weak self] (timer) in
                    self?.blinkIfNeeded()
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        blinking = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        blinking = false
    }
    
}
