//
//  CustomUIViewContainer.swift
//  Cafe-Manager
//
//  Created by Nishain on 4/4/21.
//  Copyright © 2021 Nishain. All rights reserved.
//

import UIKit

class CustomUIViewContainer: UIViewController {

    @IBOutlet weak var topTabBar: UIStackView!
    var storePage:UITabBarController!
    override func viewDidLoad() {
        super.viewDidLoad()
        for (index,tabItem) in topTabBar.subviews.enumerated(){
            tabItem.tag = index
            (tabItem as! UIButton).addTarget(self, action: #selector(onTabSelected(sender:)), for: .touchUpInside)
        }
        storePage = storyboard!.instantiateViewController(identifier: "storePage")
        addChild(storePage)
        storePage.tabBar.isHidden = true
        
        storePage.view.frame = view.subviews[1].bounds
        view.subviews[1].addSubview(storePage.view)
        
        // Do any additional setup after loading the view.
    }

    @objc func onTabSelected(sender:UIButton){
        storePage.selectedIndex = sender.tag
        
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
