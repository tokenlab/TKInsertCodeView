//
//  ViewController.swift
//  Example
//
//  Created by Daniele Boscolo on 01/06/17.
//  Copyright © 2017 Tokenlab. All rights reserved.
//

import UIKit
import TKInsertCodeView

class ExampleViewController: UIViewController {

    @IBOutlet weak var firstInsertCodeView: TKInsertCodeView!
    @IBOutlet weak var secondInsertCodeView: TKInsertCodeView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        firstInsertCodeView.setBecomeFirstResponder()
        secondInsertCodeView.codeFieldView = CustomCodeFieldView.init
    }
    
    @IBAction func shakeButtonTouchUpInside(_ sender: Any) {
        firstInsertCodeView.shake()
    }
    
    @IBAction func invalidateButtonTouchUpInside(_ sender: Any) {
        firstInsertCodeView.invalidate()
    }
    
    @IBAction func validateButtonTouchUpInside(_ sender: Any) {
        firstInsertCodeView.validate()
    }
    
    @IBAction func clearButtonTouchUpInside(_ sender: Any) {
        firstInsertCodeView.code = ""
    }
}

