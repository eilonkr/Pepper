//
//  OperationsPresenter.swift
//  PepperAssignment
//
//  Created by Eilon Krauthammer on 30/08/2021.
//

import Foundation

final class OperationsPresenter: OperationsModuleInput {
    
    typealias Dependencies = HasOperationsProvider
    
    let state: OperationsState
    
    weak var output: OperationsModuleOutput?
    weak var view: OperationsViewInput?
    
    private let dependencies: Dependencies
    
    lazy var tableViewManager: OperationsTableViewManager = {
        let manager = OperationsTableViewManager()
        manager.didSelectItem = { [unowned self] operation in
            output?.operationsModule(self, didSelectOperation: operation)
        }
        return manager
    }()
    
    init(state: OperationsState, dependencies: Dependencies) {
        self.state = state
        self.dependencies = dependencies
    }
    
    func update(force: Bool, animated: Bool) {
        let viewModel = OperationsViewModel(state: self.state)
        view?.update(viewModel: viewModel, force: force, animated: animated)
    }
}

extension OperationsPresenter: OperationsViewOutput {
    func viewDidLoad() {
        update(force: true, animated: false)
        
        tableViewManager.tableView = view?.tableView
        tableViewManager.setup()
        
        dependencies.operationsProvider.fetch { [weak self] result in
            switch result {
                case .success(let operations):
                    self?.tableViewManager.dataSource = [operations]
                case .failure(let error):
                    print("Failed fetching operations: \(error)")
            }
        }
    }
}
