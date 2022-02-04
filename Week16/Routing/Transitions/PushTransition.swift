//
//  PushTransition.swift
//  Routing
//
//  Created by Nikita Ermolenko on 28/10/2017.
//

import UIKit

class PushTransition: NSObject {
    
    var animator: Animator?
    var isAnimated = true
    var completionHandler: (() -> Void)?
    var interactiveTransition: UIPercentDrivenInteractiveTransition!
    var interactiveGestureRecognizer: UIScreenEdgePanGestureRecognizer!
    weak var navigationController: UINavigationController!
    weak var viewController: UIViewController?
    
    init(animator: Animator? = nil, isAnimated: Bool = true) {
        self.animator = animator
        self.isAnimated = isAnimated
    }
    
    func setNavigationController(navigationController: UINavigationController?) {
        guard let navController = navigationController else { return }
        self.navigationController = navController
        interactiveGestureRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(self.handleTransitionGesture(_:)))
        interactiveGestureRecognizer.edges = .left
        interactiveGestureRecognizer!.delegate = self
        self.navigationController?.view.addGestureRecognizer(interactiveGestureRecognizer!)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
}

// MARK: - Transition

extension PushTransition: Transition {
    
    func open(_ viewController: UIViewController) {
        self.viewController?.navigationController?.delegate = self
//        self.viewController?.navigationController?.pushViewController(viewController, animated: isAnimated)
        self.viewController?.navigationController?.push(nextViewController: viewController, options: .transitionCurlUp)
    }
    
    func close(_ viewController: UIViewController, completion: (() -> Void)?) {
//        self.viewController?.navigationController?.popViewController(animated: isAnimated)
        self.viewController?.navigationController?.pop(options: .transitionCurlDown)
    }
}

// MARK: - UINavigationControllerDelegate

extension PushTransition: UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    func navigationController(_ navigationController: UINavigationController,
                              interactionControllerFor
                                animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveTransition
    }

    func navigationController(_ navigationController: UINavigationController,
                              didShow viewController: UIViewController,
                              animated: Bool) {
        completionHandler?()
    }
    
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let animator = animator else {
            return nil
        }
        if operation == .push {
            animator.isPresenting = true
            return animator
        } else {
            animator.isPresenting = false
            return animator
        }
    }
    
    @objc
    func handleTransitionGesture(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        let translate: CGPoint = recognizer.translation(in: recognizer.view)
        let percent: CGFloat = translate.x / recognizer.view!.bounds.size.width
        
        switch recognizer.state {
        case .began:
            interactiveTransition = UIPercentDrivenInteractiveTransition()
            navigationController?.popViewController(animated: true)
        case .changed:
            interactiveTransition?.update(percent)
        case .ended, .cancelled:
            interactiveTransition?.update(percent)
            let velocity: CGPoint = recognizer.velocity(in: recognizer.view)
            if percent > 0.5 || velocity.x > 500 {
                interactiveTransition.finish()
            } else {
                interactiveTransition.cancel()
            }
            interactiveTransition = nil
            navigationController.interactivePopGestureRecognizer?.delegate = nil
        default: break
        }
    }
    
}
