//
//  Navigation.swift
//  test
//
//  Created by Lukáš Spurný on 17/10/2019.
//  Copyright © 2019 sikisift. All rights reserved.
//

import UIKit

extension UINavigationController{
    
}

extension UIBarButtonItem{
    
//  MARK: SETTING BAR BUTTON ITEM
    static func menuButton(_ target: Any?, action: Selector, imageName: String?, title: String?) -> UIBarButtonItem {
        let button = UIButton(type: .system)
        let menuBarItem = UIBarButtonItem(customView: button)
        

        if let openImageName = imageName, !openImageName.isEmpty{
//      MARK: IMAGE
            button.setImage(UIImage(named: openImageName), for: .normal)
            menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 24).isActive = true

        }else if let openTitle = title, !openTitle.isEmpty{
//      MARK: TITLE
            button.setTitle(openTitle, for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        }
        
        button.tintColor = UIColor.black
        button.addTarget(target, action: action, for: .touchUpInside)
        
        menuBarItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        return menuBarItem
    }
    
}

extension UINavigationItem{
    
}

extension UINavigationBar{
    
//  MARK: COLOR NAVIGATION BAR
    func makeColorNavigationBar (){
        barTintColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1.0)
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
        titleTextAttributes = textAttributes
    }

}


