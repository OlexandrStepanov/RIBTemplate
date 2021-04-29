//
//  HomeInteractor.swift
//  RIBTemplate
//
//  Created by Oleksandr Stepanov on 29.04.2021.
//

import Foundation
import RxSwift

protocol HomeInteractorProtocol: RIBInteractor {
    var viewPresented: PublishSubject<Void> { get }
    var viewDismissed: PublishSubject<Void> { get }
}

class HomeInteractor: HomeInteractorProtocol {

    private let disposeBag = DisposeBag()
    let result = PublishSubject<Void>()

    deinit {
        result.onCompleted()
    }

    let router: RIBRouter<HomeRouter.RouteType>

    let viewPresented = PublishSubject<Void>()
    let viewDismissed = PublishSubject<Void>()

	init(_ router: RIBRouter<HomeRouter.RouteType>) {
		self.router = router
	}
}
