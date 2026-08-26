import UIKit

extension Anchor {
  /// Readable priority presets for fluent constraint declarations.
  public enum ConstraintPriority: Sendable {
    case required
    /// A nearly-required failure point (`999`).
    case high
    /// UIKit's default-high priority (`750`).
    case medium
    /// UIKit's default-low priority (`250`).
    case low
    case custom(Float)

    fileprivate var value: UILayoutPriority {
      switch self {
      case .required:
        return .required
      case .high:
        return UILayoutPriority(999)
      case .medium:
        return .defaultHigh
      case .low:
        return .defaultLow
      case .custom(let value):
        return UILayoutPriority(value)
      }
    }
  }

  /// Applies a priority to every constraint created by the previous operation.
  ///
  /// AnchorKit temporarily deactivates installed constraints before changing
  /// their priority, allowing safe transitions between required and optional.
  @discardableResult
  public func priority(_ priority: ConstraintPriority) -> Anchor {
    applyPriority(priority.value)
  }

  /// Applies a UIKit layout priority to the previous constraint group.
  @discardableResult
  public func priority(uiKit priority: UILayoutPriority) -> Anchor {
    applyPriority(priority)
  }

  /// Convenience overload for numeric priority literals.
  @discardableResult
  public func priority(_ value: Float) -> Anchor {
    applyPriority(UILayoutPriority(value))
  }

  private func applyPriority(_ priority: UILayoutPriority) -> Anchor {
    precondition(
      priority.rawValue > 0 && priority.rawValue <= UILayoutPriority.required.rawValue,
      "AnchorKit priorities must be greater than 0 and no greater than 1000."
    )
    modifyLastConstraints { $0.priority = priority }
    return self
  }
}
