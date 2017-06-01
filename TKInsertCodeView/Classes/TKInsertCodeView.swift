//
//  TKInsertCodeView.swift
//  MobPago
//
//  Created by Leonardo Sampaio Ferraz Ribeiro on 29/05/17.
//  Copyright © 2017 Tokenlab. All rights reserved.
//

import UIKit

public protocol TKInsertCodeViewDelegate {
    func didChangeCode(_ code: String)
    func didFinishWritingCode(_ code: String)
}

extension TKInsertCodeViewDelegate {
    func didChangeCode(_ code: String) {}
    func didFinishWritingCode(_ code: String) {}
}

@IBDesignable
public class TKInsertCodeView: UIView {
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var codeStackView: UIStackView!

    var selectedField: Int = 0
    public var delegate: TKInsertCodeViewDelegate?
    public var codeFieldView: (() -> TKCodeFieldViewProtocol) = TKCodeFieldView.init {
        didSet {
            configureCodeViews()
        }
    }
    
    // MARK:- IBInspectables
    
    @IBInspectable var secretCode: Bool = false
    
    @IBInspectable var numberOfFields: Int = 4 {
        didSet {
            configureCodeViews()
        }
    }
    
    @IBInspectable var spacing: CGFloat = 10.0 {
        didSet {
            codeStackView.spacing = spacing
        }
    }
    
    @IBInspectable var fieldBackgroundColor: UIColor = #colorLiteral(red: 0.9436354041, green: 0.9436575174, blue: 0.9436456561, alpha: 1) {
        didSet {
            configureCodeViewsAppearance()
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 1.0 {
        didSet {
            configureCodeViewsAppearance()
        }
    }
    
    @IBInspectable var borderColor: UIColor = .lightGray {
        didSet {
            configureCodeViewsAppearance()
        }
    }
    
    @IBInspectable var selectedBorderColor: UIColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1) {
        didSet {
            configureCodeViewsAppearance()
        }
    }

    @IBInspectable var cornerRadius: CGFloat = 10.0 {
        didSet {
            configureCodeViewsAppearance()
        }
    }
    
    // MARK:- Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
    
    func loadNib() {
        guard let nib = Bundle(for: TKInsertCodeView.self).loadNibNamed("TKInsertCodeView", owner: self)?[0] as? UIView  else {
            return
        }
        nib.frame = bounds
        nib.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        nib.isUserInteractionEnabled = true
        addSubview(nib)
        
        // Customization
        codeTextField.delegate = self
        codeTextField.addTarget(self, action: #selector(codeFieldDidChange(_:)), for: .editingChanged)
        configureCodeViews()
        configureCodeViewsAppearance()
    }

    // MARK:- Public functions

    public func setFirstResponder() {
        codeTextField.becomeFirstResponder()
    }
    
    // MARK:- Private functions
    
    fileprivate func configureCodeViews() {
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
                    borderWith: borderWidth,
                    borderColor: borderColor.cgColor,
                    selectedBorderColor: selectedBorderColor.cgColor,
                    cornerRadius: cornerRadius,
                    selected: index == selectedField
                )
            }
        }
    }
    
    func didTapOnDigitView(_ sender: UITapGestureRecognizer) {
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
        selectField(selectedPosition)
    }
    
    fileprivate func selectField(_ position: Int) {
        if let previouslySelected = codeStackView.arrangedSubviews.first(where: { $0.tag == selectedField }), let codeFieldView = previouslySelected as? TKCodeFieldViewProtocol {
            codeFieldView.setSelected(false)
        }
        guard let newlySelectedField = codeStackView.arrangedSubviews.first(where: { $0.tag == position }), let codeFieldView = newlySelectedField as? TKCodeFieldViewProtocol else { return }
        codeFieldView.setSelected(true)
        selectedField = position
    }
    
    func codeFieldDidChange(_ textField: UITextField) {
        if let selectedRange = codeTextField.selectedTextRange {
            makeSelectionForPosition(codeTextField.offset(from: codeTextField.beginningOfDocument, to: selectedRange.start))
        }
        
        guard let text =  textField.text else { return }
        if text.characters.count ==  codeStackView.arrangedSubviews.count { delegate?.didFinishWritingCode(text) }
        delegate?.didChangeCode(text)
        for (index, character) in text.characters.enumerated() {
            guard let view = codeStackView.arrangedSubviews.first(where: { $0.tag == index }), let codeFieldView = view as? TKCodeFieldViewProtocol else { continue }
            codeFieldView.code = secretCode ? "•" : "\(character)"
        }
        for index in text.characters.count..<6 {
            guard let view = codeStackView.arrangedSubviews.first(where: { $0.tag == index }), let codeFieldView = view as? TKCodeFieldViewProtocol else { continue }
            codeFieldView.code = ""
        }
    }
}

extension TKInsertCodeView: UITextFieldDelegate {
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if range.location == codeStackView.arrangedSubviews.count { return false }
        if let text = textField.text,
            range.length == 0,
            text.characters.count >= codeStackView.arrangedSubviews.count {
            return false
        }
        return true
    }
}
