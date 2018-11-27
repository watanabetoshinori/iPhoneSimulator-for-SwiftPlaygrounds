# iPhoneSimulator for Swift Playgrounds

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

![Preview](Preview/Preview.gif)

**iPhoneSimulator for Swift Playgrounds** is an *Swift Playgrounds* file that can display the view controller with simulating the screen size of the iPhone devices.

You can also found the *Xcode Playground* version from [here](https://github.com/watanabetoshinori/iPhoneSimulator).

- [Features](#Features)
- [Getting Started](#getting-started)
    - [Requirements](#requirements)
    - [Installation](#installation)
- [Usage](#usage)
    - [Run iPhone Simulator](#run-iphone-simulator)
    - [Change Device or Orientation](#change-device-or-orientation)
- [Author](#author)
- [License](#license)

## Features
- [x] Simulate the iPhone screen sizes. (8 Plus / X / 8 / SE / 4S)
- [x] Simulate the orientation. (Landscape / Portrait)

## Getting Started

### Requirements

* iPad
* [Swift Playgrounds](https://www.apple.com/swift/playgrounds/)

### Installation

Transfer `iPhoneSimulator.playground` file to iPad via AirDrop or iTunes Sync.

## Usage

### Run iPhone Simulator

```swift
// Run View Controller with iPhone Simulator
PlaygroundPage.current.liveView = iPhoneSimulator.liveView(with: viewController)
```

### Change Device or Orientation

Tap the bottom of LiveView to display the toolbar.

![Toolbar](Preview/Toolbar.jpg)

* Tap Device image to change simulation device.
* Tap Orientaion to change view orientation.

## Author

Watanabe Toshinori – toshinori_watanabe@tiny.blue

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
