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
    var catergories:[String:String] = [:]
    func loadCategories(){
        db.collection("category").getDocuments(completion: {snapshot,err in
            for doc in snapshot?.documents ?? []{
                self.catergories[doc.documentID] = (doc.data()["name"] as! String)
            }
            self.loadData()
        })
        
    }
    func loadData(){
        var foodList:[FoodDetail] = []
        db.collection("Foods").getDocuments(completion: {snapshot,err in
            if(err != nil){
               print(err)
            }
            //each docuemnt reflect detail about a single food item..
            
            for (index,document) in (snapshot?.documents ?? []).enumerated(){
                let food = document.data() //single food instance..
                //populating date into data model....
                var foodDetail = FoodDetail(image: nil,
                    title: food["title"] as! String,
                    foodDescription: food["description"] as? String,
                    promotion:(food["promotion"] as? Int) ?? 0,
                    cost: food["cost"] as! Int,
                    phoneNumber: food["phoneNumber"] as? String,
                    type: self.catergories[food["category"] as! String] ?? "unknown category"
                    
                )
                //if contains a promotion field then add the promotion
                if(food.keys.contains("promotion")){
                    foodDetail.promotion = food["promotion"] as! Int
                }
                
              
                
                /*images are loaded afterwards the food details are loaded allowing user to view partially loaded data.
                 this is callback for image loading and later refresh the relvant cell when image is available.The image is identified by food ID - docuemnt id*/
                self.imageStore.reference(withPath: "foods/\(document.documentID).jpg").getData(maxSize: 1 * 1024 * 1024, completion: {data,imageErr in
                    
                    if(imageErr != nil){
                        
                        switch StorageErrorCode(rawValue: imageErr!._code) {
                        case .objectNotFound:
                            //if the image is not available in the database then display a default image
                            self.foodList.provideImage(index: index, newImage: #imageLiteral(resourceName: "foodDefault"))
                        default:
                            print(imageErr)
                        }
                    }else{
                        //if no error then update the revant cell against the index to with newly fetched food picture
                        self.foodList.provideImage(index: index, newImage: UIImage(data: data!))
                    }
                })
                foodList.append(foodDetail)
            }
            /*
             the food catergory List only updates when 'all' catergory selected means param 'catergory' is nil
            */
            //finally refresh the food list
            self.foodList.updateData(foodList)
            })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //first time load fetch all foods without category filtering
        loadCategories()
  
    }
    @IBAction func onSignOut(_ sender: Any) {
        try? Auth.auth().signOut()
        let rootNavigator = navigationController?.tabBarController?.navigationController
        let loginScreen = storyboard!.instantiateViewController(withIdentifier: "authScreen")
        rootNavigator!.setViewControllers([loginScreen], animated: true)
       
    }
    


}


