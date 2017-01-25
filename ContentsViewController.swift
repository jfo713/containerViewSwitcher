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

    weak var delegate :ContentsControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func updateButton() {
        self.delegate!.printStatus(stringToPrint: (self.testTextField?.text!)!)
    }
}

extension ContentsViewController :ContentsControllerDelegate {
    
    func printStatus(stringToPrint: String){}
    
}
