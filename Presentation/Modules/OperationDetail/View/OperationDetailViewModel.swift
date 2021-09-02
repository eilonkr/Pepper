//
//  OperationDetailViewModel.swift
//  PepperAssignment
//
//  Created by Eilon Krauthammer on 02/09/2021.
//

import Foundation

struct OperationDetailViewModel {
    let operation: Operation
    
    init(state: OperationDetailState) {
        self.operation = state.operation
    }
}
