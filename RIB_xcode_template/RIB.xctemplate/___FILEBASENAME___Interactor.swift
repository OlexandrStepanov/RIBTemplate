//___FILEHEADER___

import Foundation
import RxSwift

protocol ___VARIABLE_productName___InteractorProtocol: RIBInteractor {
    var viewPresented: PublishSubject<Void> { get }
    var viewDismissed: PublishSubject<Void> { get }
}

class ___VARIABLE_productName___Interactor: ___VARIABLE_productName___InteractorProtocol {
    
    private let disposeBag = DisposeBag()
    /// Link to the completion result observer. This is mandatory thing for AppCoordinator register method.
    /// NOTE, it must complete, i.e. .onCompleted() must be called just before dismissing the screen
    let result = PublishSubject<Void>()
    
    deinit {
        result.onCompleted()
    }
    
    let router: RIBRouter<___VARIABLE_productName___Router.RouteType>
    
    let viewPresented = PublishSubject<Void>()
    let viewDismissed = PublishSubject<Void>()
    
    init(_ router: RIBRouter<___VARIABLE_productName___Router.RouteType>) {
        self.router = router
    }
}
