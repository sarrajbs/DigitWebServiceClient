//
//  Film.swift
//  DigitWSClient
//
//  Created by Sarah Jmaiel on 27/02/2019.
//  Copyright © 2019 Sarah Jmaiel. All rights reserved.
//

import Foundation

struct Film: Decodable {
    
    let title: String
    let text: String
    let longitude: Double
    let latitude: Double
    let intro: String
    let year: Int
    let images: [String]
    
    private enum CodingKeys: String, CodingKey {
        case title
        case text
        case longitude
        case latitude
        case intro
        case year
        case images
    }
}
