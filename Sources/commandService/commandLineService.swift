import Foundation
import PathKit
import Rainbow

public struct localizationCommand :RegexStringsSearcher{
    let projectPath : Path
    let exceptPath : [Path]
    internal var ocPath : [Path] = []
    internal var swiftPath : [Path] = []
    var patterns: [String]
    
    public init(projPath:String,except:[String]){
        let path = Path(projPath).absolute()
        projectPath = path
        exceptPath = except.map{path + Path($0)}
        patterns = []
    }
    public func outputVersion() {
        print(VERSION.red)
    }
    func search(in content: String) {
        
    }
    
    public mutating func findTargetFiles(){
        let optonalPaths = try? projectPath.recursiveChildren()
        guard let paths = optonalPaths else {return}
        for itemPath in pathsFilter(paths: paths, except: exceptPath){
            let swifts = itemPath.glob(FileType.swift.rawValue)
            for item in swifts {
                swiftPath.append(item)
            }
            let ocs = itemPath.glob(FileType.oc.rawValue)
            for item in ocs {
                ocPath.append(item)
            }
        }
        // test
//        for item in swiftPath {
//            patterns = [TEST_REGEX]
//            search(in: item)
//        }
//        DataHandleManager.defaltManager.mapSwfit()
        for item in ocPath {
            patterns = [OC_REGEX]
            search(in: item)
        }
        DataHandleManager.defaltManager.mapOC()

    }
    
    
}


