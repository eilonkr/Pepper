//
//  ServicesFactory.swift
//  PepperAssignment
//
//  Created by Eilon Krauthammer on 30/08/2021.
//

import Foundation

typealias ServicesAlias = HasOperationsProvider

var Services: ServicesAlias {
    MainServicesFactory()
}

final class MainServicesFactory: ServicesAlias {
    lazy var operationsProvider: OperationsProviding = LocalJSONOperationsProvider(
        fileName: "operations_data.json",
        in: Bundle.main
    )
}
