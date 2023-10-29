//
//  File.swift
//  Movies
//
//  Created by wonki on 10/27/23.
//

import Foundation
import UIKit

final class MoviesListItemCell: UITableViewCell {
    
    static let reuseIdentifier = String(describing: MoviesListItemCell.self)
    static let height: CGFloat = 130
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var overviewLabel: UILabel!
    @IBOutlet private var posterImageView: UIImageView!
    
    private var viewModel: MoviesListItemViewModel!
//    private var posterImagesRepository: PosterImagesRepository?
}
