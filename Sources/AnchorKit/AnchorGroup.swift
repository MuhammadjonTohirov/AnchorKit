//
//  File.swift
//  AnchorKit
//
//  Created by Muhammadjon Tohirov on 30/04/25.
//

import Foundation
import UIKit

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
