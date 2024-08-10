#!/bin/bash

# atrun サービスを起動
function launch-atrun {
    sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.atrun.plist
}