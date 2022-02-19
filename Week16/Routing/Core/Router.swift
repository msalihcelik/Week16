//
//  Router.swift
//  Routing
//
//  Created by Nikita Ermolenko on 29/09/2017.
//

import UIKit

protocol RouterProtocol: AnyObject {
    var viewController: UIViewController? { get }

    func open(_ viewController: UIViewController, transition: Transition)
    func close(completion: (() -> Void)?)
}

class Router: RouterProtocol {
    
    weak var viewController: UIViewController?
    var openTransition: Transition?

    func open(_ viewController: UIViewController, transition: Transition) {
        transition.viewController = self.viewController
        transition.open(viewController)
    }

    func close(completion: (() -> Void)?) {
        guard let openTransition = openTransition else {
            assertionFailure("You should specify an open transition in order to close a module.")
            return
        }
        guard let viewController = viewController else {
            assertionFailure("Nothing to close.")
            return
        }
        openTransition.close(viewController, completion: completion)
    }
    
    deinit {
        debugPrint("deinit \(self)")
    }
}
