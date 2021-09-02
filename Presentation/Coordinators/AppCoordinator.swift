//
//  AppCoordinator.swift
//  PepperAssignment
//
//  Created by Eilon Krauthammer on 30/08/2021.
//

import UIKit
import EKSwiftSuite

final class AppCoordinator: BaseCoordinator<UINavigationController> {
    
    private let window: UIWindow
    
    private let operationsModule: OperationsModule
    
    init(windowScene: UIWindowScene) {
        self.window = UIWindow(windowScene: windowScene)
        
        operationsModule = OperationsModule(state: .init())
        
        let navigationController = UINavigationController(rootViewController: operationsModule.viewController)
        navigationController.navigationBar.prefersLargeTitles = true
        
        super.init(rootViewController: navigationController)
        window.rootViewController = rootViewController
        
        operationsModule.output = self
    }
    
    override func start() {
        window.makeKeyAndVisible()
    }
    
}

extension AppCoordinator: OperationsModuleOutput {
    func operationsModule(_ moduleInput: OperationsModuleInput, didSelectOperation operation: Operation) {
        let operationCoordinator = OperationCoordinator(rootViewController: rootViewController, operation: operation)
        operationCoordinator.output = self
        append(child: operationCoordinator)
        operationCoordinator.start()
    }
}

extension AppCoordinator: OperationCoordinatorOutput {
    func operationCoordinatorDidFinish(_ coordinator: OperationCoordinator) {
        print("goodbye")
    }
}
