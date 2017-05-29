//
//  EmotionsViewController.swift
//  FaceEpressio
//
//  Created by shashank kannam on 5/8/17.
//  Copyright © 2017 developer. All rights reserved.
//

import UIKit
// VCLLoggingViewController
class EmotionsViewController: UITableViewController, UIPopoverPresentationControllerDelegate  {

    private var emotions:[(name: String, expression: FacialExpression)] = [("sad",FacialExpression(eyes: .closed, mouth: .frown)), ("happy",FacialExpression(eyes: .open, mouth: .smile)), ("worried",FacialExpression(eyes: .open, mouth: .smirk))]
    
    @IBAction func addEmotionalFace(from segue: UIStoryboardSegue) {
        if let source = segue.source as? ExpressionEditorTableViewController {
            emotions.append((name: source.name, expression: source.expression))
            tableView.reloadData()
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emotions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Emotion cell", for: indexPath)
        cell.textLabel?.text = emotions[indexPath.row].name
        return cell
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("******In prepare for segue \(self.description) *****")
        var destinationViewController = segue.destination
        if let navigationController = destinationViewController as? UINavigationController {
            destinationViewController = navigationController.visibleViewController ?? destinationViewController
        }
        if let cell = sender as? UITableViewCell, let faceViewController = destinationViewController as? FaceViewController, let indexpath = tableView.indexPath(for: cell) {
            faceViewController.expression = emotions[indexpath.row].expression
            faceViewController.navigationItem.title = emotions[indexpath.row].name
        } else if destinationViewController is ExpressionEditorTableViewController {
            if let popController = segue.destination.popoverPresentationController {
                popController.delegate = self
            }
        }
    }

    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        if traitCollection.verticalSizeClass == .compact {
            return .none
        } else if traitCollection.horizontalSizeClass == .compact {
            return .overFullScreen
        } else {
            return .none
        }
    }
    
}
