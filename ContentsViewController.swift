//
//  ContentsViewController.swift
//  containerViewSwitcher
//
//  Created by James O'Connor on 1/25/17.
//  Copyright © 2017 James O'Connor. All rights reserved.
//

import UIKit

class ContentsViewController: UIViewController {
    
    @IBOutlet weak var testTextField :UITextField?
    @IBOutlet weak var contentTestLabel :UILabel?

    weak var contentsDelegate :ContentsControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.testTextField?.delegate = self
    }
    
    @IBAction func updateButton() {
        if testTextField?.text != "" {
            self.contentsDelegate!.printContentStatus(stringToPrint: (self.testTextField?.text!)!)
            testTextField?.resignFirstResponder()
        }
        else {
            return
        }
    }
    
    @IBAction func queryButton() {
        self.contentsDelegate!.printContainerStatus()
    }
}

extension ContentsViewController :UITextFieldDelegate {
    
    func textFieldShouldReturn(_ testTextField :UITextField) -> Bool {
        self.contentsDelegate!.printContentStatus(stringToPrint: (self.testTextField?.text!)!)
        testTextField.resignFirstResponder()
        return true
    }
    
}
