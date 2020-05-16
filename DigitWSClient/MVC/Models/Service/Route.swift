//
//  Route.swift
//  DigitWSClient
//
//  Created by Sarah Jmaiel on 22/02/2019.
//  Copyright © 2019 Sarah Jmaiel. All rights reserved.
//

import Foundation

enum Route {

    case getFilms
    
    var path: String {
        switch self {
        case .getFilms: return "/json/get/bUAxzJkxhK"
        }
    }
}

extension Route: CustomStringConvertible {
    var description: String { return path }
}
