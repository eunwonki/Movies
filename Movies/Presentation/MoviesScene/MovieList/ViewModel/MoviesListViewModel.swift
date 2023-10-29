//
//  MoviesListViewModel.swift
//  Movies
//
//  Created by wonki on 10/26/23.
//

import Foundation
import Combine
import UIKit

protocol MoviesListViewModelInput {
    func viewDidLoad()
    func didLoadNextPage()
    func didSearch(query: String)
    func didCancelSearch()
    func showQueriesSuggestions()
    func closeQueriesSuggestions()
    func didSelectItem(at index: Int)
}

protocol MoviesListViewModelOutput {
    var items: Just<[MoviesListItemViewModel]> { get }
    var loading: Just<MoviesListViewModelLoading?> { get }
    var query: Just<String> { get }
    var error: Just<String> { get }
    var isEmpty: Bool { get }
    var screenTitle: String { get }
    var emptyDataTitle: String { get }
    var errorTitle: String { get }
    var searchBarPlaceholder: String { get }
}

enum MoviesListViewModelLoading {
    case fullScreen
    case nextPage
}

typealias MoviesListViewModel = MoviesListViewModelInput & MoviesListViewModelOutput

final class DefaultMoviesListViewModel: MoviesListViewModel {
    // MARK: - OUTPUT.
    var items: Just<[MoviesListItemViewModel]> = Just([])
    var loading: Just<MoviesListViewModelLoading?> = Just(.none)
    var query: Just<String> = .init("")
    var error: Just<String> = .init("")
    var isEmpty: Bool = true
    var screenTitle: String = ""
    var emptyDataTitle: String = ""
    var errorTitle: String = ""
    var searchBarPlaceholder: String = ""
}

// MARK: - INPUT. View event methods

extension DefaultMoviesListViewModel {
    func viewDidLoad() {}
    
    func didLoadNextPage() {}
    
    func didSearch(query: String) {}
    
    func didCancelSearch() {}
    
    func showQueriesSuggestions() {}
    
    func closeQueriesSuggestions() {}
    
    func didSelectItem(at index: Int) {}
}
