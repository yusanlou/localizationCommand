import Foundation
import CommandLineKit
import PathKit
import Spectre
import Rainbow
import commandService
/**
 Description
 
 - exceptPath:  drop path without scan
 - projectPath: path
 - help:        help infomataion
 - version:     version
 - a / -r : defalut is -r (append or replace)
 */
let cli = CommandLineKit.CommandLine()
let help = BoolOption(shortFlag: "h", longFlag: "help",
                      helpMessage: "Prints a help message.")
let exceptPath = MultiStringOption(shortFlag: "e", longFlag: "exceptPath", helpMessage: "exceptPath paths which should not search in.")
let projectPath = StringOption(shortFlag: "p", longFlag: "projectPath", helpMessage: "projectPath paths which should search in.")
let version = BoolOption(shortFlag: "v", longFlag: "version",
                      helpMessage: "version.")
//let swift = BoolOption(shortFlag: "s", longFlag: "swift",
//                         helpMessage: "will scan code files of *.swift.")
//let oc = BoolOption(shortFlag: "m", longFlag: "oc",
//                         helpMessage: "will scan code files of *.m.")
// not in this time
let appendOpt  = BoolOption(shortFlag: "a", longFlag: "append", helpMessage: "append to the file context.")
let replaceOpt = BoolOption(shortFlag: "r", longFlag: "replace", helpMessage: "replace to the file context.")

cli.setOptions(help,exceptPath,projectPath,version,appendOpt,replaceOpt)

cli.formatOutput = { s,type in
    var str: String
    switch(type) {
    case .error:
        str = s.red.bold
    case .optionFlag:
        str = s.green.underline
    case .optionHelp:
        str = s.lightBlue
    default:
        str = s
    }
    return cli.defaultFormat(s: str, type: type)

}
do {
    try cli.parse()
} catch {
    cli.printUsage(error)
    exit(EX_USAGE)
}

if version.value {
    print("1.0.3".blue)
    exit(EX_USAGE)
}

if help.value{
    cli.printUsage()
    exit(EX_USAGE)
}

if projectPath.value == nil {
    print("your projectPath input empty , if you want to do this , projectPath will be current path!".yellow)
    print("you wan to do this ? (y/n) or enter to skip.".red)
    
    let respond = readLine()
    if let res = respond {
        if res == "n"{
            exit(EX_USAGE)
        }
    }
}

if exceptPath.value == nil {
    print("your exceptPath input empty , if you want to do this , we will scan all of this directory and extract the localization str.".yellow)
    print("you wan to do this (y/n) or enter to skip?".red)
    
    let respond = readLine()
    if let res = respond {
        if res == "n"{
            exit(EX_USAGE)
        }
    }
    
}

var commandService = localizationCommand.init(projPath: projectPath.value ?? FileManager.default.currentDirectoryPath, except: exceptPath.value ?? [])
writeAppend = appendOpt.value
writeReplace = replaceOpt.value
commandService.findTargetPath()




