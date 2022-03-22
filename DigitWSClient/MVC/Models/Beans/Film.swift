//
//  Film.swift
//  DigitWSClient
//
//  Created by Sarah Jmaiel on 27/02/2019.
//  Copyright © 2019 Sarah Jmaiel. All rights reserved.
//

import Foundation

struct Film: Decodable {
    
    let images: [String]
    let title: String
    let intro: String
    
    private enum CodingKeys: String, CodingKey {
        case title
        case intro
        case images
    }
}
