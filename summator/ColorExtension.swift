//
//  ColorExtension.swift
//  summator
//
//  Created by Alexey Pichukov on 11.02.17.
//  Copyright © 2017 Alexey Pichukov. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    convenience init(hexString string: String) {
        self.init(hexString: string, andAlpha: 1.0)
    }
    
    convenience init(hexString string: String, andAlpha alpha: CGFloat) {
        var hex = string.hasPrefix("#")
            ? String(string.characters.dropFirst())
            : string
        guard hex.characters.count == 3 || hex.characters.count == 6
            else {
                self.init(white: 1.0, alpha: alpha)
                return
        }
        if hex.characters.count == 3 {
            for (index, char) in hex.characters.enumerated() {
                hex.insert(char, at: hex.index(hex.startIndex, offsetBy: index * 2))
            }
        }
        
        self.init(
            red:   CGFloat((Int(hex, radix: 16)! >> 16) & 0xFF) / 255.0,
            green: CGFloat((Int(hex, radix: 16)! >> 8) & 0xFF) / 255.0,
            blue:  CGFloat((Int(hex, radix: 16)!) & 0xFF) / 255.0, alpha: alpha)
    }
}
