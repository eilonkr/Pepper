//
//  DataProviding.swift
//  PepperAssignment
//
//  Created by Eilon Krauthammer on 30/08/2021.
//

import Foundation

protocol HasOperationsProvider {
    var operationsProvider: OperationsProviding { get }
}

protocol OperationsProviding {
    func fetch(callback: @escaping (Result<[Operation], Error>) -> Void)
}

