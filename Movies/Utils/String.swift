//
//  String.swift
//  Movies
//
//  Created by wonki on 10/27/23.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(
            self, tableName: "Localizable", value: self, comment: "")
    }
}
