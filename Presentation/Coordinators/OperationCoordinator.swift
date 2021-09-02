//
//  OperationCoordinator.swift
//  PepperAssignment
//
//  Created by Eilon Krauthammer on 02/09/2021.
//

import UIKit
import EKSwiftSuite

protocol OperationCoordinatorOutput: AnyObject {
    func operationCoordinatorDidFinish(_ coordinator: OperationCoordinator)
}

final class OperationCoordinator: BaseCoordinator<UINavigationController> {
    
    weak var output: OperationCoordinatorOutput?
    
    let operationDetailModule: OperationDetailModule
    
    init(rootViewController: UINavigationController, operation: Operation) {
        let state = OperationDetailState(operation: operation)
        self.operationDetailModule = OperationDetailModule(state: state)
        super.init(rootViewController: rootViewController)
        
        operationDetailModule.output = self
    }
    
    override func start() {
        rootViewController.pushViewController(operationDetailModule.viewController, animated: true)
    }
    
    deinit {
        print("-- deinit \(self) --")
    }
}

extension OperationCoordinator: OperationDetailModuleOutput {
    func operationDetailModuleShouldFinish(_ moduleInput: OperationDetailModuleInput) {
        delegate?.childCoordinatorDidFinish(self)
        output?.operationCoordinatorDidFinish(self)
    }
}
