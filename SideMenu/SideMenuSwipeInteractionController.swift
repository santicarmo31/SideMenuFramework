//
//  SideMenuSwipeInteractionController.swift
//  SideMenu
//
//  Created by Santiago Carmona gonzalez on 10/28/18.
//  Copyright © 2018 Santiago Carmona Gonzalez. All rights reserved.
//

import UIKit

public class SideMenuShowSwipeInteractionController: UIPercentDrivenInteractiveTransition {
    
    internal var interactionInProgress = false
    
    private var shouldCompleteTransition = false
    private weak var viewController: UIViewController!
    
    public init(viewController: SideMenuViewControllerDelegate) {
        super.init()
        self.viewController = (viewController as! UIViewController)
        prepareGestureRecognizer(in: self.viewController.view)
        wantsInteractiveStart = false
    }
    
    private func prepareGestureRecognizer(in view: UIView) {
        let gesture = UIScreenEdgePanGestureRecognizer(target: self,
                                                       action: #selector(handleGesture(_:)))
        gesture.edges = .left
        view.addGestureRecognizer(gesture)
    }
    
    @objc func handleGesture(_ gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
        let translation = gestureRecognizer.translation(in: gestureRecognizer.view!.superview!)
        let translationProgress = (translation.x / viewController.view.frame.width)
        let progress = CGFloat(fminf(fmaxf(Float(translationProgress), 0.0), 1.0))
        
        switch gestureRecognizer.state {
        case .began:
            interactionInProgress = true
            let sideMenu = (viewController as! SideMenuViewControllerDelegate).sideMenu
            viewController.present(sideMenu, animated: true, completion: nil)
        case .changed:
            shouldCompleteTransition = progress > 0.3
            update(translationProgress)
        case .cancelled:
            interactionInProgress = false
            cancel()
        case .ended:
            interactionInProgress = false
            if shouldCompleteTransition {
                finish()
            } else {
                cancel()
            }
        default:
            break
        }
    }

}
