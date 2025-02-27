//
//  ContainerPickerViewController.swift
//  containerViewSwitcher
//
//  Created by James O'Connor on 1/24/17.
//  Copyright © 2017 James O'Connor. All rights reserved.
//

import UIKit

class ContainerPickerViewController: UIViewController {

    //IBOutlets
    @IBOutlet weak var containerView :UIView!
    @IBOutlet weak var containerTestLabel :UILabel!
    
    //Vars
    var contentsViewController :ContentsViewController?
    var contentsTag :Int?
    var testString :String?
    
    //View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        contentsViewController = self.storyboard?.instantiateViewController(withIdentifier: "redViewController") as! ContentsViewController?
        contentsViewController!.view.translatesAutoresizingMaskIntoConstraints = false
        self.addChildViewController(contentsViewController!)
        self.addSubviewWithConstraints(subView: contentsViewController!.view, toView: containerView)
        contentsViewController?.contentsDelegate = self
        contentsTag = 101
    }
    
    //IBActions
    @IBAction func updateContainer(sender :UIButton) {
        let buttonTag :Int = sender.tag
        if buttonTag == contentsTag {
            return
            }
        else {
            var identifier :String?
            switch buttonTag {
            case 101:
                identifier = "redViewController"
            case 102:
                identifier = "blueViewController"
            case 103:
                identifier = "greenViewController"
            case 104:
                identifier = "orangeViewController"
            case 105:
                identifier = "purpleViewController"
            default:
                print("default")
            }
            switchContentsViewController(identifier: identifier!)
            contentsTag = buttonTag
        }
    }

    //Background Methods

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func switchContentsViewController(identifier :String) {
        let newViewController = self.storyboard?.instantiateViewController(withIdentifier: identifier)
        newViewController?.view.translatesAutoresizingMaskIntoConstraints = false
        cycleFromViewController(oldViewController: contentsViewController!, toViewController: newViewController!)
        contentsViewController = newViewController as! ContentsViewController?
        contentsViewController?.contentsDelegate = self
    }
    
    private func cycleFromViewController(oldViewController :UIViewController, toViewController newViewController :UIViewController) {
        oldViewController.willMove(toParentViewController: nil)
        self.addChildViewController(newViewController)
        self.addSubviewWithConstraints(subView: newViewController.view, toView: containerView!)
        newViewController.view.alpha = 0
        newViewController.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.5, animations: {
            newViewController.view.alpha = 1
            oldViewController.view.alpha = 0
            },
                       completion: {finished in
                        oldViewController.view.removeFromSuperview()
                        oldViewController.removeFromParentViewController()
                        newViewController.didMove(toParentViewController: self)
        })
    }

    private func addSubviewWithConstraints(subView :UIView, toView parentView :UIView) {
        parentView.addSubview(subView)
        var viewBindingsDict = [String : AnyObject]()
        viewBindingsDict["subView"] = subView
        parentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[subView]|", options: [], metrics: nil, views: viewBindingsDict))
        parentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[subView]|", options: [], metrics: nil, views: viewBindingsDict))
    }
}

//Contents Delegate Methods
extension ContainerPickerViewController :ContentsControllerDelegate {
    
    func printContentStatus(stringToPrint: String) {
        testString = stringToPrint
        containerTestLabel.text = stringToPrint
    }
    
    func printContainerStatus() {
        if testString != nil {
            contentsViewController?.contentTestLabel?.text = testString
            }
        else {
            return
            }
    }
}
