import UIKit
import XCTest

@testable import AnchorKit

@MainActor
final class AnchorKitTests: XCTestCase {
  func testAccessingAnchorDisablesAutoresizingMaskTranslation() {
    let view = UIView()

    _ = view.anchor

    XCTAssertFalse(view.translatesAutoresizingMaskIntoConstraints)
  }

  func testReplacingConstraintDeactivatesPreviousConstraint() {
    let view = UIView()
    let manager = view.anchor.width(100)
    let previous = tryUnwrap(manager.lastConstraints.first)

    manager.width(200)
    let replacement = tryUnwrap(manager.lastConstraints.first)

    XCTAssertFalse(previous.isActive)
    XCTAssertTrue(replacement.isActive)
    XCTAssertEqual(replacement.constant, 200)
    XCTAssertEqual(manager.constraints.count, 1)
  }

  func testPriorityAppliesToEveryConstraintInCompoundOperation() {
    let container = UIView()
    let child = UIView()
    container.addSubview(child)

    let manager = child.anchor
      .fillWidth(of: container, inset: 16)
      .priority(.high)

    XCTAssertEqual(manager.lastConstraints.count, 2)
    XCTAssertTrue(manager.lastConstraints.allSatisfy(\.isActive))
    XCTAssertTrue(
      manager.lastConstraints.allSatisfy {
        $0.priority == UILayoutPriority(999)
      }
    )
  }

  func testPriorityCanMoveBetweenRequiredAndOptional() {
    let view = UIView()
    let manager = view.anchor.width(100)

    manager.priority(.low)
    XCTAssertEqual(manager.lastConstraints.first?.priority, .defaultLow)
    XCTAssertTrue(manager.lastConstraints.first?.isActive == true)

    manager.priority(.required)
    XCTAssertEqual(manager.lastConstraints.first?.priority, .required)
    XCTAssertTrue(manager.lastConstraints.first?.isActive == true)
  }

  func testFillWidthUpdateSurvivesLayoutChanges() {
    let container = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 480))
    let child = UIView()
    container.addSubview(child)

    let manager = child.anchor
      .fillWidth(of: container, inset: 20)
      .height(40)
    container.layoutIfNeeded()

    manager.fillWidthUpdate(of: container, inset: 8)

    XCTAssertEqual(Set(manager.lastConstraints.map(\.constant)), Set([8, -8]))
  }

  func testClearConstraintsOnlyRemovesAnchorKitConstraints() {
    let container = UIView()
    let child = UIView()
    let sibling = UIView()
    container.addSubview(child)
    container.addSubview(sibling)
    sibling.translatesAutoresizingMaskIntoConstraints = false

    let unrelated = sibling.leadingAnchor.constraint(equalTo: container.leadingAnchor)
    unrelated.isActive = true
    let managed = child.anchor.fillWidth(of: container).lastConstraints

    child.clearConstraints()

    XCTAssertTrue(unrelated.isActive)
    XCTAssertTrue(managed.allSatisfy { !$0.isActive })
    XCTAssertTrue(child.anchor.constraints.isEmpty)
  }

  func testLayoutGuideAndDirectionalInsetsAreSupported() {
    let container = UIView()
    let child = UIView()
    container.addSubview(child)

    let insets = NSDirectionalEdgeInsets(top: 1, leading: 2, bottom: 3, trailing: 4)
    let manager = child.anchor.fill(container.safeAreaLayoutGuide, insets: insets)

    XCTAssertEqual(manager.lastConstraints.count, 4)
    XCTAssertEqual(Set(manager.lastConstraints.map(\.constant)), Set([1, 2, -3, -4]))
    XCTAssertTrue(manager.lastConstraints.allSatisfy(\.isActive))
  }

  func testCompleteFillCanBeUpdated() {
    let container = UIView()
    let child = UIView()
    container.addSubview(child)

    let manager = child.anchor.fill(container)
    let updatedInsets = NSDirectionalEdgeInsets(
      top: 5,
      leading: 6,
      bottom: 7,
      trailing: 8
    )

    manager.fillUpdate(container, insets: updatedInsets)

    XCTAssertEqual(Set(manager.lastConstraints.map(\.constant)), Set([5, 6, -7, -8]))
  }

  func testRelativeDimensionsBaselinesAndIntrinsicPriorities() {
    let container = UIView()
    let child = UILabel()
    let peer = UILabel()
    container.addSubview(child)
    container.addSubview(peer)

    let manager = child.anchor
      .width(min: container.widthAnchor, multiplier: 0.5)
      .height(max: container.heightAnchor, multiplier: 0.75)
      .firstBaseline(to: peer.firstBaselineAnchor)
      .hugging(.defaultHigh, for: .horizontal)
      .compressionResistance(.required, for: .vertical)

    XCTAssertEqual(manager.constraints.count, 3)
    XCTAssertEqual(child.contentHuggingPriority(for: .horizontal), .defaultHigh)
    XCTAssertEqual(child.contentCompressionResistancePriority(for: .vertical), .required)
  }

  func testSystemSpacingConstraintsAreManaged() {
    let container = UIView()
    let first = UIView()
    let second = UIView()
    container.addSubview(first)
    container.addSubview(second)

    let manager = second.anchor
      .leading(systemSpacingAfter: first.trailingAnchor)
      .top(systemSpacingBelow: first.bottomAnchor)

    XCTAssertEqual(manager.constraints.count, 2)
    XCTAssertTrue(manager.constraints.allSatisfy(\.isActive))
  }

  func testDeactivateAndActivateControlManagedConstraints() {
    let view = UIView()
    let manager = view.anchor.size(width: 80, height: 40)

    manager.deactivate()
    XCTAssertTrue(manager.constraints.allSatisfy { !$0.isActive })

    manager.activate()
    XCTAssertTrue(manager.constraints.allSatisfy(\.isActive))
  }

  func testIdentifierAppliesToWholeGroup() {
    let container = UIView()
    let child = UIView()
    container.addSubview(child)

    let manager = child.anchor.fillWidth(of: container).identified("card.width")

    XCTAssertEqual(
      Set(manager.lastConstraints.compactMap(\.identifier)),
      Set(["card.width[0]", "card.width[1]"])
    )
  }

  private func tryUnwrap<T>(
    _ value: T?,
    file: StaticString = #filePath,
    line: UInt = #line
  ) -> T {
    guard let value else {
      XCTFail("Expected a non-nil value", file: file, line: line)
      fatalError("Expected a non-nil value")
    }
    return value
  }
}
