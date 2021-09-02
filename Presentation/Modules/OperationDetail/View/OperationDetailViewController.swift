//
//  OperationDetailViewController.swift
//  PepperAssignment
//
//  Created by Eilon Krauthammer on 02/09/2021.
//

import UIKit
import EKSwiftSuite

protocol OperationDetailViewInput: AnyObject {
    func update(viewModel: OperationDetailViewModel, force: Bool, animated: Bool)
}

protocol OperationDetailViewOutput: AnyObject {
    func viewDidLoad()
    func shouldFinish()
}

final class OperationDetailViewController: UIViewController {
    
    private let idLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var output: OperationDetailViewOutput
    private var viewModel: OperationDetailViewModel

    
    init(viewModel: OperationDetailViewModel, output: OperationDetailViewOutput) {
        self.viewModel = viewModel
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        output.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if presentingViewController == nil && parent == nil {
            output.shouldFinish()
        }
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
        view.addSubview(idLabel)
        idLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        idLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40.0).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension OperationDetailViewController: OperationDetailViewInput, ForceViewUpdate {
    func update(viewModel: OperationDetailViewModel, force: Bool, animated: Bool) {
        update(new: viewModel, old: self.viewModel, keyPath: \.operation, force: force) { operation in
            idLabel.text = "Operation ID: \(operation.operationId)"
        }
        
        self.viewModel = viewModel
    }
}
