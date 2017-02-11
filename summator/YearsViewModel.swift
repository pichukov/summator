//
//  YearsViewModel.swift
//  summator
//
//  Created by Alexey Pichukov on 11.02.17.
//  Copyright © 2017 Alexey Pichukov. All rights reserved.
//

import Foundation
import RxSwift

class YearsViewModel {
    
    var years = Variable<[Year]>([])
    
    func addYear(_ year: Year) {
        years.value.insert(year, at: 0)
    }
}
