//
//  CashWithdrawalCell.swift
//  PepperAssignment
//
//  Created by Eilon Krauthammer on 02/09/2021.
//

import UIKit

final class CashWithdrawalCell: UITableViewCell, OperationCellProtocol {

    @IBOutlet weak var paymentLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!

    var getInfoHandler: ((Operation) -> Void)?
    var isTappable: Bool { true }
    
    var operation: Operation! {
        didSet {
            precondition(operation.operationType == .cashWithdrawal, "Invalid operation.")
            self.cashWithdrawalOperation = operation.castToCashWithdrawalOperation()
        }
    }
    
    private var cashWithdrawalOperation: CashWithdrawalOperation! {
        didSet {
            configure()
        }
    }
    
    private func configure() {
        paymentLabel.text = "$\(String(format: "%.0f", operation.amount))"
        sourceLabel.text = cashWithdrawalOperation.source
        addressLabel.text = cashWithdrawalOperation.address
    }
}
