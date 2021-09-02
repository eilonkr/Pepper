//
//  OperationsDataSource.swift
//  PepperAssignment
//
//  Created by Eilon Krauthammer on 31/08/2021.
//

import UIKit
import Combine

final class OperationsTableViewManager: NSObject, TableViewManagerProtocol {
    unowned var tableView: UITableView?
    
    var dataSource: [[Operation]] = [] {
        didSet {
            searchFilteredDataSource = dataSource
            concreteSearchResultUpdater?.allItems = dataSource.flatMap { $0 }
        }
    }
    
    private lazy var searchFilteredDataSource: [[Operation]] = dataSource {
        didSet {
            tableView?.reloadData()
        }
    }
    
    lazy var searchResultUpdater: UISearchResultsUpdating = {
        let updater = SearchResultUpdater(items: dataSource.flatMap { $0 })
        updater.$filteredItems.sink { [unowned self] filteredOperations in
            searchFilteredDataSource = [filteredOperations]
        }
        .store(in: &cancellables)
        
        return updater
    }()
    
    var didSelectItem: ((Operation) -> Void)?
    
    private var cancellables = Set<AnyCancellable>()
    private var concreteSearchResultUpdater: SearchResultUpdater<Operation>? {
        searchResultUpdater as? SearchResultUpdater<Operation>
    }
    
    // MARK: - Setup
    
    func setup() {
        // Register cells
        tableView?.register(ChargeCell.nib(), forCellReuseIdentifier: "\(ChargeCell.self)")
        tableView?.register(ReceivedPaymentCell.nib(), forCellReuseIdentifier: "\(ReceivedPaymentCell.self)")
        tableView?.register(CashWithdrawalCell.nib(), forCellReuseIdentifier: "\(CashWithdrawalCell.self)")
    }
}

// MARK: - Data Source

extension OperationsTableViewManager {
    func numberOfSections(in tableView: UITableView) -> Int {
        return searchFilteredDataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchFilteredDataSource[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let operation = searchFilteredDataSource[indexPath.section][indexPath.row]
        
        var cell: OperationCellProtocol
        switch operation.operationType {
            case .charge:
                cell = tableView.dequeueReusableCell(withIdentifier: "\(ChargeCell.self)", for: indexPath) as! ChargeCell
            case .refund, .salary, .savingWithdrawal:
                cell = tableView.dequeueReusableCell(withIdentifier: "\(ReceivedPaymentCell.self)", for: indexPath) as! ReceivedPaymentCell
            case .cashWithdrawal:
                cell = tableView.dequeueReusableCell(withIdentifier: "\(CashWithdrawalCell.self)", for: indexPath) as! CashWithdrawalCell
            default:
                fatalError("Could not find cell for operation type \(operation.operationType)")
        }
        
        cell.operation = operation
        cell.getInfoHandler = { [weak self] operation in
            self?.didSelectItem?(operation)
        }
        
        return cell
    }
}

// MARK: - Delegate

extension OperationsTableViewManager {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard
            let cellProtocol = tableView.cellForRow(at: indexPath) as? OperationCellProtocol,
            cellProtocol.isTappable
        else { return }
        
        didSelectItem?(cellProtocol.operation)
    }
}


