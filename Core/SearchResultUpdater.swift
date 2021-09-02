//
//  SearchResultUpdater.swift
//  PepperAssignment
//
//  Created by Eilon Krauthammer on 02/09/2021.
//

import UIKit

protocol StringSearchable {
    var searchableTexts: [String] { get }
}

class SearchResultUpdater<SearchItem: StringSearchable>: NSObject, UISearchResultsUpdating {
    var allItems: [SearchItem]
    @Published var filteredItems: [SearchItem] = []
    
    var isCaseSensitive: Bool
    
    init(items: [SearchItem], isCaseSensitive: Bool = false) {
        self.allItems = items
        self.isCaseSensitive = isCaseSensitive
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard var searchText = searchController.searchBar.text, !searchText.isEmpty else {
            return filteredItems = allItems
        }
        
        if !isCaseSensitive {
            searchText = searchText.lowercased()
        }

        var filteredItems = [SearchItem]()
        for item in allItems {
            for text in item.searchableTexts.map( { isCaseSensitive ? $0 : $0.lowercased() }) {
                if text.contains(searchText) {
                    filteredItems += [item]
                    break
                }
            }
        }
        
        self.filteredItems = filteredItems
    }    
}
