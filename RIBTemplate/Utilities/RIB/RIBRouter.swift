//
//  RIBRouter.swift
//  RIBTemplate
//
//  Created by Oleksandr Stepanov on 27.04.2021.
//

import UIKit

enum RIBRouterPresentation {
    typealias Completion = () -> Void

    case custom  //  This presentation is used just to set viewController
    case presentAsRootOn(UIWindow, with: CATransition?)
    case presentModallyOn(UIViewController, fullScreen: Bool, animated: Bool, Completion?)
    case presentEmbedded(in: WeakReference<UIViewController>, contentView: UIView, ((UIViewController) -> Void)?)
    case pushTo(UINavigationController, transition: UICoordinator.NavigationTransition, Completion?)

    func perform(with viewController: UIViewController) {
        switch self {
        case .custom:
            break

        case .presentAsRootOn(let window, let transition):
            window.set(rootViewController: viewController, withTransition: transition)

        case .presentModallyOn(let baseViewController, let fullScreen, let animated, let completion):
            if fullScreen {
                viewController.modalPresentationStyle = .fullScreen
            }
            baseViewController.present(viewController, animated: animated, completion: completion)

        case .pushTo(let navigation, let transition, let completion):
            var animated: Bool
            switch transition {
            case .animated:
                animated = true
            case .notAnimated:
                animated = false
            }

            UICoordinator.shared.setup(with: navigation)
            UICoordinator.shared.navigationTransition = transition

            if let completion = completion {
                navigation.pushViewController(viewController, animated: animated, completion: completion)
            } else {
                navigation.pushViewController(viewController, animated: animated)
            }
        case .presentEmbedded(let parent, let contentView, let completion):
            viewController.view.fill(in: contentView)
            parent.value?.addChild(viewController)
            viewController.didMove(toParent: parent.value)
            completion?(viewController)
        }
    }

    enum RawType {
        case onWindow, modally, inNavigationStack, embedded, custom
    }

    var rawValue: RawType {
        switch self {
        case .presentAsRootOn:
            return .onWindow
        case .presentModallyOn:
            return .modally
        case .pushTo:
            return .inNavigationStack
        case .presentEmbedded:
            return .embedded
        case .custom:
            return .custom
        }
    }
}

/// The protocol for the router in MVVM+Router architecture  
class RIBRouter<RouteType> {

    /// This method must be overriden in subclasses
    ///	It must be used to present next module as a result of some action
    func enqueue(_ route: RouteType, animated: Bool = true, _ completion: RIBRouterPresentation.Completion? = nil) { }

    //	MARK - Default implementations

    //	Note, this property must be weak
    weak private(set) var viewController: UIViewController?
    private var usedPresentation: RIBRouterPresentation.RawType?

    /// This method must be used to present component from builder
    func present(_ viewController: UIViewController, with presentation: RIBRouterPresentation) {
        self.viewController = viewController
        self.usedPresentation = presentation.rawValue
        presentation.perform(with: viewController)
    }

    ///	Dismisses component. Implementaion depends on presentation
    func dismiss(animated: Bool = true, _ completion: RIBRouterPresentation.Completion? = nil) {
        guard let presentation = usedPresentation else {
            Logger.error("Detected attempt to dismiss not presented component")
            completion?()
            return
        }

        switch presentation {
        case .onWindow:
            Logger.error("Dismiss of component presented on window is not possible")

        case .modally:
            viewController?.dismiss(animated: animated, completion: completion)

        case .inNavigationStack:
            if let completion = completion {
                viewController?.navigationController?.popViewController(animated: animated, completion: completion)
            } else {
                viewController?.navigationController?.popViewController(animated: animated)
            }

        case .embedded:
            viewController?.view.removeFromSuperview()
            viewController?.removeFromParent()

        case .custom:
            break
        }
    }

    func presentErrorDialog(with message: String, title: String = L10n.generalErrorTitle, buttonTitle: String = L10n.generalOkButton, dismissHandler: RIBRouterPresentation.Completion?) {
        let action = UIAlertAction(title: buttonTitle, style: .cancel, handler: { _ in
            dismissHandler?()
        })
        presentDialog(with: message, title: title, actions: [action])
    }

    func presentRetryDialog(with message: String, title: String = L10n.generalErrorTitle,
                            retryHandler: @escaping RIBRouterPresentation.Completion,
                            cancelHandler: RIBRouterPresentation.Completion?) {
        let retryAction = UIAlertAction(title: L10n.generalTryAgainButton, style: .default) { _ in
            retryHandler()
        }
        let cancelAction = UIAlertAction(title: L10n.generalCancelButton, style: .cancel) { _ in
            cancelHandler?()
        }
        presentDialog(with: message, title: title, actions: [retryAction, cancelAction], preferredAction: retryAction)
    }

    func presentDialog(with message: String, title: String, actions: [UIAlertAction], preferredAction: UIAlertAction? = nil) {
        guard let baseViewController = viewController else {
            Logger.error("Base view controller not set")
            return
        }

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach { alert.addAction($0) }
        if let preferredAction = preferredAction {
            alert.preferredAction = preferredAction
        }
        baseViewController.present(alert, animated: true, completion: nil)
    }

    var navigationController: UINavigationController? {
        if let result = viewController as? UINavigationController {
            return result
        }
        return viewController?.navigationController
    }

    final func openWebSite(with url: URL, completion: RIBRouterPresentation.Completion? = nil) {
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: { _ in
                completion?()
            })
        } else if !url.absoluteString.hasPrefix("http://") {
            let newPath = "http://\(url.absoluteString)"
            guard let newUrl = URL(string: newPath) else {
                return
            }
            openWebSite(with: newUrl, completion: completion)
        }
    }
}
