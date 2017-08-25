//
//  BBFadeViewControllerAnimator.swift
//  BBFadeTabBarController
//
//  Created by Michael Berger on 8/24/17.
//  Copyright © 2017 BergerBytes. All rights reserved.
//

import Foundation
import UIKit

public class BBFadeViewControllerAnimator: NSObject {
  
  public enum FadeControllerDirection {
    case left
    case right
  }
  
  fileprivate let ANIMATING_DISTANCE: CGFloat
  
  fileprivate var direction = FadeControllerDirection.right
  fileprivate var duration: TimeInterval = 0.25
  
  public init(direction: FadeControllerDirection, duration: TimeInterval = 0.25, slideDistance distance: CGFloat = 100) {
    self.direction = direction
    self.duration = duration
    
    ANIMATING_DISTANCE = direction == .left ? 1 * distance : -1 * distance
    
  }
  
}

extension BBFadeViewControllerAnimator: UIViewControllerAnimatedTransitioning {
  
  public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return duration
  }
  
  public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    let container = transitionContext.containerView
    guard
      let destination = transitionContext.viewController(forKey: .to),
      let origin = transitionContext.viewController(forKey: .from)
      else {
        fatalError()
    }
    
    container.backgroundColor = .white
    
    var animatingDestinationView: UIView!
    var animationOriginView: UIView!
    
    var destinationNavView: UIView?
    var originNavView: UIView?
    
    var destYOffset: CGFloat = 0
    var originYOffset: CGFloat = 0
    
    if let nav = origin as? UINavigationController {
      originNavView = nav.view
      if let originViewController = nav.topViewController {
        animationOriginView = originViewController.view
        originYOffset = animationOriginView.frame.origin.y
      }
    } else {
      animationOriginView = origin.view
    }
    
    if let nav = destination as? UINavigationController {
      container.addSubview(nav.view)
      destinationNavView = nav.view
      destinationNavView?.alpha = 0
      if let destinationViewController = nav.topViewController {
        animatingDestinationView = destinationViewController.view
        destYOffset = animatingDestinationView.frame.origin.y
      }
    } else {
      animatingDestinationView = destination.view
      
      container.addSubview(animatingDestinationView)
    }
    
    if destinationNavView != nil {
      animatingDestinationView.alpha = 1
    } else {
      animatingDestinationView.alpha = 0
    }
    
    animatingDestinationView.frame.origin = CGPoint(x: ANIMATING_DISTANCE, y: destYOffset)
    
    UIView.animate(
      withDuration: transitionDuration(using: transitionContext),
      delay: 0,
      options: .curveEaseInOut,
      animations: { [unowned self] in
        
        destinationNavView?.alpha = 1
        
        animatingDestinationView.frame.origin = CGPoint(x: 0, y: destYOffset)
        animatingDestinationView.alpha = 1
        
        animationOriginView.frame.origin = CGPoint(x:  -self.ANIMATING_DISTANCE, y: originYOffset)
        if let _originNav = originNavView, destinationNavView == nil {
          _originNav.alpha = 0
        } else {
          animationOriginView.alpha = 0
        }
        
    }) { (completed) in
      animationOriginView.alpha = 1
      transitionContext.completeTransition(completed)
    }
    
    
  }
  
}
