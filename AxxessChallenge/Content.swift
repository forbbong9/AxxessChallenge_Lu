//
//  Content.swift
//  AxxessChallenge
//
//  Created by 新妻英二 on 3/13/17.
//  Copyright © 2017 新妻英二. All rights reserved.
//
//  Model class.
//

import Foundation

enum contentType{
    case text
    case image
}

class Content{

    var id: String?
    var type: contentType?
    var date: Date?
    var data: String?
    
    init(id: String, type: contentType, date: Date, data: String){
        self.id = id
        self.type = type
        self.date = date
        self.data = data
    }
    
    init(){}
}
