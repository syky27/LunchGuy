#!/bin/bash

icon2png() {
  convert -density 1200 -resize "$1" icon.svg "$2"
}

icon2png 40x40 "../LunchGuy/Assets.xcassets/AppIcon.appiconset/Icon-40.png"
icon2png 80x80 "../LunchGuy/Assets.xcassets/AppIcon.appiconset/Icon-40@2x.png"

icon2png 120x120 "../LunchGuy/Assets.xcassets/AppIcon.appiconset/Icon-40@3x.png"

icon2png 120x120 "../LunchGuy/Assets.xcassets/AppIcon.appiconset/Icon-60@2x.png"
icon2png 180x180 "../LunchGuy/Assets.xcassets/AppIcon.appiconset/Icon-60@3x.png"

icon2png 72x72 "../LunchGuy/Assets.xcassets/AppIcon.appiconset/Icon-72.png"
icon2png 144x144 "../LunchGuy/Assets.xcassets/AppIcon.appiconset/Icon-72@2x.png"

icon2png 76x76 "../LunchGuy/Assets.xcassets/AppIcon.appiconset/Icon-76.png"
icon2png 152x152 "../LunchGuy/Assets.xcassets/AppIcon.appiconset/Icon-76@2x.png"
icon2png 167x167 "../LunchGuy/Assets.xcassets/AppIcon.appiconset/Icon-83.5@3x.png"

icon2png 50x50 "../LunchGuy/Assets.xcassets/AppIcon.appiconset/Icon-Small-50.png"
icon2png 100x100 "../LunchGuy/Assets.xcassets/AppIcon.appiconset/Icon-Small-50@2x.png"

icon2png 29x29 "../LunchGuy/Assets.xcassets/AppIcon.appiconset/Icon-Small.png"
icon2png 58x58 "../LunchGuy/Assets.xcassets/AppIcon.appiconset/Icon-Small@2x.png"
icon2png 87x87 "../LunchGuy/Assets.xcassets/AppIcon.appiconset/Icon-Small@3x.png"

icon2png 27x27 "../LunchGuy/Assets.xcassets/AppIcon.appiconset/Icon.png"
icon2png 54x54 "../LunchGuy/Assets.xcassets/AppIcon.appiconset/Icon@2x.png"
