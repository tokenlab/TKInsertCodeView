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
    func setValidated(_ validated: Bool)
}



class TKCodeFieldView: UIView, TKCodeFieldViewProtocol {
    
    @IBOutlet weak var codeLabel: UILabel!
    
    fileprivate var definedBackgroundColor: UIColor!
    fileprivate var definedBorderColor: CGColor!
    
    fileprivate var definedSelectedBackgroundColor: UIColor!
    fileprivate var definedSelectedBorderColor: CGColor!
    
    fileprivate var definedInvalidateBackgroundColor: UIColor!
    fileprivate var definedInvalidateBorderColor: CGColor!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
    
    func loadNib() {
        if let view = bundle.loadNibNamed("TKCodeFieldView", owner: self)?.first as? UIView {
            view.frame = bounds
            view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            view.isUserInteractionEnabled = true
            addSubview(view)
            clipsToBounds = true
        } else {
            assertionFailure("Could not load nib TKCodeFieldView. ")
        }
    }
    
    func setAppearance(cornerRadius: CGFloat,
                       borderWidth: CGFloat,
                       font: UIFont,
                       textColor: UIColor,
                       backgroundColor: UIColor,
                       borderColor: CGColor,
                       selectedBackgroundColor: UIColor,
                       selectedBorderColor: CGColor,
                       invalidateBackgroundColor: UIColor,
                       invalidateBorderColor: CGColor) {
        
        definedBackgroundColor = backgroundColor
        definedBorderColor = borderColor
        definedSelectedBackgroundColor = selectedBackgroundColor
        definedSelectedBorderColor = selectedBorderColor
        
        definedInvalidateBackgroundColor = invalidateBackgroundColor
        definedInvalidateBorderColor = invalidateBorderColor

        codeLabel.textColor = textColor
        codeLabel.font = font
        
        layer.borderWidth = borderWidth
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
    
    func setValidated(_ validated: Bool) {
        if validated {
            backgroundColor = definedBackgroundColor
            layer.borderColor = definedBorderColor
        } else {
            backgroundColor = definedInvalidateBackgroundColor
            layer.borderColor = definedInvalidateBorderColor
        }
    }
}

