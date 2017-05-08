//
//  EmotionsViewController.swift
//  FaceEpressio
//
//  Created by shashank kannam on 5/8/17.
//  Copyright © 2017 developer. All rights reserved.
//

import UIKit

class EmotionsViewController: UIViewController {

    private var emotions:[String:FacialExpression] = ["sad":FacialExpression(eyes: .closed, mouth: .frown), "happy":FacialExpression(eyes: .open, mouth: .smile)]
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var destinationViewController = segue.destination
        if let navigationController = destinationViewController as? UINavigationController {
            destinationViewController = navigationController.visibleViewController ?? destinationViewController
        }
        if let identifier = segue.identifier, let faceViewController = destinationViewController as? FaceViewController, let expression = emotions[identifier], let button = sender as? UIButton {
            faceViewController.expression = expression
            faceViewController.navigationItem.title = button.currentTitle
        }
    }

}
