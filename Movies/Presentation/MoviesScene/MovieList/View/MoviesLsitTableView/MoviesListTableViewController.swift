//
//  MoviesListTableViewController.swift
//  Movies
//
//  Created by wonki on 10/26/23.
//

import Foundation
import UIKit

final class MoviesListTableViewController: UITableViewController {
    
    var viewModel: MoviesListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension MoviesListTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: MoviesListItemCell.reuseIdentifier,
            for: indexPath) as? MoviesListItemCell else {
            // 개발 과정에서 실수할 수 있는 부분은 assertionFailure로 처리했네?
            assertionFailure("Cannot deque reusable cell \(MoviesListItemCell.self) with reuseIdentifier: \(MoviesListItemCell.reuseIdentifier)")
            return UITableViewCell()
        }
        
        // TODO: cell.fill
        
        // TODO: paging
//        if indexPath.row == viewModel.items.count().output - 1 {
//            viewModel.didLoadNextPage()
//        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MoviesListItemCell.height
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
}
