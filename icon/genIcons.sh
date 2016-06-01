#!/bin/bash

qlmanage -t -s 2048 -o . icon.svg && 

sips --resampleWidth 40 icon.svg.png --out "../LunchGuy/Assets.xcassets/AppIcon.appiconset/Icon-40.png"
sips --resampleWidth 80 icon.svg.png --out "../LunchGuy/Assets.xcassets/AppIcon.appiconset/Icon-40@2x.png"
sips --resampleWidth 120 icon.svg.png --out "../LunchGuy/Assets.xcassets/AppIcon.appiconset/Icon-40@3x.png"

sips --resampleWidth 120 icon.svg.png --out "../LunchGuy/Assets.xcassets/AppIcon.appiconset/Icon-60@2x.png"
sips --resampleWidth 180 icon.svg.png --out "../LunchGuy/Assets.xcassets/AppIcon.appiconset/Icon-60@3x.png"

sips --resampleWidth 72 icon.svg.png --out "../LunchGuy/Assets.xcassets/AppIcon.appiconset/Icon-72.png"
sips --resampleWidth 144 icon.svg.png --out "../LunchGuy/Assets.xcassets/AppIcon.appiconset/Icon-72@2x.png"

sips --resampleWidth 76 icon.svg.png --out "../LunchGuy/Assets.xcassets/AppIcon.appiconset/Icon-76.png"
sips --resampleWidth 152 icon.svg.png --out "../LunchGuy/Assets.xcassets/AppIcon.appiconset/Icon-76@2x.png"
sips --resampleWidth 167 icon.svg.png --out "../LunchGuy/Assets.xcassets/AppIcon.appiconset/Icon-83.5@3x.png"

sips --resampleWidth 50 icon.svg.png --out "../LunchGuy/Assets.xcassets/AppIcon.appiconset/Icon-Small-50.png"
sips --resampleWidth 100 icon.svg.png --out "../LunchGuy/Assets.xcassets/AppIcon.appiconset/Icon-Small-50@2x.png"


sips --resampleWidth 29 icon.svg.png --out "../LunchGuy/Assets.xcassets/AppIcon.appiconset/Icon-Small.png"
sips --resampleWidth 58 icon.svg.png --out "../LunchGuy/Assets.xcassets/AppIcon.appiconset/Icon-Small@2x.png"
sips --resampleWidth 87 icon.svg.png --out "../LunchGuy/Assets.xcassets/AppIcon.appiconset/Icon-Small@3x.png"

sips --resampleWidth 27 icon.svg.png --out "../LunchGuy/Assets.xcassets/AppIcon.appiconset/Icon.png"
sips --resampleWidth 54 icon.svg.png --out "../LunchGuy/Assets.xcassets/AppIcon.appiconset/Icon@2x.png"
