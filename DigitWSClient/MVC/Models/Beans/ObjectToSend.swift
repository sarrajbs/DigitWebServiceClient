//
//  ObjectToSend.swift
//  DigitWSClient
//
//  Created by Sarah Jmaiel on 05/03/2019.
//  Copyright © 2019 Sarah Jmaiel. All rights reserved.
//

import Foundation

struct ObjectToSend: Codable {
    
    let name: String
    let job: String
    
    private enum CodingKeys: String, CodingKey {
        case name
        case job
    }
    
    public init(name: String, job: String) {
        self.job = job
        self.name = name
    }
}
