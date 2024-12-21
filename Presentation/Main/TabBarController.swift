//
//  ViewController.swift
//  Country-App
//
//  Created by Yusıf Aqakerımov on 07.12.24.
//

import UIKit

class TabBarController: UITabBarController {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.barTintColor = .clear
        tabBar.isTranslucent = true
        //tabBar.isTranslucent = false
        tabBar.shadowImage = UIImage()
        tabBar.backgroundImage = UIImage()
        
        tabBar.unselectedItemTintColor = .white.withAlphaComponent(0.4)
      bar()
    }
    
    func bar(){
        let firstVC = CountryViewController(viewModel:  CountryViewModule())
        firstVC.tabBarItem = UITabBarItem(title: "Info", image: UIImage(systemName: "globe")?.resize(to: CGSize(width: 35, height: 35)), tag: 1)
//        let secondVc = CountryViewController(viewModel:  CountryViewModule())
//        secondVc.tabBarItem = UITabBarItem(title: "Map",  image: UIImage(systemName: "scope")?.resize(to: CGSize(width: 35, height: 35)), tag: 2)
        
        viewControllers = [firstVC/* , secondVc*/]
    }
    
    func configureContraint(){
        NSLayoutConstraint.activate([
        ])
    }
}

