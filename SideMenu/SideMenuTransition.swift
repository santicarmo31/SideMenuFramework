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
public class SideMenuTransition: NSObject, UIViewControllerAnimatedTransitioning {

    private let originFrame: CGRect
    private let transitionDuration: TimeInterval = 0.4
    private let relativeDuration: TimeInterval = 1.0
    private var isDismissing: Bool
    let interactionController: SideMenuSwipeInteractionController?

    /**
     * Creates UIViewControllerAnimatedTransition
     * - parameters:
     *   - originFrame: Starting point of the animation
     *   - dismissing: `true` if the transition is from a dismissing `ViewController`, otherwise default `false`
     */
    public init(originFrame: CGRect, dismissing: Bool = false, interactionController: SideMenuSwipeInteractionController? = nil) {
        self.originFrame = originFrame
        isDismissing = dismissing
        self.interactionController = interactionController
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

        var animation: (() -> Void)!

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
            if transitionContext.transitionWasCancelled {
                toViewController.view.removeFromSuperview()
            }
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }

        UIView.animateKeyframes(
            withDuration: duration,
            delay: 0,
            options: .calculationModeCubic,
            animations: animation,
            completion: completion
        )
    }


    private func createShowMenuAnimation(menuViewController: UIViewController, presentingViewController: UIViewController) {
        menuViewController.view.frame.origin.x = 0.0
        presentingViewController.view.alpha = 0.7
    }

    private func createHideMenuAnimation(menuViewController: UIViewController, presentingViewController: UIViewController) {
        menuViewController.view.frame.origin.x = -self.originFrame.width
        presentingViewController.view.alpha = 1.0
    }

}
