//
//  MVVMViewModel.swift
//  RIBTemplate
//
//  Created by Oleksandr Stepanov on 27.04.2021.
//

import Foundation
import RxSwift

protocol RIBInteractor: class {

    associatedtype ResultType: SubjectType
    associatedtype RouteType

	///	Link to the router.
    var router: RIBRouter<RouteType> { get }

    /// Link to the completion result observer. This is mandatory thing for AppCoordinator register method.
    /// NOTE, it must complete, i.e. .onCompleted() must be called just before dismissing the screen
    var result: ResultType { get }
}
