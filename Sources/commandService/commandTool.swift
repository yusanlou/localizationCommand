//
//  commandProtocol.swift
//  localizationCommand
//
//  Created by BackNotGod on 2017/3/14.
//
//

import Foundation
import PathKit
import Progress

protocol StringsSearcher {
    func search(in content: String)
}

protocol RegexStringsSearcher: StringsSearcher {
    var patterns: [String] { get }
}

extension RegexStringsSearcher {
    
    func search(in path: Path)  {
        
        for pattern in patterns {
            
            guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
                print("Failed to create regular expression: \(pattern)".red)
                continue
            }
            
            let content = parsePathToContent(with: path)
            let matches = regex.matches(in: content, options: [], range: content.fullRange)
            var extracts : [Values] = []
            var errors : [Values] = []
            for checkingResult in matches {
                
                let range = checkingResult.rangeAt(0)
                let extracted = NSString(string: content).substring(with: range)
                
                guard let strRegex = try? NSRegularExpression(pattern: LOCAL_ERGEX, options: []) else {
                    print("Failed to create regular expression: \(pattern)".red)
                    continue
                }
                
                let strMatches = strRegex.matches(in: extracted, options: [], range: extracted.fullRange)
                let localizedString = NSString(string: extracted).substring(with: strMatches[0].rangeAt(0))
                
                if localizedString.characters.count == 0 {
                    continue
                }
                
                var commont = ""
                
                if strMatches.count > 1 {
                    commont = NSString(string: extracted).substring(with: strMatches[1].rangeAt(0))
                }
                
                let value = Values.init(value: localizedString, comment: "/* \(path.lastComponentWithoutExtension) : \(commont) */")
                
                /// over here, if localizedString is isAmbiguous,we analysis error
                if localizedString.isAmbiguous {
                    errors.append(value)
                }else{
                    extracts.append(value)
                }
            }
            if extracts.count > 0 {
                if path.lastComponent.contains("swift") {
                    DataHandleManager.defaltManager.swift_listNode?.insert(values: extracts, className: path.lastComponent, path: path.description)
                }else{
                    DataHandleManager.defaltManager.oc_listNode?.insert(values: extracts, className: path.lastComponent, path: path.description)
                }
            }
            
            if errors.count > 0 {
                DataHandleManager.defaltManager.error_listNode?.insert(values: errors, className: path.lastComponent, path: path.description)
            }
        }
        
    }
    
}


protocol  RegexStringsWriter : StringsSearcher{
    func writeToLocalizable (to path:Path)
}
extension RegexStringsWriter {
    
    func writeToLocalizable (to path:Path) {
        
        var content = !writeAppend ? "" : {
            return try? path.read(.utf16) 
        }() ?? ""

        let contentArr = contentRegex(content: content)
        
        content += "//-------------------swfit-------------------"
        
        let swift =  DataHandleManager.defaltManager.swift_listNode?.head
        DataHandleManager.defaltManager.outPutLinkNode(root: swift, action: { valuesOptial in
            if let values = valuesOptial {
                for value in values {
                    if !contentArr.contains(value.localizedString){
                        content += "\n\(value.comment)\n\(value.localizedString) = \(value.localizedString);\n"
                    }
                }
            }
        })
        
        content += "\n//\(NSDate())\n"
        content += "//-------------------objc-------------------"
        
        let objc =  DataHandleManager.defaltManager.oc_listNode?.head
        DataHandleManager.defaltManager.outPutLinkNode(root: objc, action: { valuesOptial in
            if let values = valuesOptial {
                for value in values {
                    if !contentArr.contains(value.localizedString){
                        content += "\n\(value.comment)\n\(value.localizedString) = \(value.localizedString);\n"
                    }
                }
            }
        })
        
        content += "\n//\(NSDate())\n"
        try? path.write(content, encoding: .utf16)
    }
    
}

func contentRegex(content:String)->[String]{
    guard let regex = try? NSRegularExpression(pattern: "\".+?\"", options: []) else {
        print("Failed to create regular expression.".red)
        return []
    }
    let matches = regex.matches(in: content, options: [], range: content.fullRange)
    return matches.map{NSString(string: content).substring(with: $0.rangeAt(0))}
}

func findAllLocalizable(with path:Path,excluded:[Path]) -> [Path]{
    
    if !path.exists {
        print("path is not exists!".yellow)
        return []
    }
    
    if !path.isWritable {
        print("path is not writable!".yellow)
        return []
    }
    let optonalPaths = try? path.recursiveChildren()
    
    guard let paths = optonalPaths else {return []}
    
    var results : [Path] = []
    
    for itemPath in Progress(pathsFilter(paths: paths, except: excluded)){
        let strings = itemPath.glob("*.strings")
        if strings.count > 0 {
            results = results + strings
        }
    }
    
    return results
}


func pathsFilter(paths:[Path],except:[Path])->[Path]{
    
    if paths.count == 0 {
        print("error: the vailable path is covered by your except path.".red)
        exit(EX_USAGE)
    }
    
    if except.count == 0 {
        return paths
    }
    
    var excepts = except
    excepts.removeLast()
    
    return pathsFilter(paths: paths.filter{!$0.description.contains(except.last!.description)}, except: excepts)
}


func parsePathToContent(with path:Path)->String{
    
    return (try? path.read()) ?? "read error , this path may be empty."
    
}
