//
//  DefaultAppCoordinator.swift
//  RIBTemplate
//
//  Created by Oleksandr Stepanov on 29.04.2021.
//

import Foundation
import UIKit
import RxSwift

class DefaultAppCoordinator: AppCoordinator {
    static let instance = DefaultAppCoordinator()

    private init() { }

    // MARK: AppStateHolder

    private var interactorsStack = [WeakReference<AnyObject>]()

    func register<T: RIBInteractor>(interactor: T) {
        interactorsStack.append(WeakReference(value: interactor))

        //  And setup unregister as well
        var disposable: Disposable?
        disposable = interactor.result.subscribe { (event) in
            if event.isCompleted {
                // TODO: compare the reference for the interactor passed in the parameter instead of pop the last one
                _ = self.interactorsStack.popLast()
                self.interactorsStack = self.interactorsStack.filter { $0.value != nil }
                disposable?.dispose()
            }
        }
    }

    // MARK: ApplicationRouting

    func enqueue(_ route: ApplicationRouteType) {
        switch route {
        }
    }
}
