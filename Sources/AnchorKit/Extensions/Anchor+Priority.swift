//
//  File.swift
//  AnchorKit
//
//  Created by Muhammadjon Tohirov on 02/05/25.
//

import Foundation
import UIKit

// Extension to the Anchor class to add priority functionality
extension Anchor {
    // Enum to make priority values more readable
    public enum ConstraintPriority {
        case required
        case high
        case medium
        case low
        case custom(Float)
        
        var value: UILayoutPriority {
            switch self {
            case .required:
                return .required
            case .high:
                return UILayoutPriority(999)
            case .medium:
                return UILayoutPriority(750)
            case .low:
                return UILayoutPriority(250)
            case .custom(let value):
                return UILayoutPriority(value)
            }
        }
    }
    
    // Method to set priority for the last created constraint
    @discardableResult
    public func priority(_ priority: ConstraintPriority) -> Anchor {
        // Get the last constraint that was stored
        
        if let lastConstraintID = Array(constraints.keys).last,
           let constraint = constraints[lastConstraintID] {
            constraint.priority = priority.value
        }
        return self
    }
    
    // Convenience method for setting priority using Float directly
    @discardableResult
    public func priority(_ value: Float) -> Anchor {
        return priority(.custom(value))
    }
}
