//
//  File.swift
//  Country-App
//
//  Created by Yusıf Aqakerımov on 10.12.24.
//

import Foundation
import UIKit

class Button: UIButton {
    
    private var title: String
    private var onAction: () -> Void
    
    init(title: String, onAction: @escaping () -> Void) {
        self.title = title
        self.onAction = onAction
        super .init(frame: .zero)
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("Allah sizi qorusun")
    }
    
    func setupUI(){
       setTitle(title, for: .normal)
       titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
       setTitleColor(.black, for: .normal)
       backgroundColor = .white.withAlphaComponent(0.3)
       addTarget(self, action: #selector(clicked), for: .touchUpInside)
       layer.cornerRadius = 10
       layer.borderWidth = 0.5
       layer.borderColor = UIColor.white.cgColor
       
    }
    
    @objc func clicked(){
        onAction()
    }
}
