import Foundation
import PathKit
import Rainbow

public struct localizationCommand {
    let projectPath : Path
    let exceptPath : [Path]
    internal var ocPath : [Path] = []
    internal var swiftPath : [Path] = []
    public init(projPath:String,except:[String]){
        let path = Path(projPath).absolute()
        projectPath = path
        exceptPath = except.map{path + Path($0)}
    }
    public func outputVersion() {
        print(VERSION.red)
    }
    
    public mutating func outputChildren(){
       let optonalPaths = try? projectPath.recursiveChildren()
        guard let paths = optonalPaths else {return}
        for itemPath in paths{
           let swifts = itemPath.glob("*.swift")
            for except in exceptPath {
                for item in swifts {
                    if !(item.description.contains(except.description)){
                    }
                    swiftPath.append(item)
                }
            }
        }
        // test 
        for item in swiftPath {
            print(item.description.red)
        }
    }
    
}
