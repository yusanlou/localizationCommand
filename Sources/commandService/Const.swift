//
//  Const.swift
//  localizationCommand
//
//  Created by BackNotGod on 2017/3/14.
//
//

import Foundation

enum FileType :String{
    case swift = "*.swift"
    case oc = "*.m"
    case other
}

let VERSION = "0.0.1"
let SWIFT_REGEX = "NSLocalizedString\\(\"(.+?)\", comment: (.+?)\\)"
let OC_REGEX = "NSLocalizedString\\(@\"(.+?)\", (.+?)\\)"
let LOCAL_ERGEX = "\".*?\""
let COMMONT = "/* No comment provided by engineer. */"
let TEST_REGEX = "NSLocalizedString\\(\"([^\\x00-\\xff]+)\", comment: \"\"\\)"

public var writeAppend = false
public var writeReplace = true


