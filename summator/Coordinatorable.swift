//
//  Coordinatorable.swift
//  summator
//
//  Created by Alexey Pichukov on 10.02.17.
//  Copyright © 2017 Alexey Pichukov. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinatorable: class {
    
    var childCoordinators: [Coordinatorable] {get set}
    weak var navigationController: UINavigationController? {get}
    weak var parentCoordinator: Coordinatorable? {get}
    
    init(navigationController: UINavigationController?, parentCoordinator: Coordinatorable?)
    
    func start()
    func stop()
    
    func objectFromChildCoordinator<T>(object: T?)
}

extension Coordinatorable {
    func coordinatorComplete(coordinator: Coordinatorable) {
        guard let index = childCoordinators.index(where: { $0 === coordinator }) else {
            assert(false, "No child coordinator in childCoordinators array")
            return
        }
        childCoordinators.remove(at: index)
    }
}
