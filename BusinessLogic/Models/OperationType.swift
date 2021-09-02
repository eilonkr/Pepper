//
//  OperationType.swift
//  PepperAssignment
//
//  Created by Eilon Krauthammer on 31/08/2021.
//

import Foundation

enum OperationType: Decodable {
    case charge
    case refund
    case salary
    case savingWithdrawal
    case cashWithdrawal
    case unknown
    
    var isReceivedPaymentType: Bool {
        switch self {
            case .salary, .refund, .savingWithdrawal:
                return true
            default:
                return false
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let typeRepresentation = try container.decode(String.self)
        switch typeRepresentation {
            case "CHARGE":
                self = .charge
            case "REFUND":
                self = .refund
            case "SALARY":
                self = .salary
            case "SAVING_WITHDRAWAL":
                self = .savingWithdrawal
            case "CASH_WITHDRAWAL":
                self = .cashWithdrawal
            default:
                self = .unknown
        }
    }
}
