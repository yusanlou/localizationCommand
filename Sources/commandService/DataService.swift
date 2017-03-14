//
//  DataService.swift
//  localizationCommand
//
//  Created by 李军杰 on 2017/3/14.
//
//

import Foundation

class DataHandleManager {
    
    let defaltManager = DataHandleManager()
    
    var swift_listNode : listNode?
    var oc_listNode : listNode?
    
    
}

class listNode {
    var head: linkNode?
    var tail: linkNode?
    
    func insert(values:[Values],className:String,path:String) {
        if tail == nil {
            tail = linkNode(locals:values,className:className,path:path)
            head = tail
        } else {
            tail!.next = linkNode(locals:values,className:className,path:path)
            tail = tail!.next
        }
    }
    
}

class linkNode {
    let path : String
    let values : [Values]
    let className : String
    var next : linkNode?
    init(locals:[Values],className:String,path:String) {
        self.values = locals
        self.className = className
        self.path = path
    }
    
}

class Values {
    let localizedString : String
    let comment : String
    init(value:String,comment:String) {
        self.localizedString = value
        self.comment = comment
    }
}
