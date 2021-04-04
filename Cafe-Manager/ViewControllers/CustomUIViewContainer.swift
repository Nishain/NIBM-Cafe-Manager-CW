//
//  CustomUIViewContainer.swift
//  Cafe-Manager
//
//  Created by Nishain on 4/4/21.
//  Copyright © 2021 Nishain. All rights reserved.
//

import UIKit

class CustomUIViewContainer: UIViewController, UITabBarDelegate {

    @IBOutlet weak var topTabBar: UITabBar!
    var storePage:UITabBarController!
    override func viewDidLoad() {
        super.viewDidLoad()
        topTabBar.delegate = self
        for (index,tabItem) in topTabBar.items!.enumerated(){
            tabItem.tag = index
        }
        topTabBar.selectedItem = topTabBar.items![0]
        storePage = storyboard!.instantiateViewController(identifier: "storePage")
        addChild(storePage)
        storePage.tabBar.isHidden = true
        storePage.view.frame = view.subviews[1].frame
        view.subviews[1].addSubview(storePage.view)
        
        // Do any additional setup after loading the view.
    }

    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        storePage.selectedIndex = item.tag
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
