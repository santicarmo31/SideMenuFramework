//
//  SideMenuTransition.swift
//  SideMenu
//
//  Created by Santiago Carmona Gonzalez on 5/20/18.
//  Copyright © 2018 Santiago Carmona Gonzalez. All rights reserved.
//

import Foundation

/**
 * Makes a transition used in the MenuViewController
 */
public class SideMenuTransitionAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let transitionDuration: TimeInterval = 0.6
    private var isDismissing: Bool
    internal let interactionController: SideMenuShowSwipeInteractionController?
    internal let dismissInteractionController: SideMenuDismissSwipeInteractionController?

    /// Creates a custom transition to simulate a show or hide side menu
    ///
    /// - Parameters:
    ///   - dismissing: `true` if the transition is from a dismissing `ViewController`, otherwise default `false`
    ///   - showInteractionController: Interaction controller used to handle swipe pan gesture when showing `ViewController`
    ///   - dismissInteractionController: Interaction controller used to handle swipe pan gesture when dismissing `ViewController`
    public init(dismissing: Bool = false, showInteractionController: SideMenuShowSwipeInteractionController? = nil, dismissInteractionController: SideMenuDismissSwipeInteractionController? = nil) {
        isDismissing = dismissing
        self.interactionController = showInteractionController
        self.dismissInteractionController = dismissInteractionController
    }

    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionDuration
    }

    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        // Gets the viewController to present
        guard let fromViewController = transitionContext.viewController(forKey: .from),
            let toViewController = transitionContext.viewController(forKey: .to)
            else {
                return
        }

        let containerView = transitionContext.containerView

        var animation: (() -> Void)

        if isDismissing {
            animation = { [weak self] in
                self?.createHideMenuAnimation(menuViewController: fromViewController, presentingViewController: toViewController)
            }
        } else {
            animation = { [weak self] in
                self?.createShowMenuAnimation(menuViewController: toViewController, presentingViewController: fromViewController)
            }

            containerView.addSubview(toViewController.view)
            toViewController.view.frame.origin.x = -fromViewController.view.frame.width
        }

        let duration = transitionDuration(using: transitionContext)

        let completion: (Bool) -> Void = { (_) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
        UIView.animate(
            withDuration: duration,
            delay: 0,
            options: .curveEaseInOut,
            animations: animation,
            completion: completion
        )
    }


    private func createShowMenuAnimation(menuViewController: UIViewController, presentingViewController: UIViewController) {
        menuViewController.view.frame.origin.x = 0.0
        presentingViewController.view.alpha = 0.7
    }

    private func createHideMenuAnimation(menuViewController: UIViewController, presentingViewController: UIViewController) {
        menuViewController.view.frame.origin.x = -presentingViewController.view.frame.width        
        presentingViewController.view.alpha = 1.0
    }

}
