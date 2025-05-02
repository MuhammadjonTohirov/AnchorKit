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

// Anchor class that provides a fluent constraint API
public class Anchor {
    weak var view: UIView?
    var constraints: [String: NSLayoutConstraint] = [:]
    
    public init(view: UIView) {
        self.view = view
        view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - Helper Methods
    
    // 1. Make your constraint access safer by using optional chaining and nil coalescing:
    @discardableResult
    private func updateConstraint(id: String, constant: CGFloat) -> Anchor {
        // Safer access with nil check
        constraints[id]?.constant = constant
        return self
    }

    // 2. Add defensive coding in your constraint ID generation:
    func constraintID(for type: String, relation: String, with target: AnyObject?) -> String {
        // More robust ID generation
        let safeType = type.isEmpty ? "unknown" : type
        let safeRelation = relation.isEmpty ? "unknown" : relation
        let targetID = target.map { String(describing: $0) } ?? "constant"
        return "\(safeType)_\(safeRelation)_\(targetID)"
    }
    
    @discardableResult
    private func store(_ constraint: NSLayoutConstraint, id: String) -> Anchor {
        constraints[id] = constraint
        constraint.isActive = true
        return self
    }
    
    // MARK: - Width Constraints
    
    @discardableResult
    public func width(_ constant: CGFloat) -> Anchor {
        guard let view = view else { return self }
        
        let id = constraintID(for: "width", relation: "equal", with: nil)
        let constraint = view.widthAnchor.constraint(equalToConstant: constant)
        return store(constraint, id: id)
    }
    
    @discardableResult
    public func width(max constant: CGFloat) -> Anchor {
        guard let view = view else { return self }
        
        let id = constraintID(for: "width", relation: "max", with: nil)
        let constraint = view.widthAnchor.constraint(lessThanOrEqualToConstant: constant)
        return store(constraint, id: id)
    }
    
    @discardableResult
    public func height(_ constant: CGFloat) -> Anchor {
        guard let view = view else { return self }
        
        let id = constraintID(for: "height", relation: "equal", with: nil)
        let constraint = view.heightAnchor.constraint(equalToConstant: constant)
        return store(constraint, id: id)
    }
    
    @discardableResult
    public func fillWidth(of otherView: UIView, inset: CGFloat = 0) -> Anchor {
        guard let view = view else { return self }
        
        let leadingID = constraintID(for: "leading", relation: "equal", with: otherView)
        let trailingID = constraintID(for: "trailing", relation: "equal", with: otherView)
        
        let leadingConstraint = view.leadingAnchor.constraint(equalTo: otherView.leadingAnchor, constant: inset)
        let trailingConstraint = view.trailingAnchor.constraint(equalTo: otherView.trailingAnchor, constant: -inset)
        
        store(leadingConstraint, id: leadingID)
        return store(trailingConstraint, id: trailingID)
    }
    
    // MARK: - Top/Bottom Constraints
    
    @discardableResult
    public func top(min anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> Anchor {
        guard let view = view else { return self }
        
        let id = constraintID(for: "top", relation: "min", with: anchor)
        let constraint = view.topAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant)
        return store(constraint, id: id)
    }
    
    @discardableResult
    public func bottom(max anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> Anchor {
        guard let view = view else { return self }
        
        let id = constraintID(for: "bottom", relation: "max", with: anchor)
        let constraint = view.bottomAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant)
        return store(constraint, id: id)
    }
    
    // MARK: - Center Constraints
    
    @discardableResult
    public func centerInSuperview() -> Anchor {
        guard let view = view, let superview = view.superview else { return self }
        
        let centerXID = constraintID(for: "centerX", relation: "equal", with: superview)
        let centerYID = constraintID(for: "centerY", relation: "equal", with: superview)
        
        let centerXConstraint = view.centerXAnchor.constraint(equalTo: superview.centerXAnchor)
        let centerYConstraint = view.centerYAnchor.constraint(equalTo: superview.centerYAnchor)
        
        store(centerXConstraint, id: centerXID)
        return store(centerYConstraint, id: centerYID)
    }
    
    // MARK: - Update Methods
    
    @discardableResult
    public func widthUpdate(max constant: CGFloat) -> Anchor {
        let id = constraintID(for: "width", relation: "max", with: nil)
        return updateConstraint(id: id, constant: constant)
    }
    
    @discardableResult
    public func fillWidthUpdate(of otherView: UIView, inset: CGFloat = 0) -> Anchor {
        let leadingID = constraintID(for: "leading", relation: "equal", with: otherView)
        let trailingID = constraintID(for: "trailing", relation: "equal", with: otherView)
        
        updateConstraint(id: leadingID, constant: inset)
        return updateConstraint(id: trailingID, constant: -inset)
    }
    
    @discardableResult
    public func topUpdate(min anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> Anchor {
        let id = constraintID(for: "top", relation: "min", with: anchor)
        return updateConstraint(id: id, constant: constant)
    }
    
    @discardableResult
    public func bottomUpdate(max anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> Anchor {
        let id = constraintID(for: "bottom", relation: "max", with: anchor)
        return updateConstraint(id: id, constant: constant)
    }
    
    // 3. Handle view deallocation more carefully:
    deinit {
        // Deactivate all constraints when the anchor is deallocated
        for (_, constraint) in constraints {
            constraint.isActive = false
        }
        constraints.removeAll()
    }
}

// Extension to add additional needed constraint methods
extension Anchor {
    @discardableResult
    public func top(to anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> Anchor {
        guard let view = view else { return self }
        
        let id = constraintID(for: "top", relation: "equal", with: anchor)
        let constraint = view.topAnchor.constraint(equalTo: anchor, constant: constant)
        return store(constraint, id: id)
    }
    
    @discardableResult
    public func bottom(to anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> Anchor {
        guard let view = view else { return self }
        
        let id = constraintID(for: "bottom", relation: "equal", with: anchor)
        let constraint = view.bottomAnchor.constraint(equalTo: anchor, constant: constant)
        return store(constraint, id: id)
    }
    
    @discardableResult
    public func centerX(in otherView: UIView) -> Anchor {
        guard let view = view else { return self }
        
        let id = constraintID(for: "centerX", relation: "equal", with: otherView)
        let constraint = view.centerXAnchor.constraint(equalTo: otherView.centerXAnchor)
        return store(constraint, id: id)
    }
    
    @discardableResult
    public func centerY(in otherView: UIView) -> Anchor {
        guard let view = view else { return self }
        
        let id = constraintID(for: "centerY", relation: "equal", with: otherView)
        let constraint = view.centerYAnchor.constraint(equalTo: otherView.centerYAnchor)
        return store(constraint, id: id)
    }
    
    @discardableResult
    public func height(min constant: CGFloat) -> Anchor {
        guard let view = view else { return self }
        
        let id = constraintID(for: "height", relation: "min", with: nil)
        let constraint = view.heightAnchor.constraint(greaterThanOrEqualToConstant: constant)
        return store(constraint, id: id)
    }
}
