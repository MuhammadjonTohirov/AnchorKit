import UIKit

@MainActor private var anchorManagerKey: UInt8 = 0

@MainActor
extension UIView {
  /// The persistent AnchorKit constraint manager associated with this view.
  ///
  /// Accessing this property sets `translatesAutoresizingMaskIntoConstraints`
  /// to `false` the first time the manager is created.
  public var anchor: Anchor {
    if let manager = objc_getAssociatedObject(self, &anchorManagerKey) as? Anchor {
      return manager
    }

    let manager = Anchor(view: self)
    objc_setAssociatedObject(
      self,
      &anchorManagerKey,
      manager,
      .OBJC_ASSOCIATION_RETAIN_NONATOMIC
    )
    return manager
  }

  /// Deactivates and forgets only the constraints created through AnchorKit.
  ///
  /// Constraints created elsewhere, including constraints governing this
  /// view's subviews, are left untouched.
  public func clearConstraints() {
    guard let manager = objc_getAssociatedObject(self, &anchorManagerKey) as? Anchor else {
      return
    }
    manager.removeAllConstraints()
    objc_setAssociatedObject(
      self,
      &anchorManagerKey,
      nil,
      .OBJC_ASSOCIATION_RETAIN_NONATOMIC
    )
  }
}
