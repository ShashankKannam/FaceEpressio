//
//  EmotionsViewController.swift
//  FaceEpressio
//
//  Created by shashank kannam on 5/8/17.
//  Copyright © 2017 developer. All rights reserved.
//

import UIKit
// VCLLoggingViewController
class EmotionsViewController: UITableViewController  {

    private var emotions:[(name: String, expression: FacialExpression)] = [("sad",FacialExpression(eyes: .closed, mouth: .frown)), ("happy",FacialExpression(eyes: .open, mouth: .smile)), ("worried",FacialExpression(eyes: .open, mouth: .smirk))]
    // MARK: - Navigation
    
    
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
        }
    }

}
