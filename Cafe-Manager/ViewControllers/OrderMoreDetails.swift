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
            
            let orderItemList:[OrderItemInfo] = data.map({
                OrderItemInfo(foodName: $0["foodName"] as! String,
                    quantity: $0["quantity"] as! Int,
                    originalPrice:  $0["unitPrice"] as! Int)
            })
            self.itemList.data = orderItemList
            self.itemList.reloadData()
        })
    }
    @objc func onStatusTapped(sender:UIButton){
        let updatableStatus = [1,2,4]
        if updatableStatus.contains(orderDetails.status){
            orderDetails.status += 1
            if orderDetails.status == 5{
                publishOrderToHistory()
            }
            db.collection("ordersList").document(orderDetails.databaseID!).updateData(["status":orderDetails.status])
            buttonStatus.setTitle(StaticInfoManager.statusMeaning[orderDetails.status], for: .normal)
        }
    }
    func publishOrderToHistory(){
        let currentTimestamp = DateFormatter()
        currentTimestamp.dateFormat = StaticInfoManager.dateTimeFormat
        let items = self.itemList.data
        let reciept = Reciept(date: currentTimestamp.string(from: Date()), products: items)
        db.collection("orderHistory").addDocument(data: [
            "date":reciept.date,
            "items":reciept.products.map({
                ["name":$0.foodName,"quantity":$0.quantity,"unitPrice":$0.originalPrice]
            })
        ])
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
