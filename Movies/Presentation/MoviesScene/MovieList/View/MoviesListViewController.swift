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
    
    static func create(
        with viewModel: MoviesListViewModel) -> MoviesListViewController {
            let view = MoviesListViewController.instantiateViewController()
            view.viewModel = viewModel
            return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func bind(to viewModel: MoviesListViewModel) {
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {}
}
