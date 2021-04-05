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
        let contentView = cell.contentView.subviews[0] as! UIStackView
        (contentView.subviews[0] as! UILabel).text = catergories[indexPath.row]
        let deleteBtn = contentView.subviews[1] as! UIButton
        deleteBtn.tag = indexPath.row
        deleteBtn.addTarget(self, action:#selector(onRemoveCategory(sender:)), for: .touchUpInside)
        return cell
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
