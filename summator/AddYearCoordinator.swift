//
//  AddYearCoordinator.swift
//  summator
//
//  Created by Alexey Pichukov on 11.02.17.
//  Copyright © 2017 Alexey Pichukov. All rights reserved.
//

import Foundation
import UIKit

class AddYearCoordinator: AbstractCoordinator {
    
    private weak var parentViewController: YearsViewController?
    
    convenience init(parentViewController: YearsViewController, parentCoordinator: Coordinatorable?) {
        self.init(navigationController: nil, parentCoordinator: parentCoordinator)
        self.parentViewController = parentViewController
    }
    
    override func start() {
        guard parentViewController != nil else {
            assert(false, "Error: AddYearCoordinator's parentViewController is nil")
            return
        }
        let addYearViewController = AddYearViewController(delegate: self)
        addYearViewController.transitioningDelegate = parentViewController!
        addYearViewController.modalPresentationStyle = .custom
        parentViewController?.present(addYearViewController, animated: true, completion: nil)
    }
    
    override func stop() {
        parentViewController?.dismiss(animated: true) { [weak self] () in
            guard let strongSelf = self else {
                return
            }
            strongSelf.parentCoordinator?.coordinatorComplete(coordinator: strongSelf)
        }
    }
}

extension AddYearCoordinator: Completeble {
    func complete<T>(object: T?) {
        parentCoordinator?.objectFromChildCoordinator(object: object)
    }
}
