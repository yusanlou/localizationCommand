//
//  DataService.swift
//  localizationCommand
//
//  Created by BackNotGod on 2017/3/14.
//
//

import Foundation

typealias writerAction = ([Values]?)->Void

class DataHandleManager {
    
    static let defaltManager = DataHandleManager()
    
    var swift_listNode : listNode?
    var oc_listNode : listNode?
    var error_listNode : listNode?
    fileprivate init(){
        swift_listNode = listNode.init()
        oc_listNode = listNode.init()
        error_listNode = listNode.init()
    }
    
    func mapSwfit(){
        guard let list = self.swift_listNode else {
            print("swift_listNode is empty.".blue)
            return
        }
        mapLinkNode(root: list.head)
    }
    
    func mapOC() {
        guard let list = self.oc_listNode else {
            print("oc_listNode is empty.".blue)
            return
        }
        mapLinkNode(root: list.head)
    }
    
    func mapError() {
        guard let list = self.error_listNode else {
            print("error_listNode is empty.".blue)
            return
        }
        mapLinkNode(root: list.head)
    }
    
    fileprivate func mapLinkNode(root:linkNode?)  {
        if root == nil {
            return
        }
        print(root!.className.blue + ": ")
        let _ = root!.values.map{print($0.localizedString.yellow)}
        mapLinkNode(root: root!.next)
    }
    
    func outPutLinkNode (root:linkNode?,action:writerAction) {
        if root == nil {
            return action(nil)
        }
        action(root?.values)
        outPutLinkNode(root: root!.next, action: action)
    }
    
}

class listNode {
    var head: linkNode?
    var tail: linkNode?
    init() {
        
    }
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
    var comment : String
    var outPutStr : String
    init(value:String,comment:String) {
        self.localizedString = value
        self.comment = comment
        outPutStr = "/* */"
    }
    
    func appendClassComent(className:String,comStr:String) {
        if !outPutStr.contains(className) {
            var insertStr = " \(className):\(comStr) | "
            outPutStr.insert(contentsOf: insertStr.characters, at: outPutStr.index(outPutStr.startIndex, offsetBy: 2))
            print(outPutStr)

        }
    }
    
}

func isSameValues(_ value1:Values,value2:Values) -> Bool{
    let judge1 = value1.localizedString == value2.localizedString
    let judge2 = value1.comment == value2.comment

    return (judge1 && judge2)
}
