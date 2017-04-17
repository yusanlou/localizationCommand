#!/bin/sh
swift build --clean
swift test
swift build -c release
cp .build/release/localizationCommand /usr/local/bin/localizationCommand
