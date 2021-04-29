//
//  AppCoordinator.swift
//  RIBTemplate
//
//  Created by Oleksandr Stepanov on 29.04.2021.
//

import Foundation
import UIKit
import RxSwift

protocol ApplicationServices {
}

protocol AppStateHolder {
    func register<T: RIBInteractor>(interactor: T)
}

enum ApplicationRouteType {
}

protocol ApplicationRouting {
    func enqueue(_ route: ApplicationRouteType)
}

protocol AppCoordinator: ApplicationServices, AppStateHolder, ApplicationRouting {
}
