//
//  YearsCoordinator.swift
//  summator
//
//  Created by Alexey Pichukov on 10.02.17.
//  Copyright © 2017 Alexey Pichukov. All rights reserved.
//

import Foundation
import UIKit

class YearsCoordinator: AbstractCoordinator {
    
    private var viewModel: YearsViewModel?
    fileprivate var yearsViewController: YearsViewController?
    
    override func start() {
        viewModel = YearsViewModel()
        yearsViewController = YearsViewController(viewModel: viewModel!, delegate: self)
        navigationController?.pushViewController(yearsViewController!, animated: true)
    }
    
    override func objectFromChildCoordinator<T>(object: T?) {
        guard let year = object as? Year else {
            assert(false, "Error: Wrong type in YearsCoordinator's objectFromChildCoordinator method")
            return
        }
        viewModel?.addYear(year)
        childCoordinators.last?.stop()
    }
}

extension YearsCoordinator: ActionAddeble {
    func addAction() {
        guard yearsViewController != nil else {
            assert(false, "Error: YearViewController object is nil")
            return
        }
        let addYearCoordinator = AddYearCoordinator(parentViewController: yearsViewController!, parentCoordinator: self)
        childCoordinators.append(addYearCoordinator)
        addYearCoordinator.start()
    }
}
