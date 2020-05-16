//
//  AppDelegate.swift
//  DigitWSClient
//
//  Created by Sarah Jmaiel on 22/02/2019.
//  Copyright © 2019 Sarah Jmaiel. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var webClient: DigitWebServiceClient!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
  
        // Instantiate webClient
        let baseURL: [String: Any] = [
            WebServicesKeys.schemeKey: Environment.schemeURL,
            WebServicesKeys.hostKey: Environment.hostURL,
            WebServicesKeys.versionKey: Environment.apiVersion,
            WebServicesKeys.portKey: Environment.portURL]
        webClient = DigitWebServiceClient(baseURL: baseURL)
        //optianal the value is 60 by default
        webClient.timeOutRequest = 30
        
        return true
    }

}

