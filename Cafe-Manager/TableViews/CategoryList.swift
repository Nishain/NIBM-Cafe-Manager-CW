//
//  CategoryList.swift
//  Cafe-Manager
//
//  Created by Nishain on 4/4/21.
//  Copyright © 2021 Nishain. All rights reserved.
//

import UIKit

class CategoryList: UITableView, UITableViewDelegate, UITableViewDataSource {
    var catergories:[String] = ["abc","fnksdfsf","nfjksdfndf","fnjskdnfs","uywierwer"]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        catergories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "catergoryCell")!
        cell.frame = cell.frame.inset(by: UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 10))
        let text = cell.contentView.subviews[0] as! UILabel
        text.text = catergories[indexPath.row]
        return cell
    }
    func setDragDelete(index:Int)->[UIContextualAction]{
        let closeAction = UIContextualAction(style: .normal, title:  "Delete", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            self.catergories.remove(at: index)
            self.reloadData()
            success(true)
        })
        closeAction.backgroundColor = .red
        return [closeAction]
    }
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: setDragDelete(index: indexPath.row))
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: setDragDelete(index: indexPath.row))
    }
    @objc func onRemoveCategory(sender:UIButton){
        catergories.remove(at: sender.tag)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        delegate = self
        dataSource = self
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
