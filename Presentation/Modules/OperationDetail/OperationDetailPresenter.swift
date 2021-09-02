//
//  OperationDetailPre.swift
//  PepperAssignment
//
//  Created by Eilon Krauthammer on 02/09/2021.
//

import Foundation

final class OperationDetailPresenter: OperationDetailModuleInput {
    
    typealias Dependencies = Any
    
    let state: OperationDetailState
    
    weak var output: OperationDetailModuleOutput?
    weak var view: OperationDetailViewInput?
    
    private let dependencies: Dependencies
    
    init(state: OperationDetailState, dependencies: Dependencies) {
        self.state = state
        self.dependencies = dependencies
    }
    
    func update(force: Bool, animated: Bool) {
        let viewModel = OperationDetailViewModel(state: self.state)
        view?.update(viewModel: viewModel, force: force, animated: animated)
    }
}

extension OperationDetailPresenter: OperationDetailViewOutput {
    func viewDidLoad() {
        update(force: true, animated: false)
    }
    
    func shouldFinish() {
        output?.operationDetailModuleShouldFinish(self)
    }
}
