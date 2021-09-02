//
//  OperationDetailModule.swift
//  PepperAssignment
//
//  Created by Eilon Krauthammer on 02/09/2021.
//

import Foundation

protocol OperationDetailModuleOutput: AnyObject {
    func operationDetailModuleShouldFinish(_ moduleInput: OperationDetailModuleInput)
}

protocol OperationDetailModuleInput: AnyObject {
    var state: OperationDetailState { get }
    func update(force: Bool, animated: Bool)
}

final class OperationDetailModule {
    
    public var input: OperationDetailModuleInput {
        return presenter
    }
    
    public var output: OperationDetailModuleOutput? {
        get {
            presenter.output
        } set {
            presenter.output = newValue
        }
    }
    
    public let viewController: OperationDetailViewController
    private let presenter: OperationDetailPresenter
    
    init(state: OperationDetailState) {
        let presenter = OperationDetailPresenter(state: state, dependencies: Services)
        let viewModel = OperationDetailViewModel(state: state)
        let viewController = OperationDetailViewController(viewModel: viewModel, output: presenter)
        presenter.view = viewController
        self.viewController = viewController
        self.presenter = presenter
    }
}
