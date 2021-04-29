//
//  RIBBuilder.swift
//  RIBTemplate
//
//  Created by Oleksandr Stepanov on 27.04.2021.
//

import Foundation
import UIKit
import RxSwift

protocol RIBBuilder {
    associatedtype ContextType

    //  Note, builder must register AND unregister created interactor in the state of app coordinator
    static func build(presentation: RIBRouterPresentation, context: ContextType)
}
