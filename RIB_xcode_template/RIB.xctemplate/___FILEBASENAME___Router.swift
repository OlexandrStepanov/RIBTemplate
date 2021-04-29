//___FILEHEADER___

import Foundation
import UIKit

class ___VARIABLE_productName___Router: RIBRouter<___VARIABLE_productName___Router.RouteType> {
    
    enum RouteType {
        
    }
    
    override func enqueue(_ route: RouteType, animated: Bool = true, _ completion: RIBRouterPresentation.Completion? = nil) {
        guard let baseViewController = viewController else {
            Logger.error("Base view controller not set")
            completion?()
            return
        }
    }
}
