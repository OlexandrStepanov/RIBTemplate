//
//  HomeBuilder.swift
//  RIBTemplate
//
//  Created by Oleksandr Stepanov on 29.04.2021.
//

import Foundation
import RxSwift

class HomeBuilder: RIBBuilder {

	static func build(presentation: RIBRouterPresentation, context: Void = ()) {
		let router = HomeRouter()
		let interactor = HomeInteractor(router)
		let viewController = StoryboardScene.Main.homeViewController.instantiate()
		viewController.interactor = interactor
        
        //  It is mandatory to register interactor
        AppDelegate.coordinator.register(interactor: interactor)

		router.present(viewController, with: presentation)
	}
}
