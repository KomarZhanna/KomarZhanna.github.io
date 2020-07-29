//
//  ViewController.swift
//  MatchApp
//
//  Created by Zhanna on 7/27/20.
//  Copyright © 2020 Zhanna. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var model = CardModel()
    var cardsArray = [Card]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        cardsArray = model.getCards()
        
        
        
    }


}

