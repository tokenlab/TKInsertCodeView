//
//  ViewController.swift
//  Example
//
//  Created by Daniele Boscolo on 01/06/17.
//  Copyright © 2017 Tokenlab. All rights reserved.
//

import UIKit
import TKInsertCodeView

class ViewController: UIViewController {

    @IBOutlet weak var firstInsertCodeView: TKInsertCodeView!
    @IBOutlet weak var secondInsertCodeView: TKInsertCodeView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        firstInsertCodeView.setBecomeFirstResponder()
        secondInsertCodeView.codeFieldView = CustomCodeFieldView.init
    }
}

