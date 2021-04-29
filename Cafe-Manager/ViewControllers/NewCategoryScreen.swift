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
        super.viewDidLoad()
        categoryList.parentContext = self
        if didDataLoaded{
            categoryList.categories = (tabBarController as! StoreRootController).catergories
        }
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onCategoryAdded(_ sender: Any) {
        let alert = AlertPopup(self)
        if categoryNameTxt.text?.count == 0{
            return alert.infoPop(title: "Missing name", body: "Please enter a unique category name")
        }
        if categoryNameTxt.text == StaticInfoManager.unknownCategory{
            return alert.infoPop(title: "Invalid name", body: "You cannot add a category with name '\(StaticInfoManager.unknownCategory)' as it is predefined")
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
