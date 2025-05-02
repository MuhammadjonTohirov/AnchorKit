# AnchorKit

[![Swift](https://img.shields.io/badge/Swift-5.9-orange.svg)](https://swift.org)
[![Platform](https://img.shields.io/badge/platforms-iOS%2014.0-lightgrey.svg)](https://developer.apple.com/swift/)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

A lightweight, fluent Auto Layout DSL for UIKit that simplifies constraint creation and management with an elegant, chainable API.

## Features

- 🔗 **Chainable API**: Create multiple constraints in a single, readable chain
- 🧠 **Smart Memory Management**: Automatically cleans up constraints when views are deallocated
- 🎯 **Auto Layout Priority Support**: Built-in support for constraint priorities
- 🔄 **Constraint Updates**: Easy constraint updates with animation support
- 🎭 **Zero Subclassing**: Works with any UIView through extensions

## Requirements

- iOS 14.0+
- Swift 5.9+

## Installation

### Swift Package Manager

Add AnchorKit to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/yourusername/AnchorKit.git", from: "1.0.0")
]
```

## Usage

### Basic Example

```swift
import AnchorKit
import UIKit

// Simple example with a single view
let containerView = UIView()
let cardView = UIView()

// Add as subview
containerView.addSubview(cardView)

// Configure the card view
cardView.backgroundColor = .systemBlue
cardView.layer.cornerRadius = 12

// Set up constraints with AnchorKit
cardView.anchor
    .centerX(in: containerView)
    .centerY(in: containerView)
    .width(200)
    .height(120)
    .priority(.high)
```

### Advanced Usage

#### Working with Priorities

```swift
// Set constraint priorities with enum values
containerView.anchor
    .fillWidth(of: view, inset: 20).priority(.high)
    .centerY(in: view)
    .height(min: 300).priority(.medium)
    .top(min: view.safeAreaLayoutGuide.topAnchor, constant: 20).priority(.required)
    .bottom(max: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).priority(.required)

// Or use raw float values
imageView.anchor
    .width(200).priority(850)
```

#### Updating Constraints with Animation

```swift
UIView.animate(withDuration: 0.5) {
    // Update existing constraints
    self.containerView.anchor
        .fillWidthUpdate(of: self.view, inset: 10)
    
    // Apply changes immediately
    self.view.layoutIfNeeded()
}
```

#### Clear All Constraints

```swift
// Remove all constraints and release the anchor manager
myView.clearConstraints()
```

## Available Constraint Methods

AnchorKit provides a comprehensive set of constraint creation methods:

### Size Constraints
- `width(_:)`, `width(max:)`, `width(min:)`
- `height(_:)`, `height(max:)`, `height(min:)`

### Position Constraints
- `top(to:constant:)`, `top(min:constant:)`
- `bottom(to:constant:)`, `bottom(max:constant:)`
- `centerX(in:)`, `centerY(in:)`
- `centerInSuperview()`

### Filling Constraints
- `fillWidth(of:inset:)`

### Update Methods
- `widthUpdate(max:)`
- `fillWidthUpdate(of:inset:)`
- `topUpdate(min:constant:)`
- `bottomUpdate(max:constant:)`

## Memory Management

AnchorKit is designed to automatically clean up constraints when views are deallocated. No manual intervention is required to prevent memory leaks.

## License

AnchorKit is available under the MIT license. See the LICENSE file for more info.

## Author

Created by Muhammadjon Tohirov
