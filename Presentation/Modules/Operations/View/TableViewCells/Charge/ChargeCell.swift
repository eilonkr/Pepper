//
//  ChargeCell.swift
//  PepperAssignment
//
//  Created by Eilon Krauthammer on 01/09/2021.
//

import UIKit

final class ChargeCell: UITableViewCell, OperationCellProtocol {
    
    @IBOutlet weak var paymentLabel: UILabel!
    @IBOutlet weak var operationNameLabel: UILabel!

    var getInfoHandler: ((Operation) -> Void)?
    var isTappable: Bool { false }
    
    var operation: Operation! {
        didSet {
            precondition(operation.operationType == .charge, "Invalid operation.")
            configure()
        }
    }
    
    private func configure() {
        paymentLabel.text = "$\(String(format: "%.0f", operation.amount))"
        operationNameLabel.text = operation.operationDesc
    }
    
    @IBAction func infoTapped(_ sender: Any) {
        getInfoHandler?(self.operation)
    }
}
