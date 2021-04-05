//
//  StaticInfoManager.swift
//  Cafe-Manager
//
//  Created by Nishain on 4/5/21.
//  Copyright © 2021 Nishain. All rights reserved.
//

import Foundation
class StaticInfoManager {
    static let statusMeaning:[Int:String] = [
        1:"New",
        2:"Preparing",
        3:"Ready",
        4:"Arriving",
        5:"Done",
        6:"Cancel"
    ]
    static let cellDateFormat = "yy/MM/dd HH:mm"
    static let dateOnly = "yy/MM/dd"
}
