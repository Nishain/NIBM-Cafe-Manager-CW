//
//  OrderMoreDetails.swift
//  Cafe-Manager
//
//  Created by Nishain on 4/5/21.
//  Copyright © 2021 Nishain. All rights reserved.
//

import UIKit

class OrderMoreDetails: UIViewController {

    @IBOutlet weak var buttonStatus: UIButton!
    @IBOutlet weak var statusDescription: UILabel!
    @IBOutlet weak var itemList: OrderItemList!
    var orderDetails : OrderStatus!
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonStatus.setTitle(StaticInfoManager.statusMeaning[orderDetails.status], for: .normal)
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
