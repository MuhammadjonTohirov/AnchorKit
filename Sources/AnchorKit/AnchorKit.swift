//
//  AnchorKit.swift
//  AnchorKit
//
//  Created by Muhammad on 04/28/25.
//

import Foundation
import SwiftUI
import UIKit

// MARK: - AnchorManager Core

public class AnchorManager {
    @MainActor
    public weak var view: UIView?
    
    // Store constraints for updating later
    private var constraints: [NSLayoutConstraint] = []
    
    @MainActor
    public  init(view: UIView) {
        self.view = view
        self.view?.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - Standard Constraints
    
    @discardableResult
    @MainActor
    public  func top(to anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = .required) -> Self {
        if let constraint = view?.topAnchor.constraint(equalTo: anchor, constant: constant) {
            constraint.priority = priority
            constraint.isActive = true
            constraints.append(constraint)
        }
        return self
    }
    
    @discardableResult
    @MainActor
    public  func bottom(to anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = .required) -> Self {
        if let constraint = view?.bottomAnchor.constraint(equalTo: anchor, constant: -constant) {
            constraint.priority = priority
            constraint.isActive = true
            constraints.append(constraint)
        }
        return self
    }
    
    @discardableResult
    @MainActor
    public  func leading(to anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = .required) -> Self {
        if let constraint = view?.leadingAnchor.constraint(equalTo: anchor, constant: constant) {
            constraint.priority = priority
            constraint.isActive = true
            constraints.append(constraint)
        }
        return self
    }
    
    @discardableResult
    @MainActor
    public  func trailing(to anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = .required) -> Self {
        if let constraint = view?.trailingAnchor.constraint(equalTo: anchor, constant: -constant) {
            constraint.priority = priority
            constraint.isActive = true
            constraints.append(constraint)
        }
        return self
    }
    
    @discardableResult
    @MainActor
    public  func width(_ constant: CGFloat, priority: UILayoutPriority = .required) -> Self {
        if let constraint = view?.widthAnchor.constraint(equalToConstant: constant) {
            constraint.priority = priority
            constraint.isActive = true
            constraints.append(constraint)
        }
        return self
    }
    
    @discardableResult
    @MainActor
    public  func height(_ constant: CGFloat, priority: UILayoutPriority = .required) -> Self {
        if let constraint = view?.heightAnchor.constraint(equalToConstant: constant) {
            constraint.priority = priority
            constraint.isActive = true
            constraints.append(constraint)
        }
        return self
    }
    
    @discardableResult
    @MainActor
    public  func centerX(to anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = .required) -> Self {
        if let constraint = view?.centerXAnchor.constraint(equalTo: anchor, constant: constant) {
            constraint.priority = priority
            constraint.isActive = true
            constraints.append(constraint)
        }
        return self
    }
    
    @discardableResult
    @MainActor
    public  func centerY(to anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = .required) -> Self {
        if let constraint = view?.centerYAnchor.constraint(equalTo: anchor, constant: constant) {
            constraint.priority = priority
            constraint.isActive = true
            constraints.append(constraint)
        }
        return self
    }
    
    // MARK: - Greater Than Constraints
    
    @discardableResult
    @MainActor
    public  func top(min anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = .required) -> Self {
        if let constraint = view?.topAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant) {
            constraint.priority = priority
            constraint.isActive = true
            constraints.append(constraint)
        }
        return self
    }
    
    @discardableResult
    @MainActor
    public  func bottom(min anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = .required) -> Self {
        if let constraint = view?.bottomAnchor.constraint(greaterThanOrEqualTo: anchor, constant: -constant) {
            constraint.priority = priority
            constraint.isActive = true
            constraints.append(constraint)
        }
        return self
    }
    
    @discardableResult
    @MainActor
    public  func leading(min anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = .required) -> Self {
        if let constraint = view?.leadingAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant) {
            constraint.priority = priority
            constraint.isActive = true
            constraints.append(constraint)
        }
        return self
    }
    
    @discardableResult
    @MainActor
    public  func trailing(min anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = .required) -> Self {
        if let constraint = view?.trailingAnchor.constraint(greaterThanOrEqualTo: anchor, constant: -constant) {
            constraint.priority = priority
            constraint.isActive = true
            constraints.append(constraint)
        }
        return self
    }
    
    @discardableResult
    @MainActor
    public  func width(min constant: CGFloat, priority: UILayoutPriority = .required) -> Self {
        if let constraint = view?.widthAnchor.constraint(greaterThanOrEqualToConstant: constant) {
            constraint.priority = priority
            constraint.isActive = true
            constraints.append(constraint)
        }
        return self
    }
    
    @discardableResult
    @MainActor
    public  func height(min constant: CGFloat, priority: UILayoutPriority = .required) -> Self {
        if let constraint = view?.heightAnchor.constraint(greaterThanOrEqualToConstant: constant) {
            constraint.priority = priority
            constraint.isActive = true
            constraints.append(constraint)
        }
        return self
    }
    
    // MARK: - Less Than Constraints
    
    @discardableResult
    @MainActor
    public  func top(max anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = .required) -> Self {
        if let constraint = view?.topAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant) {
            constraint.priority = priority
            constraint.isActive = true
            constraints.append(constraint)
        }
        return self
    }
    
    @discardableResult
    @MainActor
    public  func bottom(max anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = .required) -> Self {
        if let constraint = view?.bottomAnchor.constraint(lessThanOrEqualTo: anchor, constant: -constant) {
            constraint.priority = priority
            constraint.isActive = true
            constraints.append(constraint)
        }
        return self
    }
    
    @discardableResult
    @MainActor
    public  func leading(max anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = .required) -> Self {
        if let constraint = view?.leadingAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant) {
            constraint.priority = priority
            constraint.isActive = true
            constraints.append(constraint)
        }
        return self
    }
    
    @discardableResult
    @MainActor
    public  func trailing(max anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = .required) -> Self {
        if let constraint = view?.trailingAnchor.constraint(lessThanOrEqualTo: anchor, constant: -constant) {
            constraint.priority = priority
            constraint.isActive = true
            constraints.append(constraint)
        }
        return self
    }
    
    @discardableResult
    @MainActor
    public  func width(max constant: CGFloat, priority: UILayoutPriority = .required) -> Self {
        if let constraint = view?.widthAnchor.constraint(lessThanOrEqualToConstant: constant) {
            constraint.priority = priority
            constraint.isActive = true
            constraints.append(constraint)
        }
        return self
    }
    
    @discardableResult
    @MainActor
    public  func height(max constant: CGFloat, priority: UILayoutPriority = .required) -> Self {
        if let constraint = view?.heightAnchor.constraint(lessThanOrEqualToConstant: constant) {
            constraint.priority = priority
            constraint.isActive = true
            constraints.append(constraint)
        }
        return self
    }
    
    // MARK: - Dimension Constraints
    
    @discardableResult
    @MainActor
    public  func width(equalTo anchor: NSLayoutDimension, multiplier: CGFloat = 1, constant: CGFloat = 0, priority: UILayoutPriority = .required) -> Self {
        if let constraint = view?.widthAnchor.constraint(equalTo: anchor, multiplier: multiplier, constant: constant) {
            constraint.priority = priority
            constraint.isActive = true
            constraints.append(constraint)
        }
        return self
    }
    
    @discardableResult
    @MainActor
    public  func height(equalTo anchor: NSLayoutDimension, multiplier: CGFloat = 1, constant: CGFloat = 0, priority: UILayoutPriority = .required) -> Self {
        if let constraint = view?.heightAnchor.constraint(equalTo: anchor, multiplier: multiplier, constant: constant) {
            constraint.priority = priority
            constraint.isActive = true
            constraints.append(constraint)
        }
        return self
    }
    
    @discardableResult
    @MainActor
    public  func width(min anchor: NSLayoutDimension, multiplier: CGFloat = 1, constant: CGFloat = 0, priority: UILayoutPriority = .required) -> Self {
        if let constraint = view?.widthAnchor.constraint(greaterThanOrEqualTo: anchor, multiplier: multiplier, constant: constant) {
            constraint.priority = priority
            constraint.isActive = true
            constraints.append(constraint)
        }
        return self
    }
    
    @discardableResult
    @MainActor
    public  func height(min anchor: NSLayoutDimension, multiplier: CGFloat = 1, constant: CGFloat = 0, priority: UILayoutPriority = .required) -> Self {
        if let constraint = view?.heightAnchor.constraint(greaterThanOrEqualTo: anchor, multiplier: multiplier, constant: constant) {
            constraint.priority = priority
            constraint.isActive = true
            constraints.append(constraint)
        }
        return self
    }
    
    @discardableResult
    @MainActor
    public  func width(max anchor: NSLayoutDimension, multiplier: CGFloat = 1, constant: CGFloat = 0, priority: UILayoutPriority = .required) -> Self {
        if let constraint = view?.widthAnchor.constraint(lessThanOrEqualTo: anchor, multiplier: multiplier, constant: constant) {
            constraint.priority = priority
            constraint.isActive = true
            constraints.append(constraint)
        }
        return self
    }
    
    @discardableResult
    @MainActor
    public  func height(max anchor: NSLayoutDimension, multiplier: CGFloat = 1, constant: CGFloat = 0, priority: UILayoutPriority = .required) -> Self {
        if let constraint = view?.heightAnchor.constraint(lessThanOrEqualTo: anchor, multiplier: multiplier, constant: constant) {
            constraint.priority = priority
            constraint.isActive = true
            constraints.append(constraint)
        }
        return self
    }
    
    // MARK: - Special Constraints
    
    @discardableResult
    @MainActor
    public  func aspectRatio(_ ratio: CGFloat, priority: UILayoutPriority = .required) -> Self {
        if let view = view {
            let constraint = view.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: ratio)
            constraint.priority = priority
            constraint.isActive = true
            constraints.append(constraint)
        }
        return self
    }
    
    // MARK: - Layout Priority
    
    @discardableResult
    @MainActor
    public  func hugging(priority: UILayoutPriority, for axis: NSLayoutConstraint.Axis) -> Self {
        view?.setContentHuggingPriority(priority, for: axis)
        return self
    }
    
    @discardableResult
    @MainActor
    public  func compression(priority: UILayoutPriority, for axis: NSLayoutConstraint.Axis) -> Self {
        view?.setContentCompressionResistancePriority(priority, for: axis)
        return self
    }
    
    // MARK: - Constraint Management
    
    @discardableResult
    @MainActor
    public  func deactivate() -> Self {
        for constraint in constraints {
            constraint.isActive = false
        }
        return self
    }
    
    @discardableResult
    @MainActor
    public  func activate() -> Self {
        for constraint in constraints {
            constraint.isActive = true
        }
        return self
    }
    
    @discardableResult
    @MainActor
    public  func identify(_ identifier: String) -> Self {
        for constraint in constraints {
            constraint.identifier = identifier
        }
        return self
    }
    
    @discardableResult
    @MainActor
    public  func update(_ closure: ([NSLayoutConstraint]) -> Void) -> Self {
        closure(constraints)
        return self
    }
    
    // MARK: - Debug
    
    @discardableResult
    @MainActor
    public  func debug(_ color: UIColor = .red, alpha: CGFloat = 0.2) -> Self {
        view?.layer.borderColor = color.cgColor
        view?.layer.borderWidth = 1
        view?.backgroundColor = color.withAlphaComponent(alpha)
        return self
    }
}

// MARK: - AnchorManager Extensions

public extension AnchorManager {
    // MARK: - Edge Constraints
    
    @discardableResult
    @MainActor
    func edges(to view: UIView, useSafeArea: Bool = false, insets: UIEdgeInsets = .zero) -> Self {
        let topAnchor = useSafeArea ? view.safeAreaLayoutGuide.topAnchor : view.topAnchor
        let bottomAnchor = useSafeArea ? view.safeAreaLayoutGuide.bottomAnchor : view.bottomAnchor
        let leadingAnchor = useSafeArea ? view.safeAreaLayoutGuide.leadingAnchor : view.leadingAnchor
        let trailingAnchor = useSafeArea ? view.safeAreaLayoutGuide.trailingAnchor : view.trailingAnchor
        
        return self
            .top(to: topAnchor, constant: insets.top)
            .bottom(to: bottomAnchor, constant: insets.bottom)
            .leading(to: leadingAnchor, constant: insets.left)
            .trailing(to: trailingAnchor, constant: insets.right)
    }
    
    @discardableResult
    @MainActor
    func fillSuperview(useSafeArea: Bool = false, insets: UIEdgeInsets = .zero) -> Self {
        guard let superview = view?.superview else { return self }
        return edges(to: superview, useSafeArea: useSafeArea, insets: insets)
    }
    
    @discardableResult
    @MainActor
    func fillWidth(of view: UIView, inset: CGFloat = 0) -> Self {
        self
            .leading(to: view.leadingAnchor, constant: inset)
            .trailing(to: view.trailingAnchor, constant: inset)
        return self
    }
    
    @discardableResult
    @MainActor
    func fillHeight(of view: UIView, inset: CGFloat = 0) -> Self {
        self
            .top(to: view.topAnchor, constant: inset)
            .bottom(to: view.bottomAnchor, constant: inset)
        return self
    }
    
    // MARK: - Center Constraints
    
    @discardableResult
    @MainActor
    func centerInSuperview(offset: CGPoint = .zero) -> Self {
        guard let superview = view?.superview else { return self }
        
        return self
            .centerX(to: superview.centerXAnchor, constant: offset.x)
            .centerY(to: superview.centerYAnchor, constant: offset.y)
    }
    
    @discardableResult
    @MainActor
    func centerX(in view: UIView, offset: CGFloat = 0) -> Self {
        return centerX(to: view.centerXAnchor, constant: offset)
    }
    
    @discardableResult
    @MainActor
    func centerY(in view: UIView, offset: CGFloat = 0) -> Self {
        return centerY(to: view.centerYAnchor, constant: offset)
    }
    
    // MARK: - Size Constraints
    
    @discardableResult
    @MainActor
    func size(equalTo view: UIView, multiplier: CGFloat = 1) -> Self {
        self
            .width(equalTo: view.widthAnchor, multiplier: multiplier)
            .height(equalTo: view.heightAnchor, multiplier: multiplier)
        return self
    }
    
    @discardableResult
    @MainActor
    func size(_ size: CGSize) -> Self {
        self
            .width(size.width)
            .height(size.height)
        return self
    }
    
    @discardableResult
    @MainActor
    func size(_ size: CGFloat) -> Self {
        self
            .width(size)
            .height(size)
        return self
    }
    
    @discardableResult
    @MainActor
    func matchWidth(of view: UIView, multiplier: CGFloat = 1, constant: CGFloat = 0) -> Self {
        return width(equalTo: view.widthAnchor, multiplier: multiplier, constant: constant)
    }
    
    @discardableResult
    @MainActor
    func matchHeight(of view: UIView, multiplier: CGFloat = 1, constant: CGFloat = 0) -> Self {
        return height(equalTo: view.heightAnchor, multiplier: multiplier, constant: constant)
    }
    
    // MARK: - Stack View Preparation
    
    @discardableResult
    @MainActor
    func prepareForStackView() -> Self {
        self
            .hugging(priority: .defaultLow, for: .horizontal)
            .hugging(priority: .defaultLow, for: .vertical)
            .compression(priority: .defaultHigh, for: .horizontal)
            .compression(priority: .defaultHigh, for: .vertical)
        return self
    }
}

// MARK: - UIView Extension for AnchorManager

@MainActor private var anchorManagerKey: UInt8 = 0

extension UIView {
    @MainActor
    public  var anchor: AnchorManager {
        if let manager = objc_getAssociatedObject(self, &anchorManagerKey) as? AnchorManager {
            return manager
        }
        
        let manager = AnchorManager(view: self)
        objc_setAssociatedObject(self, &anchorManagerKey, manager, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        // Add cleanup on deinit
        self.addDeinitOperator { [weak self] in
            self?.releaseAnchorManager()
        }
        
        return manager
    }
    
    fileprivate func releaseAnchorManager() {
        if let manager = objc_getAssociatedObject(self, &anchorManagerKey) as? AnchorManager {
            objc_removeAssociatedObjects(manager)
        }
        objc_setAssociatedObject(self, &anchorManagerKey, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    @MainActor
    public  func clearConstraints() {
        self.constraints.forEach { $0.isActive = false }
        self.releaseAnchorManager()
    }
}

// MARK: - Memory Management Helper

extension NSObject {
    fileprivate func addDeinitOperator(_ operation: @escaping () -> Void) {
        let deinitObject = DeinitObserver(operation: operation)
        objc_setAssociatedObject(self, UUID().uuidString, deinitObject, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}

fileprivate class DeinitObserver {
    let operation: () -> Void
    
    init(operation: @escaping () -> Void) {
        self.operation = operation
    }
    
    deinit {
        operation()
    }
}

// MARK: - AnchorGroup for Managing Multiple Anchors

public class AnchorGroup {
    private var managers: [AnchorManager] = []
    
    @discardableResult
    @MainActor
    public  func add(_ manager: AnchorManager) -> Self {
        managers.append(manager)
        return self
    }
    
    @discardableResult
    @MainActor
    public  func deactivate() -> Self {
        managers.forEach { $0.deactivate() }
        return self
    }
    
    @discardableResult
    @MainActor
    public  func activate() -> Self {
        managers.forEach { $0.activate() }
        return self
    }
    
    @discardableResult
    @MainActor
    public  func identify(_ identifier: String) -> Self {
        managers.forEach { $0.identify(identifier) }
        return self
    }
}

public extension UIView {
    static var anchorGroup: AnchorGroup {
        return AnchorGroup()
    }
}
