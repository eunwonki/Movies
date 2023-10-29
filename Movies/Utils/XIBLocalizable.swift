//
//  XIBLocalizable.swift
//  Movies
//
//  Created by wonki on 10/27/23.
//

import Foundation
import UIKit

// https://medium.com/@mario.negro.martin/easy-xib-and-storyboard-localization-b2794c69c9db

protocol XIBLocalizable {
    var xibLocKey: String? { get set }
}

extension UILabel: XIBLocalizable {
    @IBInspectable var xibLocKey: String? {
        get { return nil }
        set(key) {
            text = key?.localized
        }
    }
}

extension UIButton: XIBLocalizable {
    @IBInspectable var xibLocKey: String? {
        get { return nil }
        set(key) {
            setTitle(key?.localized, for: .normal)
        }
   }
}
