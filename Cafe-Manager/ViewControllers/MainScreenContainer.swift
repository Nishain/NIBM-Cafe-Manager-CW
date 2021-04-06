//
//  MainScreenContainer.swift
//  Cafe-Manager
//
//  Created by Nishain on 4/6/21.
//  Copyright © 2021 Nishain. All rights reserved.
//

import UIKit
import FirebaseAuth
class MainScreenContainer: UITabBarController {
    @IBAction func onSignOut(_ sender: Any) {
        try? Auth.auth().signOut()
        let authenticateScreen = storyboard!.instantiateViewController(identifier: "authScreen") as AuthScreen
        navigationController!.navigationBar.isHidden = true
        navigationController!.setViewControllers([authenticateScreen], animated: true)
    }
    override func viewDidLoad() {
        navigationController!.navigationBar.isHidden = false
    }
}
