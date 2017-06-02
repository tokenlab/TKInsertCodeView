//
//  TKCodeFieldView.swift
//  MobPago
//
//  Created by Daniele Boscolo on 31/05/17.
//  Copyright © 2017 Tokenlab. All rights reserved.
//

import UIKit

public protocol TKCodeFieldViewProtocol: class {
    var code: String? {get set}
    func setSelected(_ selected: Bool)
}

class TKCodeFieldView: UIView, TKCodeFieldViewProtocol {
    
    @IBOutlet weak var codeLabel: UILabel!
    
    fileprivate var definedBackgroundColor: UIColor!
    fileprivate var definedBorderColor: CGColor!
    
    fileprivate var definedSelectedBackgroundColor: UIColor!
    fileprivate var definedSelectedBorderColor: CGColor!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
    
    func loadNib() {
        let podBundle = Bundle(for: self.classForCoder)
        if let bundleURL = podBundle.url(forResource: "TKInsertCodeView", withExtension: "bundle") {
            if let bundle = Bundle(url: bundleURL) {
                let nib = UINib(nibName: "TKCodeFieldView", bundle: bundle)
                if let view = nib.instantiate(withOwner: self, options: nil).first as? UIView  {
                    view.frame = bounds
                    view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
                    view.isUserInteractionEnabled = true
                    addSubview(view)
                    clipsToBounds = true
                }
            } else {
                assertionFailure("Could not load the bundle")
            }
        } else {
            assertionFailure("Could not create a path to the bundle")
        }
    }
    
    func setAppearance(cornerRadius: CGFloat,
                       borderWith: CGFloat,
                       fontName: String,
                       fontSize: CGFloat,
                       textColor: UIColor,
                       backgroundColor: UIColor,
                       borderColor: CGColor,
                       selectedBackgroundColor: UIColor,
                       selectedBorderColor: CGColor) {
        
        definedBackgroundColor = backgroundColor
        definedBorderColor = borderColor
        
        definedSelectedBackgroundColor = selectedBackgroundColor
        definedSelectedBorderColor = selectedBorderColor
        
        codeLabel.textColor = textColor
        codeLabel.font = UIFont(name: fontName, size: fontSize)
        layer.borderWidth = borderWith
        layer.cornerRadius = cornerRadius
    }
    
    var code: String? {
        get {
            return codeLabel.text
        }
        set {
            codeLabel.text = newValue
        }
    }
    
    func setSelected(_ selected: Bool) {
        if selected {
            backgroundColor = definedSelectedBackgroundColor
            layer.borderColor = definedSelectedBorderColor
        } else {
            backgroundColor = definedBackgroundColor
            layer.borderColor = definedBorderColor
        }
    }
}
