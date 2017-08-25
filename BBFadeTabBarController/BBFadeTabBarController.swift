//
//  BBFadeTabBarController.swift
//  BBFadeTabBarController
//
//  Created by Michael Berger on 8/24/17.
//  Copyright © 2017 BergerBytes. All rights reserved.
//

import Foundation

public class BBFadeTabBarController: UITabBarController {

  fileprivate(set) var animator: BBFadeViewControllerAnimator?
  
  @IBInspectable var slideDistance: CGFloat = 100
  @IBInspectable var duration: CGFloat = 0.25
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    internalInit()
  }
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    internalInit()
  }
  
  private func internalInit() {
    delegate = self
  }

  override public func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
    let from = selectedIndex
    let to = tabBar.items?.index(of: item) ?? -1
    if to != from {
      animator = BBFadeViewControllerAnimator(
        direction: to > from ? .left : .right,
        duration: TimeInterval(duration),
        slideDistance: slideDistance)
    }
  }
}

extension BBFadeTabBarController: UITabBarControllerDelegate {

  public func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return animator
  }

}
