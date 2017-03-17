import PackageDescription

let package = Package(
    name: "localizationCommand",
    targets: [
        Target(name: "localizationCommand", dependencies: ["commandService"]),
        Target(name: "commandService", dependencies: [])
    ],
    dependencies: [
        .Package(url: "https://github.com/jatoben/CommandLine", "3.0.0-pre1"),
        .Package(url: "https://github.com/onevcat/Rainbow", majorVersion: 2),
        .Package(url: "https://github.com/kylef/Spectre.git", majorVersion: 0),
        .Package(url: "https://github.com/jkandzi/Progress.swift", majorVersion: 0),
        .Package(url: "https://github.com/kylef/PathKit", majorVersion: 0, minor: 8)
    ]
)
