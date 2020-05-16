//
//  WebServiceKeys.swift
//  DigitWSClient
//
//  Created by Sarah Jmaiel on 22/02/2019.
//  Copyright © 2019 Sarah Jmaiel. All rights reserved.
//

import Foundation

public struct WebServicesKeys {
    
    // disable initialisation
    fileprivate init () {}
    
    // WS Config
    public static let timeOutDuration: TimeInterval = 60
    
    //keys Components
    public static let schemeKey = "scheme"
    public static let hostKey = "host"
    public static let versionKey = "version"
    public static let portKey = "port"
    
}
