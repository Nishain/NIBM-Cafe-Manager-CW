//
//  NewCategoryScreen.swift
//  Cafe-Manager
//
//  Created by Nishain on 4/7/21.
//  Copyright © 2021 Nishain. All rights reserved.
//

import UIKit

class NewCategoryScreen: UIViewController {
    
    @IBOutlet weak var categoryNameTxt: UITextField!
    @IBOutlet weak var categoryList: CategoryList!
    var didDataLoaded = false
    override func viewDidLoad() {
        categoryList.parentContext = self
        if didDataLoaded{
            categoryList.categories = (tabBarController as! StoreRootController).catergories
        }
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onCategoryAdded(_ sender: Any) {
        let alert = AlertPopup(self)
        if categoryNameTxt.text?.count == 0{
            return alert.infoPop(title: "Missing name", body: "Please enter a unique category name")
        }
        categoryList.addNewCategory(name: categoryNameTxt.text!,alert:alert)
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
