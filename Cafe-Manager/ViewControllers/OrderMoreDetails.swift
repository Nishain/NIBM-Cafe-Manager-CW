//
//  OrderMoreDetails.swift
//  Cafe-Manager
//
//  Created by Nishain on 4/5/21.
//  Copyright © 2021 Nishain. All rights reserved.
//

import UIKit
import FirebaseFirestore
class OrderMoreDetails: UIViewController {

    @IBOutlet weak var buttonStatus: UIButton!
    @IBOutlet weak var statusDescription: UILabel!
    @IBOutlet weak var itemList: OrderItemList!
    var orderDetails : OrderStatus!
    let db = Firestore.firestore()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonStatus.setTitle(StaticInfoManager.statusMeaning[orderDetails.status], for: .normal)
        buttonStatus.addTarget(self, action: #selector(onStatusTapped(sender:)), for: .touchUpInside)
        loadOrderItems()
        // Do any additional setup after loading the view.
    }
    func loadOrderItems(){
     //   (document!.data()?["items"] ?? []) as! [[String:Any]]
        db.collection("ordersList").document(orderDetails.databaseID!).getDocument(completion: {document,err in
            let data  = document!.data()!["items"]  as! [[String:Any]]
            let orderItemList:[OrderItems] = data.map({
                OrderItems(quantity: $0["quantity"] as! Int,
                           foodName: $0["foodName"] as? String,
                           price:  $0["unitPrice"] as! Int)
            })
            self.itemList.data = orderItemList
            self.itemList.reloadData()
        })
    }
    @objc func onStatusTapped(sender:UIButton){
        let updatableStatus = [1,2,4]
        if updatableStatus.contains(orderDetails.status){
            orderDetails.status += 1
            db.collection("ordersList").document(orderDetails.databaseID!).updateData(["status":orderDetails.status])
            buttonStatus.setTitle(StaticInfoManager.statusMeaning[orderDetails.status], for: .normal)
        }
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
