#!/bin/sh
mkdir ~/Library/Developer/Xcode/Templates/expanz
mkdir /Library/Application\ Support/Developer/Shared/Xcode/Plug-ins/expanz-xcodePlugin.xcplugin
cp -fr /tmp/ProjectTemplates/* ~/Library/Developer/Xcode/Templates/expanz
cp -fr /tmp/expanz-xcodePlugin.xcplugin/ /Library/Application\ Support/Developer/Shared/Xcode/Plug-ins/expanz-xcodePlugin.xcplugin


