//
//  AbstractCoordinator.swift
//  summator
//
//  Created by Alexey Pichukov on 10.02.17.
//  Copyright © 2017 Alexey Pichukov. All rights reserved.
//

import Foundation
import UIKit

class AbstractCoordinator: Coordinatorable {
    
    internal var childCoordinators: [Coordinatorable] = []
    internal weak var navigationController: UINavigationController?
    internal weak var parentCoordinator: Coordinatorable?
    
    required init(navigationController: UINavigationController?, parentCoordinator: Coordinatorable?) {
        self.navigationController = navigationController
        guard parentCoordinator != nil else {
            return
        }
        self.parentCoordinator = parentCoordinator
    }
    
    func start() {
        assert(false, "Error: Have no implementation of start()")
    }
    
    func stop() {
        assert(false, "Error: Have no implementation of stop()")
    }
    
    func objectFromChildCoordinator<T>(object: T?) {
        assert(false, "Error: Have no implementation of objectFromChildCoordinator()")
    }
}
