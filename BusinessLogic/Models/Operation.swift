//
//  Operation.swift
//  PepperAssignment
//
//  Created by Eilon Krauthammer on 31/08/2021.
//

import Foundation

struct OperationsContainer: Decodable {
    let operations: [Operation]
}

struct Operation: Decodable, Equatable, StringSearchable {
    let operationId: Int
    let operationType: OperationType
    let amount: Double
    let operationDesc: String?
    let source: String?
    let address: String?
    
    var searchableTexts: [String] {
        return [
            "\(amount)",
            "\(operationDesc ?? "")",
            "\(source ?? "")",
            "\(address ?? "")"
        ]
    }
    
    func castToCashWithdrawalOperation() -> CashWithdrawalOperation? {
        guard operationType == .cashWithdrawal,
              let source = source,
              let address = address else { return nil }
        return CashWithdrawalOperation(operation: self, source: source, address: address)
    }
}

struct CashWithdrawalOperation {
    let operation: Operation
    let source: String
    let address: String
}
