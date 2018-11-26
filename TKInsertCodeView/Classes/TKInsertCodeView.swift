//
//  TKInsertCodeView.swift
//  MobPago
//
//  Created by Leonardo Sampaio Ferraz Ribeiro on 29/05/17.
//  Copyright © 2017 Tokenlab. All rights reserved.
//

import UIKit

public protocol TKInsertCodeViewDelegate {
    func tkInsertCodeView(_ tkInsertCodeView: TKInsertCodeView, didChangeCode code: String)
    func tkInsertCodeView(_ tkInsertCodeView: TKInsertCodeView, didFinishWritingCode code: String)
}

public extension TKInsertCodeViewDelegate {
    public func tkInsertCodeView(_ tkInsertCodeView: TKInsertCodeView, didChangeCode code: String) {}
    public func tkInsertCodeView(_ tkInsertCodeView: TKInsertCodeView, didFinishWritingCode code: String) {}
}

public class TKInsertCodeView: UIView {
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var codeStackView: UIStackView!
    
    public var delegate: TKInsertCodeViewDelegate?
    public var codeFieldView: (() -> TKCodeFieldViewProtocol) = TKCodeFieldView.init {
        didSet {
            configureCodeViews()
        }
    }
    
    var selectedField: Int = -1 {
        didSet {
            cofigureSelectedCodeFieldView()
        }
    }
    
    public var code: String? {
        get {
            return codeTextField.text
        }
        set {
            codeTextField.text = newValue
            codeTextField.sendActions(for: .editingChanged)
        }
    }
    
    // MARK:- IBInspectables
    
    @IBInspectable public var secretCode: Bool = false
    @IBInspectable public var numberOfFields: Int = 4
    @IBInspectable public var spacing: CGFloat = 10.0
    @IBInspectable public var cornerRadius: CGFloat = 7.0
    @IBInspectable public var borderWidth: CGFloat = 1.0
    @IBInspectable public var fontName: String = "Helvetica"
    @IBInspectable public var fontSize: CGFloat = 17.0
    @IBInspectable public var textColor: UIColor = #colorLiteral(red: 0.4078431373, green: 0.4078431373, blue: 0.4078431373, alpha: 1)
    @IBInspectable public var backgroundColorField: UIColor = #colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)
    @IBInspectable public var borderColor: UIColor = #colorLiteral(red: 0.7960784314, green: 0.7960784314, blue: 0.7960784314, alpha: 1)
    @IBInspectable public var selecBackgroundColorField: UIColor = #colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)
    @IBInspectable public var selecBorderColor: UIColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 0.7714484279)
    @IBInspectable public var invalidBackgroundColorField: UIColor = #colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)
    @IBInspectable public var invalidBorderColor: UIColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
    
    // MARK:- Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
    
    func loadNib() {
        if let view = bundle.loadNibNamed("TKInsertCodeView", owner: self)?.first as? UIView {
            view.frame = bounds
            view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            view.isUserInteractionEnabled = true
            addSubview(view)
            
            codeTextField.delegate = self
            codeTextField.addTarget(self, action: #selector(codeFieldDidChange(_:)), for: .editingChanged)
        } else {
            assertionFailure("Could not load nib TKInsertCodeView. ")
        }
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        configureCodeViews()
        configureCodeViewsAppearance()
        cofigureSelectedCodeFieldView()
    }
    
    // MARK:- Configurations
    
    fileprivate func configureCodeViews() {
        codeStackView.spacing = spacing
        
        // Clear stack view
        codeStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        // Add new views
        for index in 0..<numberOfFields {
            if let codeView = codeFieldView() as? UIView {
                codeView.tag = index
                
                let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTapOnDigitView(_:)))
                codeView.addGestureRecognizer(gestureRecognizer)
                codeStackView.addArrangedSubview(codeView)
            }
        }
    }
    
    fileprivate func configureCodeViewsAppearance() {
        codeStackView.arrangedSubviews.enumerated().forEach { (index, view) in
            if let codeFieldView = view as? TKCodeFieldView {
                codeFieldView.setAppearance(
                    cornerRadius: cornerRadius,
                    borderWith: borderWidth,
                    fontName: fontName,
                    fontSize: fontSize,
                    textColor: textColor,
                    backgroundColor: backgroundColorField,
                    borderColor: borderColor.cgColor,
                    selectedBackgroundColor: selecBackgroundColorField,
                    selectedBorderColor: selecBorderColor.cgColor,
                    invalidateBackgroundColor: invalidBackgroundColorField,
                    invalidateBorderColor: invalidBorderColor.cgColor
                )
            }
        }
    }
    
    fileprivate func cofigureSelectedCodeFieldView() {
        codeStackView.arrangedSubviews.enumerated().forEach { (index, view) in
            if let codeFieldView = view as? TKCodeFieldViewProtocol {
                codeFieldView.setSelected(index == selectedField)
            }
        }
    }
    
    // MARK:- Public functions
    
    public func setBecomeFirstResponder() {
        selectedField = 0
        codeTextField.becomeFirstResponder()
    }
    
    public func setResignFirstResponder() {
        codeTextField.resignFirstResponder()
    }
    
    public func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
    
    public func validate() {
        codeStackView.arrangedSubviews.enumerated().forEach { (index, view) in
            if let codeFieldView = view as? TKCodeFieldViewProtocol {
                codeFieldView.setValidated(true)
            }
        }
        cofigureSelectedCodeFieldView()
    }
    
    public func invalidate() {
        codeStackView.arrangedSubviews.enumerated().forEach { (index, view) in
            if let codeFieldView = view as? TKCodeFieldViewProtocol {
                codeFieldView.setValidated(false)
            }
        }
    }
    
    // MARK:- Private functions
    
    @objc func didTapOnDigitView(_ sender: UITapGestureRecognizer) {
        guard let view = sender.view else { return }
        codeTextField.becomeFirstResponder()
        let position = view.tag
        makeSelectionForPosition(position)
    }
    
    fileprivate func makeSelectionForPosition(_ position: Int) {
        let selectedPosition:Int
        if let newPosition = codeTextField.position(from: codeTextField.beginningOfDocument, offset: position),
            let selection = codeTextField.position(from: codeTextField.beginningOfDocument, offset: position+1) {
            codeTextField.selectedTextRange = codeTextField.textRange(from: newPosition, to: selection)
            selectedPosition = position
        } else {
            codeTextField.selectedTextRange = codeTextField.textRange(from: codeTextField.endOfDocument, to: codeTextField.endOfDocument)
            selectedPosition = codeTextField.offset(from: codeTextField.beginningOfDocument, to: codeTextField.endOfDocument)
        }
        selectedField = selectedPosition
    }
    
    @objc func codeFieldDidChange(_ textField: UITextField) {
        if let selectedRange = codeTextField.selectedTextRange {
            makeSelectionForPosition(codeTextField.offset(from: codeTextField.beginningOfDocument, to: selectedRange.start))
        }
        
        guard let text =  textField.text else { return }

        if selectedField != -1 {
            delegate?.tkInsertCodeView(self, didChangeCode: text)
        }
        
        for (index, character) in text.enumerated() {
            guard let view = codeStackView.arrangedSubviews.first(where: { $0.tag == index }), let codeFieldView = view as? TKCodeFieldViewProtocol else { continue }
            codeFieldView.code = secretCode ? "•" : "\(character)"
        }
        for index in text.count..<6 {
            guard let view = codeStackView.arrangedSubviews.first(where: { $0.tag == index }), let codeFieldView = view as? TKCodeFieldViewProtocol else { continue }
            codeFieldView.code = ""
        }
        
        if text.count == codeStackView.arrangedSubviews.count  { delegate?.tkInsertCodeView(self, didFinishWritingCode: text) }
    }
}

extension TKInsertCodeView: UITextFieldDelegate {
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if range.location == codeStackView.arrangedSubviews.count { return false }
        if let text = textField.text,
            range.length == 0,
            text.count >= codeStackView.arrangedSubviews.count {
            return false
        }
        return true
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        selectedField = -1
    }
}
