//
//  CustomTransition.swift
//  summator
//
//  Created by Alexey Pichukov on 11.02.17.
//  Copyright © 2017 Alexey Pichukov. All rights reserved.
//

import Foundation
import UIKit

/**
    This class is a revised version of the class `BubbleTransition` from Andrea Mazzini's pod with `BubbleTransition` name
    (https://github.com/andreamazz/BubbleTransition)
*/
class CustomTransition: NSObject {
    
    var startingPoint = CGPoint.zero {
        didSet {
            view.center = startingPoint
        }
    }
    var dismissPoint = CGPoint.zero
    var duration = 0.3
    var transitionMode: TransitionMode = .present
    var transitionType: TransitionType = .circle
    var transitionColor: UIColor = .white
    fileprivate(set) var view = UIView()
    
    enum TransitionMode {
        case present
        case dismiss
        case pop
    }
    
    enum TransitionType {
        case square
        case circle
    }
}

extension CustomTransition: UIViewControllerAnimatedTransitioning {
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        
        let fromViewController = transitionContext.viewController(forKey: .from)
        let toViewController = transitionContext.viewController(forKey: .to)
        
        fromViewController?.beginAppearanceTransition(false, animated: true)
        toViewController?.beginAppearanceTransition(true, animated: true)
        
        if transitionMode == .present {
            guard let presentedControllerView = transitionContext.view(forKey: UITransitionContextViewKey.to) else {
                return
            }
            let originalCenter = presentedControllerView.center
            if transitionType == .circle {
                let originalSize = presentedControllerView.frame.size
                view = UIView()
                view.frame = frameForView(originalCenter, size: originalSize, start: startingPoint)
                view.layer.cornerRadius = view.frame.size.height / 2
                view.center = startingPoint
                view.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                view.backgroundColor = transitionColor
                containerView.addSubview(view)
            }
            
            presentedControllerView.center = startingPoint
            presentedControllerView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
            presentedControllerView.alpha = 0
            containerView.addSubview(presentedControllerView)
            
            UIView.animate(withDuration: duration, animations: { [unowned self] () in
                self.view.transform = CGAffineTransform.identity
                presentedControllerView.transform = CGAffineTransform.identity
                presentedControllerView.alpha = 1
                presentedControllerView.center = originalCenter
                }, completion: { (_) in
                    transitionContext.completeTransition(true)
                    
                    fromViewController?.endAppearanceTransition()
                    toViewController?.endAppearanceTransition()
            })
        } else {
            let key = (transitionMode == .pop) ? UITransitionContextViewKey.to : UITransitionContextViewKey.from
            guard let returningControllerView = transitionContext.view(forKey: key) else {
                return
            }
            let originalCenter = returningControllerView.center
            if transitionType == .circle {
                let originalSize = returningControllerView.frame.size
                view.frame = frameForView(originalCenter, size: originalSize, start: startingPoint)
                view.layer.cornerRadius = view.frame.size.height / 2
                view.center = dismissPoint
            }
            
            UIView.animate(withDuration: duration, animations: { [unowned self] () in
                self.view.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                returningControllerView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                returningControllerView.center = self.dismissPoint
                returningControllerView.alpha = 0
                
                if self.transitionMode == .pop {
                    containerView.insertSubview(returningControllerView, belowSubview: returningControllerView)
                    containerView.insertSubview(self.view, belowSubview: returningControllerView)
                }
                }, completion: { [unowned self] (_) in
                    returningControllerView.center = originalCenter
                    returningControllerView.removeFromSuperview()
                    self.view.removeFromSuperview()
                    transitionContext.completeTransition(true)
                    
                    fromViewController?.endAppearanceTransition()
                    toViewController?.endAppearanceTransition()
            })
        }
    }
}

private extension CustomTransition {
    func frameForView(_ originalCenter: CGPoint, size originalSize: CGSize, start: CGPoint) -> CGRect {
        let lengthX = fmax(start.x, originalSize.width - start.x)
        let lengthY = fmax(start.y, originalSize.height - start.y)
        let offset = sqrt(lengthX * lengthX + lengthY * lengthY) * 2
        let size = CGSize(width: offset, height: offset)
        
        return CGRect(origin: CGPoint.zero, size: size)
    }
}
