//___FILEHEADER___

import Foundation
import RxSwift

class ___VARIABLE_productName___Builder: RIBBuilder {
    
    static func build(presentation: RIBRouterPresentation, context: Any) {
        let router = ___VARIABLE_productName___Router()
        let interactor = ___VARIABLE_productName___Interactor(router)
        let viewController = StoryboardScene.Main.___VARIABLE_productName___ViewController.instantiate()
        viewController.interactor = interactor
        
        //  It is mandatory to register interactor
        AppCoordinator.shared.register(interactor: interactor)
        
        router.present(viewController, with: presentation)
    }
}
