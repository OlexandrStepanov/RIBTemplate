//
//  AppDelegate.swift
//  RIBTemplate
//
//  Created by Oleksandr Stepanov on 27.04.2021.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    static var coordinator: AppCoordinator {
        return DefaultAppCoordinator.instance
    }

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
                
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        HomeBuilder.build(presentation: .presentAsRootOn(window, with: nil))
        window.makeKeyAndVisible()

        return true
    }

}

