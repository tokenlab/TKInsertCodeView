//
//  UIView+Bundle.swift
//  TKInsertCodeView
//
//  Created by Daniele Boscolo on 02/06/17.
//  Copyright © 2017 Tokenlab. All rights reserved.
//

import UIKit

extension UIView {
    func bundle() -> Bundle {
        // framework bundle
        var bundle = Bundle(for: self.classForCoder)
        if let bundleURL = bundle.url(forResource: "TKInsertCodeView", withExtension: "bundle") {
            // bundle for CocoaPods integration
            if let podBundle = Bundle(url: bundleURL) {
                bundle = podBundle
            } else {
                assertionFailure("Could not load TKInsertCodeView bundle")
            }
        }
        // bundle found
        return bundle
    }
}
