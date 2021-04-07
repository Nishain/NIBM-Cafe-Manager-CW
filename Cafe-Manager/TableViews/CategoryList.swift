//
//  CategoryList.swift
//  Cafe-Manager
//
//  Created by Nishain on 4/4/21.
//  Copyright © 2021 Nishain. All rights reserved.
//

import UIKit
import FirebaseFirestore
class CategoryList: UITableView, UITableViewDelegate, UITableViewDataSource {
    var catergories:[(id:String,name:String)] = []
    let db = Firestore.firestore()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        catergories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "catergoryCell")!
        cell.frame = cell.frame.inset(by: UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 10))
        let text = cell.contentView.subviews[0] as! UILabel
        text.text = catergories[indexPath.row].name
        return cell
    }
    func loadCategories(){
        db.collection("category").getDocuments(completion: {data,err in
            self.catergories = (data?.documents ?? []).map({
                (id:$0.documentID,
                 name:$0.data()["name"] as! String)
            })
            self.reloadData()
        })
    }
    func setDragDelete(index:Int)->[UIContextualAction]{
        let closeAction = UIContextualAction(style: .normal, title:  "Delete", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            self.db.collection("category").document(self.catergories[index].id).delete()
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
    
    func addNewCategory(name:String,alert:AlertPopup){
        db.collection("category").whereField("name", isEqualTo: name).limit(to: 1).getDocuments(completion: {
            data,error in
            if (data?.documents ?? []).count > 0{
                alert.infoPop(title: "Name already exit!", body: "Category already exist,please choose a different name")
                return
            }
            var ref:DocumentReference?
            ref = self.db.collection("category").addDocument(data: ["name":name],completion: {err in
                if err == nil{
                    self.catergories.append((id:ref!.documentID,name:name))
                    self.reloadData()
                }
            })
        })
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        delegate = self
        dataSource = self
        loadCategories()
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
