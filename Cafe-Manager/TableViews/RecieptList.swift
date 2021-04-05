//
//  RecieptList.swift
//  Cafe-Manager
//
//  Created by Nishain on 4/5/21.
//  Copyright © 2021 Nishain. All rights reserved.
//

import UIKit

class RecieptList: UITableView, UITableViewDelegate, UITableViewDataSource {

    var data:[Reciept] = []
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecieptCell") as! DailyRecieptCell
        let reciept = data[indexPath.row]
        cell.date.text = reciept.date
        cell.priceFrequencyList.text = ""
        cell.itemList.text = ""
        for r in reciept.products{
            cell.itemList.text! += "\(r.foodName)\n"
            cell.priceFrequencyList.text! += "Rs \(r.quantity * r.originalPrice)\n"
        }
        cell.totalPrice.text = String(reciept.totalCost)
        return cell
    }
    func updateData(_ data:[Reciept],_ isOnlySingleItem:Bool = false){
        //if only single items added no need to refresh entire tableView just append at end of the list
        if isOnlySingleItem {
            self.data.append(data[0])
            insertRows(at: [IndexPath(row: data.count - 1, section: 0)], with: .none)
            return
        }
        self.data = data
        reloadData()
    }

    required init?(coder: NSCoder) {
        super.init(coder:coder)
        delegate = self
        dataSource = self
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

}
