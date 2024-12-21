//
//  Reusable textfield.swift
//  Country-App
//
//  Created by Yusıf Aqakerımov on 10.12.24.
//

import Foundation
import UIKit

class ReusableTextField: UITextField {

    private var placeholderText: String
    private var leftPadding: CGFloat
    private var bgcolor: UIColor?
    init(placeholder: String,  leftPadding: CGFloat = 10 , bgcolor: UIColor) {
        self.placeholderText = placeholder
        self.bgcolor = bgcolor
        self.leftPadding = leftPadding
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Allah sizi qorusun")
    }
    
    func setupUI() {
        attributedPlaceholder = NSAttributedString(
            string: placeholderText,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]
        )
        translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = bgcolor
        textColor = .black
        textAlignment = .left
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor
        setLeftPadding(leftPadding)
    }
    
        private func setLeftPadding(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: frame.height))
        leftView = paddingView
        leftViewMode = .always
    }
}
