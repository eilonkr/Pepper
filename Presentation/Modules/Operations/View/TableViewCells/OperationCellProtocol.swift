//
//  OperationCellProtocol.swift
//  PepperAssignment
//
//  Created by Eilon Krauthammer on 01/09/2021.
//

import UIKit

protocol OperationCellProtocol: UITableViewCell {
    var operation: Operation! { get set }
    var getInfoHandler: ((Operation) -> Void)? { get set }
    var isTappable: Bool { get }
}
