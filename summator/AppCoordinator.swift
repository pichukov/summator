//
//  AppCoordinator.swift
//  summator
//
//  Created by Alexey Pichukov on 10.02.17.
//  Copyright © 2017 Alexey Pichukov. All rights reserved.
//

import Foundation
import UIKit

class AppCoordinator: AbstractCoordinator {
    
    override func start() {
        let yearsCoordinator = YearsCoordinator(navigationController: navigationController, parentCoordinator: self)
        yearsCoordinator.start()
        childCoordinators.append(yearsCoordinator)
    }
}
