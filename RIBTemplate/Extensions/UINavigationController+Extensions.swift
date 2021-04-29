//
//  UINavigationController+Sirius.swift
//  Sirius
//
//  Created by Oleksandr Stepanov on 8/8/19.
//  Copyright © 2019 Kromtech. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {
	public func pushViewController(_ viewController: UIViewController, animated: Bool, completion: @escaping () -> Void) {
		pushViewController(viewController, animated: animated)
		guard animated, let coordinator = transitionCoordinator else {
			DispatchQueue.main.async { completion() }
			return
		}
		coordinator.animate(alongsideTransition: nil) { _ in completion() }
	}

	func popViewController(animated: Bool, completion: @escaping () -> Void) {
		popViewController(animated: animated)
		guard animated, let coordinator = transitionCoordinator else {
			DispatchQueue.main.async { completion() }
			return
		}
		coordinator.animate(alongsideTransition: nil) { _ in completion() }
	}

    func popToViewController(_ viewController: UIViewController, animated: Bool, completion: @escaping () -> Void) {
        popToViewController(viewController, animated: animated)
        guard animated, let coordinator = transitionCoordinator else {
            DispatchQueue.main.async { completion() }
            return
        }
        coordinator.animate(alongsideTransition: nil) { _ in completion() }
    }
}
