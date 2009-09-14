#!/bin/sh

osascript <<APPLESCRIPT
    tell application "Finder"
        open item "System:Library:Components:KeyboardViewer.component:Contents:SharedSupport:KeyboardViewerServer.app" of the startup disk
    end tell
APPLESCRIPT
