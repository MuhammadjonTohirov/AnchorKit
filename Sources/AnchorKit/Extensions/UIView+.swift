//
//  File.swift
//  AnchorKit
//
//  Created by Muhammadjon Tohirov on 30/04/25.
//

import Foundation
import UIKit

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
