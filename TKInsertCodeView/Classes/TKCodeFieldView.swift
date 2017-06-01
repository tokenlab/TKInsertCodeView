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
    
    fileprivate var borderColor: CGColor!
    fileprivate var selectedBorderColor: CGColor!

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
    
    func loadNib() {
        guard let nib = Bundle(for: TKCodeFieldView.self).loadNibNamed("TKCodeFieldView", owner: self)?[0] as? UIView else {
            return
        }
        nib.frame = bounds
        nib.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        nib.isUserInteractionEnabled = true
        addSubview(nib)
        
        clipsToBounds = true
    }
    
    func setAppearance(borderWith: CGFloat, borderColor: CGColor, selectedBorderColor: CGColor, cornerRadius: CGFloat, selected: Bool) {
        self.borderColor = borderColor
        self.selectedBorderColor = selectedBorderColor
        layer.borderWidth = borderWith
        layer.cornerRadius = cornerRadius
        setSelected(selected)
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
            layer.borderColor = selectedBorderColor
        } else {
            layer.borderColor = borderColor
        }
    }
}
