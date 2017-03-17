//
//  Extensons.swift
//  localizationCommand
//
//  Created by 李军杰 on 2017/3/14.
//
//

import Foundation

extension String{
    var fullRange : NSRange{
        return NSMakeRange(0, utf16.count)
    }
    //  MARK:substring swift
    subscript (r: Range<Int>) -> String {
        get {
            
            if r.lowerBound >= 0 && r.upperBound < self.characters.count {
                let startIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
                let endIndex = self.index(self.startIndex, offsetBy: r.upperBound)
                
                return self[Range(startIndex..<endIndex)]
            }
            
            if r.lowerBound >  self.characters.count - 1 {
                return ""
            }
            
            if r.lowerBound > 0 && r.lowerBound <= (self.characters.count - 1) && r.upperBound >= self.characters.count{
                
                let startIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
                let endIndex = self.index(self.startIndex, offsetBy: self.characters.count)
                return self[Range(startIndex..<endIndex)]
            }
            
            return self
        }
    }

    
    var isAmbiguous : Bool {
        let judge1 = self.contains("%d")
        let judge2 = self.contains("%@")
        if judge1 != judge2 {
            return true
        }
        return judge2||judge1
    }
    
}


