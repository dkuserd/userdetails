//
//  HamMenuTransition.swift
//  UserDetails
//
//  Created by Dadha Kumar on 11/5/20.
//  Copyright © 2020 Dadha Kumar. All rights reserved.
//

import UIKit

class HamMenuTransition: NSObject, UIViewControllerAnimatedTransitioning {
    var showVC = false
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.2
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toVC = transitionContext.viewController(forKey: .to),
            let fromVC = transitionContext.viewController(forKey: .from) else { return }
        let containerView = transitionContext.containerView
        
        let calWidth = toVC.view.bounds.width * 0.8
        let calHeight = toVC.view.bounds.height
        
        if showVC {
            containerView.addSubview(toVC.view)
            
            toVC.view.frame = CGRect(x: -calWidth, y: 0, width: calWidth, height: calHeight)
        }
        
        let transfromVC = {
            toVC.view.transform = CGAffineTransform(translationX: calWidth, y: 0)
        }
        
        let resetVC = {
            fromVC.view.transform = .identity
        }
        
        let withDuration = transitionDuration(using: transitionContext)
        let cancelStatus = transitionContext.transitionWasCancelled
        UIView.animate(withDuration: withDuration, animations: {
            self.showVC ? transfromVC() : resetVC()
        }) { (_) in
            transitionContext.completeTransition(!cancelStatus)
        }
    }
}
