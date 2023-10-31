//
//  MoviesListViewModel.swift
//  Movies
//
//  Created by wonki on 10/26/23.
//

import Foundation
import Combine
import UIKit

enum MoviesListViewModelLoading {
    case fullScreen
    case nextPage
}

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
    @MainActor var items: Just<[MoviesListItemViewModel]> { get }
    @MainActor var loading: MoviesListViewModelLoading? { get }
    @MainActor var query: String { get }
    @MainActor var error: Just<String> { get }
    @MainActor var isEmpty: Bool { get }
    @MainActor var screenTitle: String { get }
    @MainActor var emptyDataTitle: String { get }
    @MainActor var errorTitle: String { get }
    @MainActor var searchBarPlaceholder: String { get }
}

typealias MoviesListViewModel = MoviesListViewModelInput & MoviesListViewModelOutput

final class DefaultMoviesListViewModel: MoviesListViewModel {
    private let searchMoviesUseCase: SearchMoviesUseCase
    
    var currentPage: Int = 0
    var totalPageCount: Int = 1
    var hasMorePages: Bool { currentPage < totalPageCount }
    var nextPage: Int { hasMorePages ? currentPage + 1 : currentPage}
    
    // MARK: - OUTPUT.
    var items: Just<[MoviesListItemViewModel]> = Just([])
    var loading: MoviesListViewModelLoading? = .none
    var query: String = ""
    var error: Just<String> = .init("")
    var isEmpty: Bool = true
    var screenTitle: String = ""
    var emptyDataTitle: String = ""
    var errorTitle: String = ""
    var searchBarPlaceholder: String = ""
    
    init(
        searchMoviesUseCase: SearchMoviesUseCase
    ) {
        self.searchMoviesUseCase = searchMoviesUseCase
    }
    
    // MARK: - Private
    
    private func appendPage(_ moviesPage: MoviesPage) {
        print("aaa \(moviesPage)")
    }
    
    private func resetPages() {
        
    }
    
    @MainActor
    private func load(
        movieQuery: MovieQuery,
        loading: MoviesListViewModelLoading
    ) async {
        self.loading = loading
        self.query = movieQuery.query
        
        defer { self.loading = .none }
        do {
            let result = try await searchMoviesUseCase.execute(
                request: .init(query: movieQuery, page: nextPage))
            print("get result count: \(result.page.movies.count)")
            self.appendPage(result.1)
        } catch {
            self.handle(error: error)
        }
    }
    
    private func handle(error: Error) {
        print("error occurred \(error)")
    }
    
    private func update(movieQuery: MovieQuery) {
        resetPages()
        Task {
            await load(movieQuery: movieQuery, loading: .fullScreen)
        }
    }
}

// MARK: - INPUT. View event methods

extension DefaultMoviesListViewModel {
    func viewDidLoad() {}
    
    func didLoadNextPage() {}
    
    func didSearch(query: String) {
        guard query.isNotEmpty else { return }
        update(movieQuery: MovieQuery(query: query))
    }
    
    func didCancelSearch() {}
    
    func showQueriesSuggestions() {}
    
    func closeQueriesSuggestions() {}
    
    func didSelectItem(at index: Int) {}
}
