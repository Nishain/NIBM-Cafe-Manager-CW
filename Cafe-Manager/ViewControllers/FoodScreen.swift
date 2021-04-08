//
//  FoodScreen.swift
//  FoodCafe
//
//  Created by Nishain on 2/23/21.
//  Copyright © 2021 Nishain. All rights reserved.
//

import UIKit
import Firebase
class FoodScreen: UIViewController {
    @IBOutlet weak var foodList: FoodList!

    let db = Firestore.firestore()
    let imageStore = Storage.storage()
   
    var isDataLoaded = false
    override func viewDidLoad() {
        super.viewDidLoad()
        if isDataLoaded{
            let rootController = tabBarController as! StoreRootController
            foodList.categories = rootController.catergories
            foodList.data = rootController.foodData
        }
  
    }
  
    


}


