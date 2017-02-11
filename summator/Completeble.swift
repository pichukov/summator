//
//  Completeble.swift
//  summator
//
//  Created by Alexey Pichukov on 11.02.17.
//  Copyright © 2017 Alexey Pichukov. All rights reserved.
//

import Foundation

protocol Completeble: class {
    func complete<T>(object: T?)
}
