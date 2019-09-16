//
//  UICountedTextView.swift
//  Move
//
//  Created by Zhou Hao on 30/5/17.
//  Copyright © 2017 Zhou Hao. All rights reserved.
//

import UIKit

@IBDesignable
public class UICountedTextView: UIView, UITextViewDelegate {

  weak var labelCount: UILabel!
  weak private var textView: UITextView!
  weak var labelPlaceHolder: UILabel!
  
  var onTextChanged:((String)->())?
    
  @IBInspectable
  var maxCharactersAllowed: Int = 250 {
    didSet {
      // TODO: cut the text if it exceeds the the max characters
      textViewDidChange(textView)
    }
  }
    
  @IBInspectable
  var borderColor: UIColor = UIColor.clear {
    didSet {
      setupBorder()
    }
  }
  
  @IBInspectable
  var borderWidth: CGFloat = 0 {
    didSet {
      setupBorder()
    }
  }
  
  @IBInspectable
  var radius: CGFloat = 0 {
    didSet {
      setupRoundedCorner()
    }
  }
  
  @IBInspectable
  var placeHolder: String {
    get {
      return labelPlaceHolder.text ?? ""
    }
    set {
      labelPlaceHolder.text = newValue
    }
  }

  var text: String {
    get {
      return textView.text
    }
    set {
      textView.text = newValue
      updateCount()
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  private func setup() {
    
    // Count label
    let labelCount = UILabel(frame: CGRect.zero)
    self.addSubview(labelCount)
    labelCount.translatesAutoresizingMaskIntoConstraints = false
    labelCount.textAlignment = .right
    labelCount.textColor = .gray
    labelCount.font = UIFont.systemFont(ofSize: 15)
    self.labelCount = labelCount
    
    // TextView
    let textView = UITextView(frame: CGRect.zero)
    self.addSubview(textView)
    textView.translatesAutoresizingMaskIntoConstraints = false
    textView.delegate = self
    self.textView = textView
    
    // Placeholder label
    let labelPlaceHolder = UILabel(frame: CGRect.zero)
    self.addSubview(labelPlaceHolder)
    labelPlaceHolder.textColor = UIColor.lightGray
    labelPlaceHolder.translatesAutoresizingMaskIntoConstraints = false
    self.labelPlaceHolder = labelPlaceHolder
    
    // Setup constraints
    NSLayoutConstraint.activate([
      self.labelCount.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
      self.labelCount.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
      self.labelCount.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
      self.labelCount.heightAnchor.constraint(greaterThanOrEqualToConstant: 20)
    ])
    
    NSLayoutConstraint.activate([
      self.textView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
      self.textView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
      self.textView.topAnchor.constraint(equalTo: self.labelCount.bottomAnchor, constant: 8),
      self.textView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 8),
    ])

    NSLayoutConstraint.activate([
      self.labelPlaceHolder.leadingAnchor.constraint(equalTo: self.textView.leadingAnchor, constant: 4),
      self.labelPlaceHolder.trailingAnchor.constraint(equalTo: self.textView.trailingAnchor, constant: -4),
      self.labelPlaceHolder.topAnchor.constraint(equalTo: self.textView.topAnchor, constant: 4),
      self.labelPlaceHolder.heightAnchor.constraint(greaterThanOrEqualToConstant: 20)
    ])

    setupBorder()
    setupRoundedCorner()
  }
  
  private func setupBorder() {
    textView.layer.borderColor = borderColor.cgColor
    textView.layer.borderWidth = borderWidth
  }
  
  private func setupRoundedCorner() {
    textView.layer.cornerRadius = radius
  }
    
  override public func becomeFirstResponder() -> Bool {
    return textView.becomeFirstResponder()
  }
  
  // MARK: UITextViewDelegate
  public func textViewDidBeginEditing(_ textView: UITextView) {
    updatePlaceholder()
  }
  
  public func textViewDidEndEditing(_ textView: UITextView) {
    updatePlaceholder()
  }
  
  public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    return textView.text.count + (text.count - range.length) <= maxCharactersAllowed
  }
  
  public func textViewDidChange(_ textView: UITextView) {
    if let call = onTextChanged {
      call(textView.text)
    }
    updateCount()
  }
  
  private func updatePlaceholder() {
    if text.count == 0 {
      self.labelPlaceHolder.isHidden = false
    } else {
      if !self.labelPlaceHolder.isHidden {
        self.labelPlaceHolder.isHidden = true
      }
    }
  }
  
  private func updateCount() {
    labelCount.text = "\(maxCharactersAllowed - textView.text.count) characters left"
    updatePlaceholder()
  }
}
