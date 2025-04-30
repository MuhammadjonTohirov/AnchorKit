//
//  File.swift
//  AnchorKit
//
//  Created by Muhammadjon Tohirov on 30/04/25.
//

import Foundation
import UIKit

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
