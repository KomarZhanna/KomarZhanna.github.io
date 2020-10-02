//
//  ViewController.swift
//  Messenger
//
//  Created by Zhanna on 26.09.2020.
//

import UIKit
import FirebaseAuth

class ConversationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        validateAuth()
        
    }
    
    private func validateAuth() {
        if (FirebaseAuth.Auth.auth().currentUser == nil){
            let vc = LoginViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            nav.navigationBar.isHidden = true
            present(nav, animated: true, completion: nil)
        }
    }

}

