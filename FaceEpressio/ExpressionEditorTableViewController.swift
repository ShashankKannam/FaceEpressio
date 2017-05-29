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
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let popController = navigationController?.popoverPresentationController {
            if popController.arrowDirection != .unknown {
                navigationItem.leftBarButtonItem = nil
            }
        }
        var size = tableView.minimumSize(forSection: 0)
        size.height -= tableView.heightForRow(at: IndexPath(row: 1, section: 0))
        size.height += size.width
        preferredContentSize = size 
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

extension UITableView {
    
    func minimumSize(forSection section: Int) -> CGSize {
        var width: CGFloat = 0
        var height: CGFloat = 0
        for row in 0..<numberOfRows(inSection: section) {
            let indexPath = IndexPath(row: row, section: section)
            if let cell = cellForRow(at: indexPath) ?? dataSource?.tableView(self, cellForRowAt: indexPath) {
                let cellSize = cell.contentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
                width = max(width, cellSize.width)
                height += heightForRow(at: indexPath)
            }
        }
        return CGSize(width: width, height: height)
    }
    
    func heightForRow(at indexPath: IndexPath? = nil) -> CGFloat {
        if indexPath != nil, let height = delegate?.tableView?(self, heightForRowAt: indexPath!) {
            return height
        } else {
            return rowHeight
        }
    }
  
}
