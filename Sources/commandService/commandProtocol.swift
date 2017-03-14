//
//  commandProtocol.swift
//  localizationCommand
//
//  Created by 李军杰 on 2017/3/14.
//
//

import Foundation
import PathKit

protocol StringsSearcher {
    func search(in content: String) -> Set<String>
}

protocol RegexStringsSearcher: StringsSearcher {
    var patterns: [String] { get }
}

extension RegexStringsSearcher {
    func search(in content: String) -> Set<String> {
        
        var result = Set<String>()
        
        for pattern in patterns {
            guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
                print("Failed to create regular expression: \(pattern)")
                continue
            }
            
            let matches = regex.matches(in: content, options: [], range: content.fullRange)
            for checkingResult in matches {
                let range = checkingResult.rangeAt(1)
                let extracted = NSString(string: content).substring(with: range)
            }
        }
        
        return result
    }
}

func pathsFilter(paths:[Path],except:[Path])->[Path]{
    if paths.count == 0 {
        print("your except paths is covered the vailable path".red)
        exit(EX_USAGE)
    }
    if except.count == 0 {
        return paths
    }
    var excepts = except
    excepts.removeLast()
    return pathsFilter(paths: paths.filter{!$0.description.contains(except.last!.description)}, except: excepts)
}
