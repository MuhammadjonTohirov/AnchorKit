import UIKit

/// Creates and owns Auto Layout constraints for a single view.
///
/// Access an instance through ``UIView/anchor``. Calling the same constraint
/// method again replaces the previously managed constraint with the same
/// attribute, relation, and target.
@MainActor
public final class Anchor {
  private enum Attribute: Hashable {
    case leading
    case trailing
    case top
    case bottom
    case centerX
    case centerY
    case firstBaseline
    case lastBaseline
    case width
    case height
    case aspectRatio
  }

  private enum Relation: Hashable {
    case equal
    case atLeast
    case atMost
  }

  private struct ConstraintKey: Hashable {
    let attribute: Attribute
    let relation: Relation
    let target: ObjectIdentifier?
  }

  private weak var view: UIView?
  private var managedConstraints: [ConstraintKey: NSLayoutConstraint] = [:]
  private var lastAffectedConstraints: [NSLayoutConstraint] = []

  /// Constraints created or updated by the most recent fluent operation.
  public var lastConstraints: [NSLayoutConstraint] {
    lastAffectedConstraints
  }

  /// Every constraint currently owned by this manager.
  public var constraints: [NSLayoutConstraint] {
    Array(managedConstraints.values)
  }

  init(view: UIView) {
    self.view = view
    view.translatesAutoresizingMaskIntoConstraints = false
  }

  // MARK: - Size

  @discardableResult
  public func width(_ constant: CGFloat) -> Anchor {
    guard let view else { return self }
    return store(
      view.widthAnchor.constraint(equalToConstant: constant),
      attribute: .width,
      relation: .equal
    )
  }

  @discardableResult
  public func width(min constant: CGFloat) -> Anchor {
    guard let view else { return self }
    return store(
      view.widthAnchor.constraint(greaterThanOrEqualToConstant: constant),
      attribute: .width,
      relation: .atLeast
    )
  }

  @discardableResult
  public func width(max constant: CGFloat) -> Anchor {
    guard let view else { return self }
    return store(
      view.widthAnchor.constraint(lessThanOrEqualToConstant: constant),
      attribute: .width,
      relation: .atMost
    )
  }

  @discardableResult
  public func width(
    to dimension: NSLayoutDimension,
    multiplier: CGFloat = 1,
    constant: CGFloat = 0
  ) -> Anchor {
    guard let view else { return self }
    return store(
      view.widthAnchor.constraint(equalTo: dimension, multiplier: multiplier, constant: constant),
      attribute: .width,
      relation: .equal,
      target: dimension
    )
  }

  @discardableResult
  public func width(
    min dimension: NSLayoutDimension,
    multiplier: CGFloat = 1,
    constant: CGFloat = 0
  ) -> Anchor {
    guard let view else { return self }
    return store(
      view.widthAnchor.constraint(
        greaterThanOrEqualTo: dimension,
        multiplier: multiplier,
        constant: constant
      ),
      attribute: .width,
      relation: .atLeast,
      target: dimension
    )
  }

  @discardableResult
  public func width(
    max dimension: NSLayoutDimension,
    multiplier: CGFloat = 1,
    constant: CGFloat = 0
  ) -> Anchor {
    guard let view else { return self }
    return store(
      view.widthAnchor.constraint(
        lessThanOrEqualTo: dimension,
        multiplier: multiplier,
        constant: constant
      ),
      attribute: .width,
      relation: .atMost,
      target: dimension
    )
  }

  @discardableResult
  public func height(_ constant: CGFloat) -> Anchor {
    guard let view else { return self }
    return store(
      view.heightAnchor.constraint(equalToConstant: constant),
      attribute: .height,
      relation: .equal
    )
  }

  @discardableResult
  public func height(min constant: CGFloat) -> Anchor {
    guard let view else { return self }
    return store(
      view.heightAnchor.constraint(greaterThanOrEqualToConstant: constant),
      attribute: .height,
      relation: .atLeast
    )
  }

  @discardableResult
  public func height(max constant: CGFloat) -> Anchor {
    guard let view else { return self }
    return store(
      view.heightAnchor.constraint(lessThanOrEqualToConstant: constant),
      attribute: .height,
      relation: .atMost
    )
  }

  @discardableResult
  public func height(
    to dimension: NSLayoutDimension,
    multiplier: CGFloat = 1,
    constant: CGFloat = 0
  ) -> Anchor {
    guard let view else { return self }
    return store(
      view.heightAnchor.constraint(equalTo: dimension, multiplier: multiplier, constant: constant),
      attribute: .height,
      relation: .equal,
      target: dimension
    )
  }

  @discardableResult
  public func height(
    min dimension: NSLayoutDimension,
    multiplier: CGFloat = 1,
    constant: CGFloat = 0
  ) -> Anchor {
    guard let view else { return self }
    return store(
      view.heightAnchor.constraint(
        greaterThanOrEqualTo: dimension,
        multiplier: multiplier,
        constant: constant
      ),
      attribute: .height,
      relation: .atLeast,
      target: dimension
    )
  }

  @discardableResult
  public func height(
    max dimension: NSLayoutDimension,
    multiplier: CGFloat = 1,
    constant: CGFloat = 0
  ) -> Anchor {
    guard let view else { return self }
    return store(
      view.heightAnchor.constraint(
        lessThanOrEqualTo: dimension,
        multiplier: multiplier,
        constant: constant
      ),
      attribute: .height,
      relation: .atMost,
      target: dimension
    )
  }

  @discardableResult
  public func size(width: CGFloat, height: CGFloat) -> Anchor {
    guard let view else { return self }
    return store([
      entry(
        view.widthAnchor.constraint(equalToConstant: width),
        attribute: .width,
        relation: .equal
      ),
      entry(
        view.heightAnchor.constraint(equalToConstant: height),
        attribute: .height,
        relation: .equal
      ),
    ])
  }

  /// Constrains `width` to `height * ratio`.
  @discardableResult
  public func aspectRatio(_ ratio: CGFloat) -> Anchor {
    precondition(ratio > 0, "AnchorKit aspect ratios must be greater than zero.")
    guard let view else { return self }
    return store(
      view.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: ratio),
      attribute: .aspectRatio,
      relation: .equal,
      target: view
    )
  }

  // MARK: - Horizontal position

  @discardableResult
  public func leading(to anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> Anchor {
    guard let view else { return self }
    return store(
      view.leadingAnchor.constraint(equalTo: anchor, constant: constant),
      attribute: .leading,
      relation: .equal,
      target: anchor
    )
  }

  @discardableResult
  public func leading(min anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> Anchor {
    guard let view else { return self }
    return store(
      view.leadingAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant),
      attribute: .leading,
      relation: .atLeast,
      target: anchor
    )
  }

  @discardableResult
  public func leading(max anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> Anchor {
    guard let view else { return self }
    return store(
      view.leadingAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant),
      attribute: .leading,
      relation: .atMost,
      target: anchor
    )
  }

  /// Places the leading edge after another horizontal anchor using system spacing.
  @discardableResult
  public func leading(
    systemSpacingAfter anchor: NSLayoutXAxisAnchor,
    multiplier: CGFloat = 1
  ) -> Anchor {
    guard let view else { return self }
    return store(
      view.leadingAnchor.constraint(
        equalToSystemSpacingAfter: anchor,
        multiplier: multiplier
      ),
      attribute: .leading,
      relation: .equal,
      target: anchor
    )
  }

  @discardableResult
  public func trailing(to anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> Anchor {
    guard let view else { return self }
    return store(
      view.trailingAnchor.constraint(equalTo: anchor, constant: constant),
      attribute: .trailing,
      relation: .equal,
      target: anchor
    )
  }

  @discardableResult
  public func trailing(min anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> Anchor {
    guard let view else { return self }
    return store(
      view.trailingAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant),
      attribute: .trailing,
      relation: .atLeast,
      target: anchor
    )
  }

  @discardableResult
  public func trailing(max anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> Anchor {
    guard let view else { return self }
    return store(
      view.trailingAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant),
      attribute: .trailing,
      relation: .atMost,
      target: anchor
    )
  }

  /// Places the trailing edge before another horizontal anchor using system spacing.
  @discardableResult
  public func trailing(
    systemSpacingBefore anchor: NSLayoutXAxisAnchor,
    multiplier: CGFloat = 1
  ) -> Anchor {
    guard let view else { return self }
    return store(
      anchor.constraint(
        equalToSystemSpacingAfter: view.trailingAnchor,
        multiplier: multiplier
      ),
      attribute: .trailing,
      relation: .equal,
      target: anchor
    )
  }

  // MARK: - Vertical position

  @discardableResult
  public func top(to anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> Anchor {
    guard let view else { return self }
    return store(
      view.topAnchor.constraint(equalTo: anchor, constant: constant),
      attribute: .top,
      relation: .equal,
      target: anchor
    )
  }

  @discardableResult
  public func top(min anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> Anchor {
    guard let view else { return self }
    return store(
      view.topAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant),
      attribute: .top,
      relation: .atLeast,
      target: anchor
    )
  }

  @discardableResult
  public func top(max anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> Anchor {
    guard let view else { return self }
    return store(
      view.topAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant),
      attribute: .top,
      relation: .atMost,
      target: anchor
    )
  }

  /// Places the top edge below another vertical anchor using system spacing.
  @discardableResult
  public func top(
    systemSpacingBelow anchor: NSLayoutYAxisAnchor,
    multiplier: CGFloat = 1
  ) -> Anchor {
    guard let view else { return self }
    return store(
      view.topAnchor.constraint(
        equalToSystemSpacingBelow: anchor,
        multiplier: multiplier
      ),
      attribute: .top,
      relation: .equal,
      target: anchor
    )
  }

  @discardableResult
  public func bottom(to anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> Anchor {
    guard let view else { return self }
    return store(
      view.bottomAnchor.constraint(equalTo: anchor, constant: constant),
      attribute: .bottom,
      relation: .equal,
      target: anchor
    )
  }

  @discardableResult
  public func bottom(min anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> Anchor {
    guard let view else { return self }
    return store(
      view.bottomAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant),
      attribute: .bottom,
      relation: .atLeast,
      target: anchor
    )
  }

  @discardableResult
  public func bottom(max anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> Anchor {
    guard let view else { return self }
    return store(
      view.bottomAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant),
      attribute: .bottom,
      relation: .atMost,
      target: anchor
    )
  }

  /// Places the bottom edge above another vertical anchor using system spacing.
  @discardableResult
  public func bottom(
    systemSpacingAbove anchor: NSLayoutYAxisAnchor,
    multiplier: CGFloat = 1
  ) -> Anchor {
    guard let view else { return self }
    return store(
      anchor.constraint(
        equalToSystemSpacingBelow: view.bottomAnchor,
        multiplier: multiplier
      ),
      attribute: .bottom,
      relation: .equal,
      target: anchor
    )
  }

  // MARK: - Baselines

  @discardableResult
  public func firstBaseline(to anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> Anchor {
    guard let view else { return self }
    return store(
      view.firstBaselineAnchor.constraint(equalTo: anchor, constant: constant),
      attribute: .firstBaseline,
      relation: .equal,
      target: anchor
    )
  }

  @discardableResult
  public func lastBaseline(to anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> Anchor {
    guard let view else { return self }
    return store(
      view.lastBaselineAnchor.constraint(equalTo: anchor, constant: constant),
      attribute: .lastBaseline,
      relation: .equal,
      target: anchor
    )
  }

  // MARK: - Centering

  @discardableResult
  public func centerX(to anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> Anchor {
    guard let view else { return self }
    return store(
      view.centerXAnchor.constraint(equalTo: anchor, constant: constant),
      attribute: .centerX,
      relation: .equal,
      target: anchor
    )
  }

  @discardableResult
  public func centerY(to anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> Anchor {
    guard let view else { return self }
    return store(
      view.centerYAnchor.constraint(equalTo: anchor, constant: constant),
      attribute: .centerY,
      relation: .equal,
      target: anchor
    )
  }

  @discardableResult
  public func centerX(in otherView: UIView, constant: CGFloat = 0) -> Anchor {
    centerX(to: otherView.centerXAnchor, constant: constant)
  }

  @discardableResult
  public func centerX(in layoutGuide: UILayoutGuide, constant: CGFloat = 0) -> Anchor {
    centerX(to: layoutGuide.centerXAnchor, constant: constant)
  }

  @discardableResult
  public func centerY(in otherView: UIView, constant: CGFloat = 0) -> Anchor {
    centerY(to: otherView.centerYAnchor, constant: constant)
  }

  @discardableResult
  public func centerY(in layoutGuide: UILayoutGuide, constant: CGFloat = 0) -> Anchor {
    centerY(to: layoutGuide.centerYAnchor, constant: constant)
  }

  @discardableResult
  public func center(in otherView: UIView, offset: CGPoint = .zero) -> Anchor {
    center(x: otherView.centerXAnchor, y: otherView.centerYAnchor, offset: offset)
  }

  @discardableResult
  public func center(in layoutGuide: UILayoutGuide, offset: CGPoint = .zero) -> Anchor {
    center(x: layoutGuide.centerXAnchor, y: layoutGuide.centerYAnchor, offset: offset)
  }

  @discardableResult
  public func centerInSuperview(offset: CGPoint = .zero) -> Anchor {
    guard let view, let superview = view.superview else {
      assertionFailure("AnchorKit centerInSuperview() requires the view to have a superview.")
      return self
    }
    return center(in: superview, offset: offset)
  }

  // MARK: - Filling

  @discardableResult
  public func fillWidth(of otherView: UIView, inset: CGFloat = 0) -> Anchor {
    fillWidth(
      leading: otherView.leadingAnchor,
      trailing: otherView.trailingAnchor,
      target: otherView,
      inset: inset
    )
  }

  @discardableResult
  public func fillWidth(of layoutGuide: UILayoutGuide, inset: CGFloat = 0) -> Anchor {
    fillWidth(
      leading: layoutGuide.leadingAnchor,
      trailing: layoutGuide.trailingAnchor,
      target: layoutGuide,
      inset: inset
    )
  }

  @discardableResult
  public func fillHeight(of otherView: UIView, inset: CGFloat = 0) -> Anchor {
    fillHeight(
      top: otherView.topAnchor,
      bottom: otherView.bottomAnchor,
      target: otherView,
      inset: inset
    )
  }

  @discardableResult
  public func fillHeight(of layoutGuide: UILayoutGuide, inset: CGFloat = 0) -> Anchor {
    fillHeight(
      top: layoutGuide.topAnchor,
      bottom: layoutGuide.bottomAnchor,
      target: layoutGuide,
      inset: inset
    )
  }

  @discardableResult
  public func fill(
    _ otherView: UIView,
    insets: NSDirectionalEdgeInsets = .zero
  ) -> Anchor {
    fill(
      top: otherView.topAnchor,
      leading: otherView.leadingAnchor,
      bottom: otherView.bottomAnchor,
      trailing: otherView.trailingAnchor,
      target: otherView,
      insets: insets
    )
  }

  @discardableResult
  public func fill(
    _ layoutGuide: UILayoutGuide,
    insets: NSDirectionalEdgeInsets = .zero
  ) -> Anchor {
    fill(
      top: layoutGuide.topAnchor,
      leading: layoutGuide.leadingAnchor,
      bottom: layoutGuide.bottomAnchor,
      trailing: layoutGuide.trailingAnchor,
      target: layoutGuide,
      insets: insets
    )
  }

  @discardableResult
  public func fillSuperview(insets: NSDirectionalEdgeInsets = .zero) -> Anchor {
    guard let view, let superview = view.superview else {
      assertionFailure("AnchorKit fillSuperview() requires the view to have a superview.")
      return self
    }
    return fill(superview, insets: insets)
  }

  // MARK: - Updates

  @discardableResult
  public func widthUpdate(_ constant: CGFloat) -> Anchor {
    update([key(attribute: .width, relation: .equal)], constants: [constant])
  }

  @discardableResult
  public func widthUpdate(min constant: CGFloat) -> Anchor {
    update([key(attribute: .width, relation: .atLeast)], constants: [constant])
  }

  @discardableResult
  public func widthUpdate(max constant: CGFloat) -> Anchor {
    update([key(attribute: .width, relation: .atMost)], constants: [constant])
  }

  @discardableResult
  public func heightUpdate(_ constant: CGFloat) -> Anchor {
    update([key(attribute: .height, relation: .equal)], constants: [constant])
  }

  @discardableResult
  public func heightUpdate(min constant: CGFloat) -> Anchor {
    update([key(attribute: .height, relation: .atLeast)], constants: [constant])
  }

  @discardableResult
  public func heightUpdate(max constant: CGFloat) -> Anchor {
    update([key(attribute: .height, relation: .atMost)], constants: [constant])
  }

  @discardableResult
  public func leadingUpdate(to anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> Anchor {
    update(
      [key(attribute: .leading, relation: .equal, target: anchor)],
      constants: [constant]
    )
  }

  @discardableResult
  public func trailingUpdate(to anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> Anchor {
    update(
      [key(attribute: .trailing, relation: .equal, target: anchor)],
      constants: [constant]
    )
  }

  @discardableResult
  public func topUpdate(to anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> Anchor {
    update(
      [key(attribute: .top, relation: .equal, target: anchor)],
      constants: [constant]
    )
  }

  @discardableResult
  public func bottomUpdate(to anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> Anchor {
    update(
      [key(attribute: .bottom, relation: .equal, target: anchor)],
      constants: [constant]
    )
  }

  @discardableResult
  public func centerUpdate(in otherView: UIView, offset: CGPoint = .zero) -> Anchor {
    update(
      [
        key(attribute: .centerX, relation: .equal, target: otherView.centerXAnchor),
        key(attribute: .centerY, relation: .equal, target: otherView.centerYAnchor),
      ],
      constants: [offset.x, offset.y]
    )
  }

  @discardableResult
  public func centerUpdate(in layoutGuide: UILayoutGuide, offset: CGPoint = .zero) -> Anchor {
    update(
      [
        key(attribute: .centerX, relation: .equal, target: layoutGuide.centerXAnchor),
        key(attribute: .centerY, relation: .equal, target: layoutGuide.centerYAnchor),
      ],
      constants: [offset.x, offset.y]
    )
  }

  @discardableResult
  public func fillWidthUpdate(of otherView: UIView, inset: CGFloat = 0) -> Anchor {
    update(
      [
        key(attribute: .leading, relation: .equal, target: otherView),
        key(attribute: .trailing, relation: .equal, target: otherView),
      ],
      constants: [inset, -inset]
    )
  }

  @discardableResult
  public func fillWidthUpdate(of layoutGuide: UILayoutGuide, inset: CGFloat = 0) -> Anchor {
    update(
      [
        key(attribute: .leading, relation: .equal, target: layoutGuide),
        key(attribute: .trailing, relation: .equal, target: layoutGuide),
      ],
      constants: [inset, -inset]
    )
  }

  @discardableResult
  public func fillHeightUpdate(of otherView: UIView, inset: CGFloat = 0) -> Anchor {
    update(
      [
        key(attribute: .top, relation: .equal, target: otherView),
        key(attribute: .bottom, relation: .equal, target: otherView),
      ],
      constants: [inset, -inset]
    )
  }

  @discardableResult
  public func fillHeightUpdate(of layoutGuide: UILayoutGuide, inset: CGFloat = 0) -> Anchor {
    update(
      [
        key(attribute: .top, relation: .equal, target: layoutGuide),
        key(attribute: .bottom, relation: .equal, target: layoutGuide),
      ],
      constants: [inset, -inset]
    )
  }

  @discardableResult
  public func fillUpdate(
    _ otherView: UIView,
    insets: NSDirectionalEdgeInsets = .zero
  ) -> Anchor {
    updateFill(target: otherView, insets: insets)
  }

  @discardableResult
  public func fillUpdate(
    _ layoutGuide: UILayoutGuide,
    insets: NSDirectionalEdgeInsets = .zero
  ) -> Anchor {
    updateFill(target: layoutGuide, insets: insets)
  }

  @discardableResult
  public func topUpdate(min anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> Anchor {
    update(
      [key(attribute: .top, relation: .atLeast, target: anchor)],
      constants: [constant]
    )
  }

  @discardableResult
  public func bottomUpdate(max anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> Anchor {
    update(
      [key(attribute: .bottom, relation: .atMost, target: anchor)],
      constants: [constant]
    )
  }

  // MARK: - Constraint control

  /// Sets the content-hugging priority of the managed view.
  @discardableResult
  public func hugging(_ priority: UILayoutPriority, for axis: NSLayoutConstraint.Axis) -> Anchor {
    view?.setContentHuggingPriority(priority, for: axis)
    lastAffectedConstraints.removeAll()
    return self
  }

  /// Sets the compression-resistance priority of the managed view.
  @discardableResult
  public func compressionResistance(
    _ priority: UILayoutPriority,
    for axis: NSLayoutConstraint.Axis
  ) -> Anchor {
    view?.setContentCompressionResistancePriority(priority, for: axis)
    lastAffectedConstraints.removeAll()
    return self
  }

  /// Activates every constraint managed by this anchor.
  @discardableResult
  public func activate() -> Anchor {
    NSLayoutConstraint.activate(constraints.filter { !$0.isActive })
    return self
  }

  /// Deactivates every constraint managed by this anchor without forgetting it.
  @discardableResult
  public func deactivate() -> Anchor {
    NSLayoutConstraint.deactivate(constraints.filter(\.isActive))
    return self
  }

  /// Applies a debugging identifier to the constraints from the previous operation.
  @discardableResult
  public func identified(_ identifier: String) -> Anchor {
    guard !lastAffectedConstraints.isEmpty else {
      assertionFailure("AnchorKit identified(_:) requires a preceding constraint operation.")
      return self
    }
    for (index, constraint) in lastAffectedConstraints.enumerated() {
      constraint.identifier =
        lastAffectedConstraints.count == 1
        ? identifier
        : "\(identifier)[\(index)]"
    }
    return self
  }

  func removeAllConstraints() {
    NSLayoutConstraint.deactivate(constraints.filter(\.isActive))
    managedConstraints.removeAll()
    lastAffectedConstraints.removeAll()
  }

  func modifyLastConstraints(_ mutation: (NSLayoutConstraint) -> Void) {
    guard !lastAffectedConstraints.isEmpty else {
      assertionFailure("AnchorKit constraint modifiers require a preceding constraint operation.")
      return
    }
    let activeConstraints = lastAffectedConstraints.filter(\.isActive)
    NSLayoutConstraint.deactivate(activeConstraints)
    lastAffectedConstraints.forEach(mutation)
    NSLayoutConstraint.activate(activeConstraints)
  }

  // MARK: - Private helpers

  private typealias Entry = (key: ConstraintKey, constraint: NSLayoutConstraint)

  private func key(
    attribute: Attribute,
    relation: Relation,
    target: AnyObject? = nil
  ) -> ConstraintKey {
    ConstraintKey(
      attribute: attribute,
      relation: relation,
      target: target.map(ObjectIdentifier.init)
    )
  }

  private func entry(
    _ constraint: NSLayoutConstraint,
    attribute: Attribute,
    relation: Relation,
    target: AnyObject? = nil
  ) -> Entry {
    (key(attribute: attribute, relation: relation, target: target), constraint)
  }

  @discardableResult
  private func store(
    _ constraint: NSLayoutConstraint,
    attribute: Attribute,
    relation: Relation,
    target: AnyObject? = nil
  ) -> Anchor {
    store([entry(constraint, attribute: attribute, relation: relation, target: target)])
  }

  @discardableResult
  private func store(_ entries: [Entry]) -> Anchor {
    let oldConstraints = entries.compactMap { managedConstraints[$0.key] }
    NSLayoutConstraint.deactivate(oldConstraints.filter(\.isActive))

    let newConstraints = entries.map(\.constraint)
    NSLayoutConstraint.activate(newConstraints)

    for entry in entries {
      managedConstraints[entry.key] = entry.constraint
    }
    lastAffectedConstraints = newConstraints
    return self
  }

  @discardableResult
  private func update(_ keys: [ConstraintKey], constants: [CGFloat]) -> Anchor {
    precondition(keys.count == constants.count)
    let matches = keys.compactMap { managedConstraints[$0] }
    guard matches.count == keys.count else {
      assertionFailure("AnchorKit cannot update a constraint that it does not manage.")
      lastAffectedConstraints = matches
      return self
    }

    for (constraint, constant) in zip(matches, constants) {
      constraint.constant = constant
    }
    lastAffectedConstraints = matches
    return self
  }

  @discardableResult
  private func updateFill(
    target: AnyObject,
    insets: NSDirectionalEdgeInsets
  ) -> Anchor {
    update(
      [
        key(attribute: .top, relation: .equal, target: target),
        key(attribute: .leading, relation: .equal, target: target),
        key(attribute: .bottom, relation: .equal, target: target),
        key(attribute: .trailing, relation: .equal, target: target),
      ],
      constants: [insets.top, insets.leading, -insets.bottom, -insets.trailing]
    )
  }

  @discardableResult
  private func center(
    x xAnchor: NSLayoutXAxisAnchor,
    y yAnchor: NSLayoutYAxisAnchor,
    offset: CGPoint
  ) -> Anchor {
    guard let view else { return self }
    return store([
      entry(
        view.centerXAnchor.constraint(equalTo: xAnchor, constant: offset.x),
        attribute: .centerX,
        relation: .equal,
        target: xAnchor
      ),
      entry(
        view.centerYAnchor.constraint(equalTo: yAnchor, constant: offset.y),
        attribute: .centerY,
        relation: .equal,
        target: yAnchor
      ),
    ])
  }

  @discardableResult
  private func fillWidth(
    leading: NSLayoutXAxisAnchor,
    trailing: NSLayoutXAxisAnchor,
    target: AnyObject,
    inset: CGFloat
  ) -> Anchor {
    guard let view else { return self }
    return store([
      entry(
        view.leadingAnchor.constraint(equalTo: leading, constant: inset),
        attribute: .leading,
        relation: .equal,
        target: target
      ),
      entry(
        view.trailingAnchor.constraint(equalTo: trailing, constant: -inset),
        attribute: .trailing,
        relation: .equal,
        target: target
      ),
    ])
  }

  @discardableResult
  private func fillHeight(
    top: NSLayoutYAxisAnchor,
    bottom: NSLayoutYAxisAnchor,
    target: AnyObject,
    inset: CGFloat
  ) -> Anchor {
    guard let view else { return self }
    return store([
      entry(
        view.topAnchor.constraint(equalTo: top, constant: inset),
        attribute: .top,
        relation: .equal,
        target: target
      ),
      entry(
        view.bottomAnchor.constraint(equalTo: bottom, constant: -inset),
        attribute: .bottom,
        relation: .equal,
        target: target
      ),
    ])
  }

  @discardableResult
  private func fill(
    top: NSLayoutYAxisAnchor,
    leading: NSLayoutXAxisAnchor,
    bottom: NSLayoutYAxisAnchor,
    trailing: NSLayoutXAxisAnchor,
    target: AnyObject,
    insets: NSDirectionalEdgeInsets
  ) -> Anchor {
    guard let view else { return self }
    return store([
      entry(
        view.topAnchor.constraint(equalTo: top, constant: insets.top),
        attribute: .top,
        relation: .equal,
        target: target
      ),
      entry(
        view.leadingAnchor.constraint(equalTo: leading, constant: insets.leading),
        attribute: .leading,
        relation: .equal,
        target: target
      ),
      entry(
        view.bottomAnchor.constraint(equalTo: bottom, constant: -insets.bottom),
        attribute: .bottom,
        relation: .equal,
        target: target
      ),
      entry(
        view.trailingAnchor.constraint(equalTo: trailing, constant: -insets.trailing),
        attribute: .trailing,
        relation: .equal,
        target: target
      ),
    ])
  }
}
