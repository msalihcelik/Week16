//
//  UINavigation+Extensions.swift
//  Week16
//
//  Created by Mehmet Salih ÇELİK on 30.01.2022.
//

import UIKit

public extension UINavigationController {
    
    func push(nextViewController: UIViewController, options: UIView.AnimationOptions, duration: TimeInterval = 1) {
        UIView.transition(with: self.view,
                          duration: duration,
                          options: options,
                          animations: { self.pushViewController(nextViewController, animated: false) },
                          completion: nil)
    }

    func pop(options: UIView.AnimationOptions, duration: TimeInterval = 1) {
        UIView.transition(with: self.view,
                          duration: duration,
                          options: options,
                          animations: { self.popViewController(animated: false) },
                          completion: nil)
    }
}
