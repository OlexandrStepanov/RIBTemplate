//
//  UIWindow+Sirius.swift
//  Sirius
//
//  Created by Oleksandr Stepanov on 8/9/19.
//  Copyright © 2019 Kromtech. All rights reserved.
//

import Foundation
import UIKit

extension UIWindow {

	/// When changing root of window, some views may leak due to a bug in UIKit
	///	This method fixes that. See http://stackoverflow.com/a/27153956/849645 for details
	func set(rootViewController newRootViewController: UIViewController, withTransition transition: CATransition? = nil) {

		let previousViewController = rootViewController

		if let transition = transition {
			// Add the transition
			layer.add(transition, forKey: kCATransition)
		}

		rootViewController = newRootViewController

		// Update status bar appearance using the new view controllers appearance - animate if needed
		if UIView.areAnimationsEnabled {
			UIView.animate(withDuration: CATransaction.animationDuration()) {
				newRootViewController.setNeedsStatusBarAppearanceUpdate()
			}
		} else {
			newRootViewController.setNeedsStatusBarAppearanceUpdate()
		}

		/// The presenting view controllers view doesn't get removed from the window as its currently transistioning and presenting a view controller
		if let transitionViewClass = NSClassFromString("UITransitionView") {
			for subview in subviews where subview.isKind(of: transitionViewClass) {
				subview.removeFromSuperview()
			}
		}
		if let previousViewController = previousViewController {
			// Allow the view controller to be deallocated
			previousViewController.dismiss(animated: false) {
				// Remove the root view in case its still showing
				previousViewController.view.removeFromSuperview()
			}
		}
	}

    func topMostController() -> UIViewController? {
        guard let rootViewController = self.rootViewController else {
            return nil
        }
        var topController = rootViewController
        while let newTopController = topController.presentedViewController {
            topController = newTopController
        }
        return topController
    }
}
