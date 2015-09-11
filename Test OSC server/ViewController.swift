//
//  ViewController.swift
//  Test OSC server
//
//  Created by Yerdikul Nurbolat on 9/11/15.
//  Copyright © 2015 Yerdikul Nurbolat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var requestType : RequestAPI.RequestMethods!
    var alertController : UIAlertController!
    @IBOutlet weak var methodNameButton: UIButton!
    @IBOutlet weak var sendRequestButton: UIButton!
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - Helper
extension ViewController {
   
    func createMethodsAlertController() {
        alertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)

        for method in RequestAPI.RequestMethods.allValues {
            let buttonAction: UIAlertAction = UIAlertAction(title: method.rawValue, style: UIAlertActionStyle.Default, handler: { (action: UIAlertAction!) -> () in
                self.requestType = method
                self.methodNameButton.setTitle(self.requestType.rawValue, forState: .Normal)
                self.sendRequestButton.enabled = true
            })
            alertController.addAction(buttonAction)
        }
    }

    func sendRequest() {
        RequestAPI.sharedInstance.sendMessage("Testing \(requestType.rawValue) method", mathodName: requestType)
        showSuccesAlert()
    }
    func showSuccesAlert() {
        let succesAlert = UIAlertController(title: "Отправлено", message: nil, preferredStyle: .Alert)
        let buttonAction: UIAlertAction = UIAlertAction(title: "Ок", style: UIAlertActionStyle.Default, handler: nil)
        succesAlert.addAction(buttonAction)
        self.presentViewController(succesAlert, animated: true, completion: nil)
    }
}

// MARK: - Action
extension ViewController {
    @IBAction func selectMethodTypesButtonPressed(sender: UIButton) {
        if alertController == nil {
            createMethodsAlertController()
        }
        if ( UI_USER_INTERFACE_IDIOM() == .Pad ) {
            alertController.popoverPresentationController?.sourceView = self.view
            alertController.popoverPresentationController?.sourceRect = sender.frame
        }
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    @IBAction func sendRequestButtonPressed(sender: AnyObject) {
        if requestType != nil {
            sendRequest()
        } else {
            // TODO: Show Alert
        }
    }
    
}