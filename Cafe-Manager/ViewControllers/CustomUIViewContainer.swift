//
//  CustomUIViewContainer.swift
//  Cafe-Manager
//
//  Created by Nishain on 4/4/21.
//  Copyright © 2021 Nishain. All rights reserved.
//

import UIKit

class CustomUIViewContainer: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let storePage = storyboard!.instantiateViewController(identifier: "storePage") as UINavigationController
        addChild(storePage)
        storePage.navigationBar.isHidden = true
        view.addSubview(storePage.view)
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
