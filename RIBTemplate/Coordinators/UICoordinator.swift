//
//  UICoordinator.swift
//  RIBTemplate
//
//  Created by Oleksandr Stepanov on 27.04.2021.
//

import Foundation
import UIKit

class UICoordinator: NSObject {
    enum NavigationTransition {
        case animated(UIViewControllerAnimatedTransitioning?)
        case notAnimated
    }

    static let shared = UICoordinator()
    var navigationTransition: NavigationTransition?

    func topController(for controller: UIViewController) -> UIViewController {
        var topController = controller
        while topController.presentedViewController != nil {
            // swiftlint:disable force_unwrapping
            topController = topController.presentedViewController!
            // swiftlint:enable force_unwrapping
        }
        return topController
    }

    func setup(with navigationController: UINavigationController) {
        navigationController.delegate = self
    }

    //  This method is for debug only!
    func presentAlert(title: String, message: String) {
        guard let keyWindow = UIApplication.shared.keyWindow,
            let topController = keyWindow.topMostController() else {
                Logger.error("Key window is not set or there is no root controller")
                return
        }

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: L10n.generalOkButton, style: .default, handler: nil))
        topController.present(alert, animated: true, completion: nil)
    }
}

extension UICoordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let navigationTransition = navigationTransition else {
            return nil
        }

        switch navigationTransition {
        case .animated(let transition):
            return transition
        case .notAnimated:
            return nil
        }
    }
}
