//
//  CGRectExtension.swift
//  summator
//
//  Created by Alexey Pichukov on 11.02.17.
//  Copyright © 2017 Alexey Pichukov. All rights reserved.
//

import Foundation
import UIKit

extension CGRect {
    func center() -> CGPoint {
        return CGPoint(x: self.origin.x + self.width / 2, y: self.origin.y + self.height / 2)
    }
}
