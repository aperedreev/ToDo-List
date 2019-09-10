//
//  Item.swift
//  ToDo List
//
//  Created by Aleksey Peredreev on 10.09.2019.
//  Copyright © 2019 Aleksey Peredreev. All rights reserved.
//

import Foundation

class Item: NSObject, NSCoding {
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: "name") as! String
        self.init(name: name)
    }
    
    var name: String
    
    init(name: String) {
        self.name = name
        super.init()
    }
    
    static let Dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = Dir.appendingPathComponent("items")
}
