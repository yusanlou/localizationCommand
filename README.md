# localizationCommand
Command Line for localization (Supported OC and swift)
## Usage:
The simplest way to install the localizationCommand command-line tool is via Homebrew. If you already have Homebrew installed, just type
```
> brew update
> brew tap BackNotGod/localizationCommand && brew install localizationCommand
```

## How to use it ?
```
localizationcommand -h
```

```
  -h, --help:
      Prints a help message.
  -e, --exceptPath:
      exceptPath paths which should not search in.
  -p, --projectPath:
      projectPath paths which should search in.
  -v, --version:
      version.
  -s, --swift:
      will scan code files of *.swift.
  -m, --oc:
      will scan code files of *.m.
  -a, --append:
      append to the file context.
  -r, --replace:
      replace to the file context.
```

So,if you want to scan for your iOS project with localizationCommand, For example:
```
localizationcommand -p "Your pro path" -e "paths you don`t wanna scan for"
```

And,localizationCommand support two model to write to Localizable.strings file (default is replace model):
```
  -a, --append:
      append to the file context.
  -r, --replace:
      replace to the file context.
```

Then,localizationCommand can wirte the additional infomation to Localizable.strings file , like this:

```
 /* EXTableViewCell : "comment" */
 "xxx" = "xxxx";
```

if your  `NSLocalizedString(key: String, comment: String)->String` is Ambiguous ，At the end of commandline ,it will print:
```
NSObject+RACSelectorSignal.m: 
"A race condition occurred implementing %@ on class %@"
RACSignal+Operations.m: 
"No matching signal found for value %@"
```
## More info
  http://www.jianshu.com/p/a9ec43123860
## License

localizationCommand is released under the MIT license. See LICENSE for details.
