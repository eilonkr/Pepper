//
//  OperationsViewController.swift
//  PepperAssignment
//
//  Created by Eilon Krauthammer on 30/08/2021.
//

import UIKit
import EKSwiftSuite

protocol OperationsViewInput: AnyObject {
    var tableView: UITableView { get }
    func update(viewModel: OperationsViewModel, force: Bool, animated: Bool)
}

protocol OperationsViewOutput: AnyObject {
    func viewDidLoad()
}

final class OperationsViewController: UIViewController {
    
    let tableView: UITableView = UITableView()

    var output: OperationsViewOutput
    private var viewModel: OperationsViewModel
    private var tableViewManager: TableViewManagerProtocol
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = tableViewManager.searchResultUpdater
        searchController.obscuresBackgroundDuringPresentation = false
        return searchController
    }()
    
    init(viewModel: OperationsViewModel, tableViewManager: TableViewManagerProtocol, output: OperationsViewOutput) {
        self.viewModel = viewModel
        self.tableViewManager = tableViewManager
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureTableView()
        output.viewDidLoad()
    }
    
    private func configureView() {
        title = "Financial Operations"
        view.backgroundColor = .systemBackground
        navigationItem.searchController = searchController
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.bindMarginsToSuperview()
        tableView.delegate = tableViewManager
        tableView.dataSource = tableViewManager
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension OperationsViewController: OperationsViewInput, ForceViewUpdate {
    func update(viewModel: OperationsViewModel, force: Bool, animated: Bool) {
        // Nothing to do in here 😕
        self.viewModel = viewModel
    }
}
