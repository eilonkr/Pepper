//
//  TableViewManager.swift
//  PepperAssignment
//
//  Created by Eilon Krauthammer on 01/09/2021.
//

import UIKit


protocol TableViewManagerProtocol: NSObject, UITableViewDelegate, UITableViewDataSource {
    var tableView: UITableView? { get set }
}

protocol HasSearchResultUpdater: NSObject {
    var searchResultUpdater: UISearchResultsUpdating { get }
}

typealias SearchableTableViewManagerProtocol = TableViewManagerProtocol & HasSearchResultUpdater
