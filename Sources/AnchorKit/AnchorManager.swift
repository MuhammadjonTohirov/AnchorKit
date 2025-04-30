//
//  AnchorKit.swift
//  AnchorKit
//
//  Created by Muhammadjon on 04/28/25.
//

import Foundation
import SwiftUI
import UIKit

// MARK: - AnchorManager Core

public class AnchorManager {
    @MainActor
    public weak var view: UIView?
    
    // Store constraints for updating later
    private(set) var constraints: [NSLayoutConstraint] = []

    @MainActor
    public init(view: UIView) {
        self.view = view
        self.view?.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - Standard Constraints
    
    @discardableResult
    @MainActor
    public func top(to anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = .required) -> Self {
        if let constraint = view?.topAnchor.constraint(equalTo: anchor, constant: constant) {
            constraint.priority = priority
            constraint.isActive = true
            constraints.append(constraint)
        }
        return self
    }
    
    @discardableResult
    @MainActor
    public func bottom(to anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = .required) -> Self {
        if let constraint = view?.bottomAnchor.constraint(equalTo: anchor, constant: -constant) {
            constraint.priority = priority
            constraint.isActive = true
            constraints.append(constraint)
        }
        return self
    }
    
    @discardableResult
    @MainActor
    public func leading(to anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = .required) -> Self {
        if let constraint = view?.leadingAnchor.constraint(equalTo: anchor, constant: constant) {
            constraint.priority = priority
            constraint.isActive = true
            constraints.append(constraint)
        }
        return self
    }
    
    @discardableResult
    @MainActor
    public func trailing(to anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = .required) -> Self {
        if let constraint = view?.trailingAnchor.constraint(equalTo: anchor, constant: -constant) {
            constraint.priority = priority
            constraint.isActive = true
            constraints.append(constraint)
        }
        return self
    }
    
    @discardableResult
    @MainActor
    public func width(_ constant: CGFloat, priority: UILayoutPriority = .required) -> Self {
        if let constraint = view?.widthAnchor.constraint(equalToConstant: constant) {
            constraint.priority = priority
            constraint.isActive = true
            constraints.append(constraint)
        }
        return self
    }
    
    @discardableResult
    @MainActor
    public func height(_ constant: CGFloat, priority: UILayoutPriority = .required) -> Self {
        if let constraint = view?.heightAnchor.constraint(equalToConstant: constant) {
            constraint.priority = priority
            constraint.isActive = true
            constraints.append(constraint)
        }
        return self
    }
    
    @discardableResult
    @MainActor
    public func centerX(to anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = .required) -> Self {
        if let constraint = view?.centerXAnchor.constraint(equalTo: anchor, constant: constant) {
            constraint.priority = priority
            constraint.isActive = true
            constraints.append(constraint)
        }
        return self
    }
    
    @discardableResult
    @MainActor
    public func centerY(to anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = .required) -> Self {
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
    public func top(min anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = .required) -> Self {
        if let constraint = view?.topAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant) {
            constraint.priority = priority
            constraint.isActive = true
            constraints.append(constraint)
        }
        return self
    }
    
    @discardableResult
    @MainActor
    public func bottom(min anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = .required) -> Self {
        if let constraint = view?.bottomAnchor.constraint(greaterThanOrEqualTo: anchor, constant: -constant) {
            constraint.priority = priority
            constraint.isActive = true
            constraints.append(constraint)
        }
        return self
    }
    
    @discardableResult
    @MainActor
    public func leading(min anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = .required) -> Self {
        if let constraint = view?.leadingAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant) {
            constraint.priority = priority
            constraint.isActive = true
            constraints.append(constraint)
        }
        return self
    }
    
    @discardableResult
    @MainActor
    public func trailing(min anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = .required) -> Self {
        if let constraint = view?.trailingAnchor.constraint(greaterThanOrEqualTo: anchor, constant: -constant) {
            constraint.priority = priority
            constraint.isActive = true
            constraints.append(constraint)
        }
        return self
    }
    
    @discardableResult
    @MainActor
    public func width(min constant: CGFloat, priority: UILayoutPriority = .required) -> Self {
        if let constraint = view?.widthAnchor.constraint(greaterThanOrEqualToConstant: constant) {
            constraint.priority = priority
            constraint.isActive = true
            constraints.append(constraint)
        }
        return self
    }
    
    @discardableResult
    @MainActor
    public func height(min constant: CGFloat, priority: UILayoutPriority = .required) -> Self {
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
    public func top(max anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = .required) -> Self {
        if let constraint = view?.topAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant) {
            constraint.priority = priority
            constraint.isActive = true
            constraints.append(constraint)
        }
        return self
    }
    
    @discardableResult
    @MainActor
    public func bottom(max anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = .required) -> Self {
        if let constraint = view?.bottomAnchor.constraint(lessThanOrEqualTo: anchor, constant: -constant) {
            constraint.priority = priority
            constraint.isActive = true
            constraints.append(constraint)
        }
        return self
    }
    
    @discardableResult
    @MainActor
    public func leading(max anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = .required) -> Self {
        if let constraint = view?.leadingAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant) {
            constraint.priority = priority
            constraint.isActive = true
            constraints.append(constraint)
        }
        return self
    }
    
    @discardableResult
    @MainActor
    public func trailing(max anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0, priority: UILayoutPriority = .required) -> Self {
        if let constraint = view?.trailingAnchor.constraint(lessThanOrEqualTo: anchor, constant: -constant) {
            constraint.priority = priority
            constraint.isActive = true
            constraints.append(constraint)
        }
        return self
    }
    
    @discardableResult
    @MainActor
    public func width(max constant: CGFloat, priority: UILayoutPriority = .required) -> Self {
        if let constraint = view?.widthAnchor.constraint(lessThanOrEqualToConstant: constant) {
            constraint.priority = priority
            constraint.isActive = true
            constraints.append(constraint)
        }
        return self
    }
    
    @discardableResult
    @MainActor
    public func height(max constant: CGFloat, priority: UILayoutPriority = .required) -> Self {
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
    public func width(equalTo anchor: NSLayoutDimension, multiplier: CGFloat = 1, constant: CGFloat = 0, priority: UILayoutPriority = .required) -> Self {
        if let constraint = view?.widthAnchor.constraint(equalTo: anchor, multiplier: multiplier, constant: constant) {
            constraint.priority = priority
            constraint.isActive = true
            constraints.append(constraint)
        }
        return self
    }
    
    @discardableResult
    @MainActor
    public func height(equalTo anchor: NSLayoutDimension, multiplier: CGFloat = 1, constant: CGFloat = 0, priority: UILayoutPriority = .required) -> Self {
        if let constraint = view?.heightAnchor.constraint(equalTo: anchor, multiplier: multiplier, constant: constant) {
            constraint.priority = priority
            constraint.isActive = true
            constraints.append(constraint)
        }
        return self
    }
    
    @discardableResult
    @MainActor
    public func width(min anchor: NSLayoutDimension, multiplier: CGFloat = 1, constant: CGFloat = 0, priority: UILayoutPriority = .required) -> Self {
        if let constraint = view?.widthAnchor.constraint(greaterThanOrEqualTo: anchor, multiplier: multiplier, constant: constant) {
            constraint.priority = priority
            constraint.isActive = true
            constraints.append(constraint)
        }
        return self
    }
    
    @discardableResult
    @MainActor
    public func height(min anchor: NSLayoutDimension, multiplier: CGFloat = 1, constant: CGFloat = 0, priority: UILayoutPriority = .required) -> Self {
        if let constraint = view?.heightAnchor.constraint(greaterThanOrEqualTo: anchor, multiplier: multiplier, constant: constant) {
            constraint.priority = priority
            constraint.isActive = true
            constraints.append(constraint)
        }
        return self
    }
    
    @discardableResult
    @MainActor
    public func width(max anchor: NSLayoutDimension, multiplier: CGFloat = 1, constant: CGFloat = 0, priority: UILayoutPriority = .required) -> Self {
        if let constraint = view?.widthAnchor.constraint(lessThanOrEqualTo: anchor, multiplier: multiplier, constant: constant) {
            constraint.priority = priority
            constraint.isActive = true
            constraints.append(constraint)
        }
        return self
    }
    
    @discardableResult
    @MainActor
    public func height(max anchor: NSLayoutDimension, multiplier: CGFloat = 1, constant: CGFloat = 0, priority: UILayoutPriority = .required) -> Self {
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
    public func aspectRatio(_ ratio: CGFloat, priority: UILayoutPriority = .required) -> Self {
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
    public func hugging(priority: UILayoutPriority, for axis: NSLayoutConstraint.Axis) -> Self {
        view?.setContentHuggingPriority(priority, for: axis)
        return self
    }
    
    @discardableResult
    @MainActor
    public func compression(priority: UILayoutPriority, for axis: NSLayoutConstraint.Axis) -> Self {
        view?.setContentCompressionResistancePriority(priority, for: axis)
        return self
    }
    
    // MARK: - Constraint Management
    
    @discardableResult
    @MainActor
    public func deactivate() -> Self {
       for constraint in constraints {
            constraint.isActive = false
        }
        return self
    }
    
    @discardableResult
    @MainActor
    public func activate() -> Self {
       for constraint in constraints {
            constraint.isActive = true
        }
        return self
    }
    
    @discardableResult
    @MainActor
    public func identify(_ identifier: String) -> Self {
       for constraint in constraints {
            constraint.identifier = identifier
        }
        return self
    }
    
    @discardableResult
    @MainActor
    public func update(_ closure: ([NSLayoutConstraint]) -> Void) -> Self {
        closure(constraints)
        return self
    }
    
    // MARK: - Debug
    
    @discardableResult
    @MainActor
    public func debug(_ color: UIColor = .red, alpha: CGFloat = 0.2) -> Self {
        view?.layer.borderColor = color.cgColor
        view?.layer.borderWidth = 1
        view?.backgroundColor = color.withAlphaComponent(alpha)
        return self
    }
}
