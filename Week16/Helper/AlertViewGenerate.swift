//
//  AlertViewGenerate.swift
//  Week16
//
//  Created by Mehmet Salih ÇELİK on 30.01.2022.
//

import Foundation
import UIKit

final class AlertViewGenerate {
    
    private var viewController = UIViewController()
    private var message: String = ""
    private var title: String = ""
    
    static let shared = AlertViewGenerate()
    
    func setViewController(_ viewController: UIViewController) -> AlertViewGenerate {
        self.viewController = viewController
        return self
    }
    
    func setTitle(_ title: String) -> AlertViewGenerate {
        self.title = title
        return self
    }
    
    func setMessage(_ message: String) -> AlertViewGenerate {
        self.message = message
        return self
    }
    
    func generate() {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        viewController.present(alert, animated: true, completion: nil)
    }
}
