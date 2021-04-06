//
//  OrderScreen.swift
//  Cafe-Manager
//
//  Created by Nishain on 4/4/21.
//  Copyright © 2021 Nishain. All rights reserved.
//

import UIKit

class OrderScreen: UITableViewController {
    var orders:[OrderStatus] = [
        OrderStatus(orderID: 432, customerName: "Nishain", status: 2),
        OrderStatus(orderID: 432, customerName: "Nishain", status: 2),
        OrderStatus(orderID: 432, customerName: "Nishain", status: 3),
        OrderStatus(orderID: 444, customerName: "Nishain", status: 1),
        OrderStatus(orderID: 432, customerName: "Nishain", status: 4),
        OrderStatus(orderID: 432, customerName: "Nishain", status: 3),
        OrderStatus(orderID: 432, customerName: "Nishain", status: 3),
        OrderStatus(orderID: 432, customerName: "Nishain", status: 4),
        OrderStatus(orderID: 777, customerName: "Nishain", status: 1)
    ]
    override func viewDidLoad(){
    //sortOrders()
      sectionHeadings = getSectionHeadings()
    }
    
    func sortOrders(){
        orders = orders.sorted(by: {$0.status > $1.status})
    }
    var sectionHeadings:[(status:Int,frequesncy:Int)] = []
    func getSectionHeadings()->[(Int,Int)]{
        var sections:[(status:Int,frequesncy:Int)] = []
        
        for status in orders.map({$0.status}){
            let index = sections.firstIndex(where: {$0.status == status})
            if index != nil {
                sections[index!].frequesncy += 1
            }
            else{
                sections.append((status,1))
            }
        }
        sections = sections.sorted(by: {$0.status < $1.status})
        return sections
    }
   
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let entry = sectionHeadings[section]
        return "\(StaticInfoManager.statusMeaning[entry.status]!) (\(entry.frequesncy))"
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sectionHeadings.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionHeadings[section].frequesncy
        //return sectionHeadings.map({key,value in value})[section]
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let filteredData = orders.filter({$0.status == sectionHeadings [indexPath.section].status})
        let orderInfo = filteredData[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderStatusCell", for: indexPath) as! OrderStatusCell
        cell.orderID.text = String(orderInfo.orderID)
        cell.customerName.text = orderInfo.customerName
        cell.statusContainer.setTitle(StaticInfoManager.statusMeaning [orderInfo.status], for: .normal)
        cell.onOrderSelected = {
            self.onOrderSelected(source: orderInfo)
        }
        if filteredData[indexPath.row].status == 1{
            cell.secondaryButton.setTitle("Accept", for: .normal)
            
            cell.statusContainer.setTitle("Reject", for: .normal)
            cell.buttonContainer.addSubview(cell.statusContainer)
            //cell.statusContainer.tag = (0..<indexPath.section).map({tableView.numberOfRows(inSection: $0)}).reduce(0, +) + indexPath.row
            var index = 0
            cell.statusContainer.tag = orders.firstIndex(where: {
                if $0.status == 1{
                    if index == indexPath.row{
                        return true
                    }
                    index += 1
                    return false
                }
                return false
            })!
            cell.statusContainer.backgroundColor = .red
            cell.statusContainer.addTarget(self, action: #selector(onOrderRejected(sender:)), for: .touchUpInside)
            cell.secondaryButton.isHidden = false
        }else{
            cell.statusContainer.removeTarget(self, action: #selector(onOrderRejected(sender:)), for: .touchUpInside)
            cell.statusContainer.backgroundColor = #colorLiteral(red: 1, green: 0.4706886616, blue: 0.1020977057, alpha: 1)
            cell.secondaryButton.isHidden = true
        }
        // Configure the cell...

        return cell
    }
    
    @objc func onOrderRejected(sender:UIButton){
        orders.remove(at: sender.tag)
        sectionHeadings = getSectionHeadings()
        tableView.reloadData()
    }
    func onOrderSelected(source:OrderStatus){
         let backButton = UIBarButtonItem()
               backButton.title = "\(source.customerName!) (\(source.orderID)"
               navigationItem.backBarButtonItem = backButton
        let screen = storyboard?.instantiateViewController(identifier: "OrderMoreDetails") as! OrderMoreDetails
        screen.orderDetails = source
        navigationController?.pushViewController(screen, animated: true)
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
