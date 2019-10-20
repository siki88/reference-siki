//
//  UIViewController.swift
//  test
//
//  Created by Lukáš Spurný on 17/10/2019.
//  Copyright © 2019 sikisift. All rights reserved.
//

import UIKit

extension UIViewController {
    
    //  MARK: Storyboard redirection
    static func instantiate<TController: UIViewController>(_ storyboardName: String) -> TController {
        return instantiateFromStoryboardHelper(storyboardName)
    }
    
    static func instantiate<TController: UIViewController>(_ storyboardName: String, identifier: String) -> TController {
        return instantiateFromStoryboardHelper(storyboardName, identifier: identifier)
    }
    
    fileprivate static func instantiateFromStoryboardHelper<T: UIViewController>(_ name: String, identifier: String? = nil) -> T {
        let storyboard = UIStoryboard(name: name, bundle: Bundle(for: self))
        return storyboard.instantiateViewController(withIdentifier: identifier ?? String(describing: self)) as! T
    }
    
    static func instantiate<TController: UIViewController>(xibName: String? = nil) -> TController {
        return TController(nibName: xibName ?? String(describing: self), bundle: Bundle(for: self))
    }
    
    
    //  MARK: Alert
    func presentAlert(title: String?, message: String, actions: UIAlertAction..., animated: Bool = true) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach { alert.addAction($0) }
        self.present(alert, animated: animated, completion: nil)
    }
//    MARK: Example for alert
//    let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
//    })
//    let cancel = UIAlertAction(title: "OK", style: .default, handler: nil)
//    presentAlert(title: "save item?", message: "", actions: enter, cancel)
    
    
    //    func presentActionSheet(title: String?, message: String, actions: UIAlertAction..., animated: Bool = true) {
    //        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
    //        actions.forEach { alert.addAction($0) }
    //        self.present(alert, animated: animated, completion: nil)
    //    }
}

