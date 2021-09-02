//
//  CommonExtensions.swift
//  PepperAssignment
//
//  Created by Eilon Krauthammer on 01/09/2021.
//

import UIKit

public extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension UITableViewCell {
    static func nib() -> UINib? {
        return UINib(nibName: "\(Self.self)", bundle: nil)
    }
}

