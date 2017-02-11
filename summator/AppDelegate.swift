//
//  AppDelegate.swift
//  summator
//
//  Created by Alexey Pichukov on 10.02.17.
//  Copyright © 2017 Alexey Pichukov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: Coordinatorable?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        let navigationController = UINavigationController()
        window?.rootViewController = navigationController
        appCoordinator = AppCoordinator(navigationController: navigationController, parentCoordinator: nil)
        appCoordinator?.start()
        window?.makeKeyAndVisible()
        window?.tintColor = .white
        return true
    }

}

