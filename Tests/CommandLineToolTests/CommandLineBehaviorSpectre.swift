//
//  CommandLineBehaviorSpectre.swift
//  localizationCommand
//
//  Created by BackNotGod on 2017/3/17.
//
//

import Foundation
import Spectre
import PathKit
@testable import commandService

public func CommandLineToolSpectre() {
    
    describe("commandServiceKit"){
        let path1 = Path("/Users/lijunjie/desktop/command-localization/localizationCommand")
        let path2 = Path("/Users/lijunjie//command-localization/localizationCommand")
        let path3 = Path("/Users/lijunjie/desktop/TSL_APP/TSL_APP")
        let path4 = Path("/Users/lijunjie/desktop/-localization/localizationCommand")
        let path5 = Path("/Users/lijunjie/command-localization/localizationCommand")
        let path6 = Path("/private/")

        $0.describe("parsePathToContent function"){
            
            $0.it("should find correct path"){
     
                try expect(parsePathToContent(with: path1).characters.count) > 0
                try expect(parsePathToContent(with: path2).characters.count) > 0
                try expect(parsePathToContent(with: path3).characters.count) > 0
                try expect(parsePathToContent(with: path4).characters.count) > 0
                try expect(parsePathToContent(with: path5).characters.count) > 0
                try expect(parsePathToContent(with: path6).characters.count) > 0
                
                
            }
        }
        
        
        $0.describe("findAllLocalizable function"){
            $0.it("findAllLocalizable should return file that contains .strings"){
            
                try expect(findAllLocalizable(with: path1,excluded: []).count) == 0
                try expect(findAllLocalizable(with: path2,excluded: []).count) == 0
                try expect(findAllLocalizable(with: path3,excluded: []).count) > 0
                try expect(findAllLocalizable(with: path4,excluded: []).count) == 0
                try expect(findAllLocalizable(with: path5,excluded: []).count) == 0
                try expect(findAllLocalizable(with: path6,excluded: []).count) == 0
                
            }
        }
    
        $0.describe("pathsFilter spectre test"){
            $0.it("return value sholud not in paths and should be in except"){
                let path1 = Path("/Users/lijunjie/desktop/command-localization/localizationCommand")
                let path2 = Path("/Users/lijunjie//command-localization/localizationCommand")
                let path3 = Path("/Users/lijunjie")
                let path4 = Path("/Users/lijunjie/desktop/-localization/localizationCommand")
                let path5 = Path("/Users/lijunjie/command-localization/localizationCommand")
                let path6 = Path("lijunjie/desktop/command-localization/localizationCommand")
                let paths = [path1,path2,path3,path4,path5,path6]
                let ex_path4 = Path("/Users/lijunjie/desktop/-localization/")
                let ex_path6 = Path("/private/tmp")
                let ex_paths = [ex_path4,ex_path6]
                for path in paths{
                    for item in pathsFilter(paths: (try? path.children()) ?? [Path.init()], except: ex_paths) {
                        for result in ex_paths {
                            try expect(result.contains(item)).to.beFalse()
                        }
                    }
                }
                
            }
        }
    
        
        
        $0.describe("string extension '...' test"){
            $0.it("show return the range of string"){
                
                let unity = "fdajdkfjdklajkfldajklfdjakljfkldajfklda;fk ljklafj dkla;jfmu2439894314[1431\nfdklfjafjdkalfjkdla"
                let unity1 = ""
                let unity2 = "s"
                let unity3 = "lllll"
                let unitys = [unity,unity1,unity2,unity3]
                let bengin = 1
                let end = 22
                for item in unitys {
                    try expect(item[bengin..<end].characters.count) <= end - bengin
                }
            }
            
            $0.it("isAmbiguous test correct?"){
                
                let str1 = "fdjaklfda%j@fdklafjkld"
                let str2 = "_shiftButton setTi%dtle:@\"ABC\" forState:UIControlStateNorma"
                let str3 = "[_shiftButton setTitle:@\"省\" forState:UIControlStateNormal];"
                let str4 = "nsstring.init(%d,213123);"
                let str5 = "\\"
                try expect(str1.isAmbiguous).to.beFalse()
                try expect(str2.isAmbiguous).to.beTrue()
                try expect(str3.isAmbiguous).to.beFalse()
                try expect(str4.isAmbiguous).to.beTrue()
                try expect(str5.isAmbiguous).to.beTrue()

            }
        }
        
        $0.describe("value test func "){
            $0.it("'isSame' function"){
                
                let value1 = Values.init(value: "1111", comment: "")
                let value2 = Values.init(value: "11111", comment: "")
                
                let judge1 = value1.localizedString == value2.localizedString
                let judge2 = value1.comment == value2.comment
                print(judge1&&judge2)
                print(isSameValues(value1, value2:value2))
                try expect(isSameValues(value1, value2:value2)).to.beFalse()
                
            }
        }
        
        
    }

}

