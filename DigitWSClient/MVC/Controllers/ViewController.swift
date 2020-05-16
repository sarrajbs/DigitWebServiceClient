//
//  ViewController.swift
//  DigitWSClient
//
//  Created by Sarah Jmaiel on 22/02/2019.
//  Copyright © 2019 Sarah Jmaiel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    weak var appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //how to call ws invocation
        appDelegate?.webClient.fetchFilms(completion: { (result) in
            switch result{
            case .success(let films):
                for aFilm in films {
                    print("The film title is \(aFilm.title)")
                }
                
            case .failure(let error):
                print("The error is \(error.localizedDescription)")
            }
        })
        
    }
}

