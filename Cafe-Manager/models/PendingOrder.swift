//
//  wqdqw.swift
//  Cafe-Manager
//
//  Created by Nishain on 4/5/21.
//  Copyright © 2021 Nishain. All rights reserved.
//

import Foundation
struct PendingOrder:Codable {
    var foodName:String
    var quantity:Int
    var originalPrice:Int

    func asDictionary()->[String:Any]{
        let data = try? JSONEncoder().encode(self)
        return try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String : Any]
    }
}
