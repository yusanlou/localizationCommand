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
    
    public mutating func findTargetFiles(){
        let optonalPaths = try? projectPath.recursiveChildren()
        guard let paths = optonalPaths else {return}
        for itemPath in pathsFilter(paths: paths, except: exceptPath){
            let swifts = itemPath.glob("*.swift")
            for item in swifts {
                swiftPath.append(item)
            }
            let ocs = itemPath.glob("*.m")
            for item in ocs {
                ocPath.append(item)
            }
        }
        // test
        for item in swiftPath {
            print(item.description.red)
        }
        for item in ocPath {
            print(item.description.blue)
        }

    }
    
    
}


