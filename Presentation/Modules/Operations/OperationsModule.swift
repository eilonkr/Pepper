//
//  OperationsModule.swift
//  PepperAssignment
//
//  Created by Eilon Krauthammer on 30/08/2021.
//

import Foundation

protocol OperationsModuleOutput: AnyObject {
    func operationsModule(_ moduleInput: OperationsModuleInput, didSelectOperation operation: Operation)
}

protocol OperationsModuleInput: AnyObject {
    var state: OperationsState { get }
    func update(force: Bool, animated: Bool)
}

final class OperationsModule {
    
    public var input: OperationsModuleInput {
        return presenter
    }
    
    public var output: OperationsModuleOutput? {
        get {
            presenter.output
        } set {
            presenter.output = newValue
        }
    }
    
    public let viewController: OperationsViewController
    private let presenter: OperationsPresenter
    
    init(state: OperationsState) {
        let presenter = OperationsPresenter(state: state, dependencies: Services)
        let viewModel = OperationsViewModel(state: state)
        let viewController = OperationsViewController(viewModel: viewModel, tableViewManager: presenter.tableViewManager, output: presenter)
        presenter.view = viewController
        self.viewController = viewController
        self.presenter = presenter
    }
}
