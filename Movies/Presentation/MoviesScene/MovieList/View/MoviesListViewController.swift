//
//  MoviesListViewController.swift
//  Movies
//
//  Created by wonki on 10/26/23.
//

import Foundation
import UIKit

// TODO: 검색 화면 구현.
// TODO: 검색할 때 영화리스트 가져오는 것 구현.
// TODO: 영화 리스트를 가져오면 화면에서 그리는 것 구현.

final class MoviesListViewController: UIViewController, StoryboardInstantiable {
    @IBOutlet private var contentView: UIView!
    @IBOutlet private var moviesListContainer: UIView!
    @IBOutlet private(set) var suggestionsListContainer: UIView!
    @IBOutlet private var searchBarContainer: UIView!
    @IBOutlet private var emptyDataLabel: UILabel!
    
    private var viewModel: MoviesListViewModel!
    
    private var moviesTableViewController: MoviesListTableViewController?
    private var searchController = UISearchController(searchResultsController: nil)
    
    static func create(
        with viewModel: MoviesListViewModel) -> MoviesListViewController {
            let view = MoviesListViewController.instantiateViewController()
            view.viewModel = viewModel
            return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func bind(to viewModel: MoviesListViewModel) {
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchController.isActive = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {}
    
    // MARK: - Private
    
    private func setupViews() {
        title = NSLocalizedString("Movies", comment: "")
        emptyDataLabel.text = "Empty Data for \"\""
        setupSearchController()
    }
    
    private func updateQueriesSuggestions() {
        guard searchController.searchBar.isFirstResponder else {
            viewModel.closeQueriesSuggestions()
            return
        }
        viewModel.showQueriesSuggestions()
    }
    
    private func updateSearchQuery(_ query: String) {
        searchController.isActive = false
        searchController.searchBar.text = query
    }
}

extension MoviesListViewController {
    private func setupSearchController() {
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = viewModel.searchBarPlaceholder
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.translatesAutoresizingMaskIntoConstraints = true
        searchController.searchBar.barStyle = .black
        
        // Warning: Simulator에서는 이 값을 바꾼 것이 적용되지 않음.
        // 같은 원인으로 추정되며 Simulator에서는 Navigation Bar에 가려져 입력이 되지 않음.
        searchController.hidesNavigationBarDuringPresentation = false
        
        searchController.searchBar.frame = searchBarContainer.bounds
        searchController.searchBar.autoresizingMask = [.flexibleWidth]
        searchBarContainer.addSubview(searchController.searchBar)
        definesPresentationContext = true
        searchController.searchBar.searchTextField.accessibilityIdentifier = AccessibilityIdentifier.searchField
    }
}

extension MoviesListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text, query.isNotEmpty else {
            return
        }
        
        searchController.isActive = false
        viewModel.didSearch(query: query)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.didCancelSearch()
    }
}

extension MoviesListViewController: UISearchControllerDelegate {
    func willPresentSearchController(_ searchController: UISearchController) {
        updateQueriesSuggestions()
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
        updateQueriesSuggestions()
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        updateQueriesSuggestions()
    }
}
