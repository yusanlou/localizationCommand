//
//  commandProtocol.swift
//  localizationCommand
//
//  Created by 李军杰 on 2017/3/14.
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
                
                let value = Values.init(value: localizedString, comment: commont.characters.count > 0 ? commont : COMMONT)
                extracts.append(value)
            }
            
            if path.lastComponent.contains(FileType.swift.rawValue) {
                DataHandleManager.defaltManager.swift_listNode?.insert(values: extracts, className: path.lastComponent, path: path.description)
            }else{
                DataHandleManager.defaltManager.oc_listNode?.insert(values: extracts, className: path.lastComponent, path: path.description)
            }

        }
        
    }
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
    
    
