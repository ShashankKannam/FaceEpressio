//
//  ExpressionEditorTableViewController.swift
//  FaceEpressio
//
//  Created by shashank kannam on 5/28/17.
//  Copyright © 2017 developer. All rights reserved.
//

import UIKit

class ExpressionEditorTableViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var eyesControl: UISegmentedControl!
    @IBOutlet weak var mouthControl: UISegmentedControl!
    
    var name: String {
        return nameTF?.text ?? ""
    }
    
    var expression: FacialExpression {
        return FacialExpression(eyes: eyeChoices[eyesControl?.selectedSegmentIndex ?? 0], mouth: mouthChoices[mouthControl?.selectedSegmentIndex ?? 0])
    }
    
    private var eyeChoices = [FacialExpression.Eyes.closed, .open, .squinting]
    private var mouthChoices = [FacialExpression.Mouth.frown, .smirk, .neutral, .smirk, .smile]
    
    
    @IBAction func updateFace() {
        faceViewController?.expression = expression
    }
    
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1 {
            return tableView.bounds.size.width
        }
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
    private var faceViewController: BlinkingViewController?
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Embed Face" {
            faceViewController = segue.destination as? BlinkingViewController
            faceViewController?.expression = expression
        }
    }
 

}
