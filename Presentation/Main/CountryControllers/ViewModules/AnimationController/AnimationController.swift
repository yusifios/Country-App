//
//  AnimationController.swift
//  Country-App
//
//  Created by Yusıf Aqakerımov on 10.12.24.
//

import UIKit

class AnimationController: UIViewController {
    
    private lazy var hello: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.font = UIFont(name: "TimesNewRomanPS-ItalicMT", size: 40)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var start: UIButton = {
        let button = Button(title: "Start", onAction: {[weak self] in self?.submitStart()})
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        [hello , start].forEach{view.addSubview($0)}
        configureConstraint()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.animateText("Hello World")
                }
    }
    
    private func configureConstraint(){
        NSLayoutConstraint.activate([
                    hello.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    hello.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                    start.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -44),
                    start.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0),
                    start.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0),
                    start.heightAnchor.constraint(equalToConstant: 40)
                ])
    }
    
    func animateText(_ text: String) {
            var characterIndex = 0
            let totalCharacters = text.count
            Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { timer in
                if characterIndex < totalCharacters {
                    self.hello.text?.append(text[text.index(text.startIndex, offsetBy: characterIndex)])
                    characterIndex += 1
                } else {
                    timer.invalidate()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        self.start.isHidden = false
                    }
                }
            }
        }
    
    @objc func submitStart(){
        let ct = CountryViewController(viewModel: CountryViewModule())
        navigationController?.pushViewController(ct, animated: true)
        
    }
   

}
