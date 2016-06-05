#!/bin/bash

DENSITY=300 # 300 for best results

icon2png() {
  echo -n "$1: "
  convert -density $DENSITY -resize "$1x$1" -print "%wx%h\n" icon.svg "$2"
}

icon2png 40 "../LunchGuy/Assets.xcassets/AppIcon.appiconset/Icon-40.png"
icon2png 80 "../LunchGuy/Assets.xcassets/AppIcon.appiconset/Icon-40@2x.png"

icon2png 120 "../LunchGuy/Assets.xcassets/AppIcon.appiconset/Icon-40@3x.png"

icon2png 120 "../LunchGuy/Assets.xcassets/AppIcon.appiconset/Icon-60@2x.png"
icon2png 180 "../LunchGuy/Assets.xcassets/AppIcon.appiconset/Icon-60@3x.png"

icon2png 72 "../LunchGuy/Assets.xcassets/AppIcon.appiconset/Icon-72.png"
icon2png 144 "../LunchGuy/Assets.xcassets/AppIcon.appiconset/Icon-72@2x.png"

icon2png 76 "../LunchGuy/Assets.xcassets/AppIcon.appiconset/Icon-76.png"
icon2png 152 "../LunchGuy/Assets.xcassets/AppIcon.appiconset/Icon-76@2x.png"
icon2png 167 "../LunchGuy/Assets.xcassets/AppIcon.appiconset/Icon-83.5@2x.png"

icon2png 50 "../LunchGuy/Assets.xcassets/AppIcon.appiconset/Icon-Small-50.png"
icon2png 100 "../LunchGuy/Assets.xcassets/AppIcon.appiconset/Icon-Small-50@2x.png"

icon2png 29 "../LunchGuy/Assets.xcassets/AppIcon.appiconset/Icon-Small.png"
icon2png 58 "../LunchGuy/Assets.xcassets/AppIcon.appiconset/Icon-Small@2x.png"
icon2png 87 "../LunchGuy/Assets.xcassets/AppIcon.appiconset/Icon-Small@3x.png"

icon2png 57 "../LunchGuy/Assets.xcassets/AppIcon.appiconset/Icon.png"
icon2png 114 "../LunchGuy/Assets.xcassets/AppIcon.appiconset/Icon@2x.png"
