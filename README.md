# AnchorKit

[![Swift](https://img.shields.io/badge/Swift-5.9-orange.svg)](https://swift.org)
[![Platform](https://img.shields.io/badge/platform-iOS%2014%2B-lightgrey.svg)](https://developer.apple.com/ios/)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

AnchorKit is a lightweight, fluent Auto Layout API for UIKit. It provides concise constraint declarations while retaining access to the underlying `NSLayoutConstraint` objects.

## Highlights

- Chainable, main-actor-isolated UIKit API
- Safe replacement when the same managed constraint is declared again
- Priorities applied to complete constraint groups before safe reactivation
- `UIView` and `UILayoutGuide` targets
- Directional edge insets, centering, relative dimensions, and aspect ratios
- Constraint updates suitable for animation
- Activation, deactivation, identifiers, and direct constraint handles
- Ownership-safe cleanup that leaves non-AnchorKit constraints untouched

## Requirements

- iOS 14+
- Swift 5.9+

## Installation

Add AnchorKit with Swift Package Manager:

```swift
dependencies: [
    .package(
        url: "https://github.com/MuhammadjonTohirov/AnchorKit.git",
        from: "2.0.0"
    )
]
```

Then add `AnchorKit` to the dependencies of your application target.

## Basic usage

Add the view to a hierarchy before activating constraints that relate it to another view or layout guide:

```swift
import AnchorKit
import UIKit

let cardView = UIView()
view.addSubview(cardView)

cardView.anchor
    .fillWidth(of: view.safeAreaLayoutGuide, inset: 20)
    .centerY(in: view.safeAreaLayoutGuide)
    .height(min: 160)
    .height(max: 320)
```

Accessing `anchor` sets `translatesAutoresizingMaskIntoConstraints` to `false` when the manager is first created.

## Edges and insets

```swift
contentView.anchor.fill(
    containerView.safeAreaLayoutGuide,
    insets: NSDirectionalEdgeInsets(
        top: 16,
        leading: 20,
        bottom: 16,
        trailing: 20
    )
)
```

Available positioning methods include equal, minimum, and maximum forms for `leading`, `trailing`, `top`, and `bottom`. AnchorKit also provides `fillWidth`, `fillHeight`, `fill`, `fillSuperview`, `centerX`, `centerY`, and `center`.

## Size and proportions

```swift
imageView.anchor
    .width(to: containerView.widthAnchor, multiplier: 0.5)
    .aspectRatio(16.0 / 9.0)

button.anchor.size(width: 200, height: 50)
```

Width and height support equality, minimum, and maximum constants as well as relationships to another `NSLayoutDimension`.

## Priorities

Priority modifiers apply to every constraint created by the immediately preceding operation:

```swift
cardView.anchor
    .fillWidth(of: view, inset: 20)
    .priority(.high)
    .height(min: 200)
    .priority(.medium)
```

Presets are:

- `.required`: `1000`
- `.high`: `999`, useful as a controlled failure point
- `.medium`: UIKit default-high, `750`
- `.low`: UIKit default-low, `250`
- `.custom(Float)`

UIKit priorities can also be passed with `priority(uiKit:)`.

## Updating and animation

```swift
containerView.anchor.fillWidth(of: view, inset: 20)

containerView.anchor.fillWidthUpdate(of: view, inset: 8)

UIView.animate(withDuration: 0.3) {
    view.layoutIfNeeded()
}
```

AnchorKit includes update methods for constant sizes, direct edge constraints, centering, horizontal/vertical fills, and complete edge fills. Updating a constraint that AnchorKit does not manage triggers an assertion in debug builds.

## Constraint handles and lifecycle

```swift
let manager = badgeView.anchor
    .size(width: 24, height: 24)
    .identified("profile.badge.size")

let sizeConstraints = manager.lastConstraints

manager.deactivate()
manager.activate()

badgeView.clearConstraints()
```

- `lastConstraints` contains the constraints affected by the previous operation.
- `constraints` contains every constraint managed for the view.
- Repeating the same managed constraint deactivates and replaces the previous instance.
- `clearConstraints()` deactivates only constraints created through that view's AnchorKit manager.

## Intrinsic content size

```swift
label.anchor
    .hugging(.defaultHigh, for: .horizontal)
    .compressionResistance(.required, for: .vertical)
```

First- and last-baseline alignment are available through `firstBaseline(to:)` and `lastBaseline(to:)`.
System spacing is available through `leading(systemSpacingAfter:)`, `trailing(systemSpacingBefore:)`, `top(systemSpacingBelow:)`, and `bottom(systemSpacingAbove:)`.

## Testing

The package includes iOS unit tests covering replacement, updates, grouped priorities, activation, layout guides, identifiers, and ownership-safe clearing.

## License

AnchorKit is available under the [MIT license](LICENSE).
