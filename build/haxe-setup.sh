#!/bin/bash
set -e

# Set up Neko (latest version)
if [ ! -f ~/neko/neko-latest.tar.gz ]; then
  mkdir -p ~/neko
  curl -s -L --retry 3 'https://github.com/HaxeFoundation/neko/releases/latest/download/neko-linux64.tar.gz' -o ~/neko/neko-latest.tar.gz
  tar -C ~/neko -xzf ~/neko/neko-latest.tar.gz --strip-components=1
fi

# Set up Haxe (latest version)
if [ ! -f ~/haxe/haxe-latest-linux64.tar.gz ]; then
  mkdir -p ~/haxe
  curl -s -L --retry 3 'https://build.haxe.org/builds/haxe/latest/haxe-linux64.tar.gz' -o ~/haxe/haxe-latest-linux64.tar.gz
  tar -C ~/haxe -xzf ~/haxe/haxe-latest-linux64.tar.gz --strip-components=1
fi

# Set up haxelib (standard location)
haxelib setup ~/haxe/lib

# Install libraries
haxelib install lime
haxelib install openfl
haxelib install hxcpp
haxelib install flixel
haxelib install flixel-addons
haxelib install flixel-tools

# Optionally, you can update all libraries to the latest versions:
haxelib upgrade
