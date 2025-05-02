//
//  File.swift
//  AnchorKit
//
//  Created by Muhammadjon Tohirov on 30/04/25.
//

import Foundation
import UIKit

// Main View Controller
class MainViewController: UIViewController {
    
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let openButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Main Screen"
        view.backgroundColor = .systemBackground
        
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        titleLabel.text = "Anchor Management Example"
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
        
        descriptionLabel.text = "This example demonstrates proper memory management with Anchor. Tap the button to open a second screen with anchored views."
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        view.addSubview(descriptionLabel)
        
        openButton.setTitle("Open Second Screen", for: .normal)
        openButton.backgroundColor = .systemBlue
        openButton.setTitleColor(.white, for: .normal)
        openButton.layer.cornerRadius = 10
        openButton.addTarget(self, action: #selector(openSecondScreen), for: .touchUpInside)
        view.addSubview(openButton)
    }
    
    private func setupConstraints() {
        titleLabel.anchor
            .centerX(in: view)
            .top(to: view.safeAreaLayoutGuide.topAnchor, constant: 40)
            .fillWidth(of: view, inset: 20)
        
        descriptionLabel.anchor
            .fillWidth(of: view, inset: 20)
            .top(to: titleLabel.bottomAnchor, constant: 30)
        
        openButton.anchor
            .centerX(in: view)
            .width(220)
            .height(50)
            .top(to: descriptionLabel.bottomAnchor, constant: 40)
    }
    
    @objc private func openSecondScreen() {
        let secondVC = SecondViewController()
        self.present(secondVC, animated: true)
    }
}

// Second View Controller with memory tracking
class SecondViewController: UIViewController {
    
    private let containerView = UIView()
    private let titleLabel = UILabel()
    private let closeButton = UIButton(type: .system)
    private let infoLabel = UILabel()
    
    // Track when this view controller is deallocated
    deinit {
        print("SecondViewController is being deallocated!")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Second Screen"
        view.backgroundColor = .systemBackground
        
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        containerView.backgroundColor = .systemGray6
        containerView.layer.cornerRadius = 12
        view.addSubview(containerView)
        
        titleLabel.text = "Memory Management Test"
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        titleLabel.textAlignment = .center
        containerView.addSubview(titleLabel)
        
        infoLabel.text = "This screen demonstrates Anchor memory management. When you close this screen, it will check if Anchor instances are properly deallocated. Check Xcode console for results."
        infoLabel.font = UIFont.systemFont(ofSize: 16)
        infoLabel.numberOfLines = 0
        infoLabel.textAlignment = .center
        containerView.addSubview(infoLabel)
        
        closeButton.setTitle("Close Screen", for: .normal)
        closeButton.backgroundColor = .systemRed
        closeButton.setTitleColor(.white, for: .normal)
        closeButton.layer.cornerRadius = 10
        closeButton.addTarget(self, action: #selector(closeScreen), for: .touchUpInside)
        containerView.addSubview(closeButton)
    }
    
    private func setupConstraints() {
        // Container with priority settings
        containerView.anchor
            .fillWidth(of: view, inset: 20).priority(.high)
            .centerY(in: view)
            .height(min: 300).priority(.medium)
            .top(min: view.safeAreaLayoutGuide.topAnchor, constant: 20).priority(.required)
            .bottom(max: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).priority(.required)
        
        titleLabel.anchor
            .fillWidth(of: containerView, inset: 16)
            .top(to: containerView.topAnchor, constant: 20)
        
        infoLabel.anchor
            .fillWidth(of: containerView, inset: 16)
            .top(to: titleLabel.bottomAnchor, constant: 20)
        
        closeButton.anchor
            .centerX(in: containerView)
            .width(200)
            .height(50)
            .top(to: infoLabel.bottomAnchor, constant: 30)
            .bottom(max: containerView.bottomAnchor, constant: -20)
    }
    
    @objc private func closeScreen() {
        dismiss(animated: true)
    }
    
    // Add methods to update constraints with animation
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Animate container expansion after a short delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self = self else { return }
            
            UIView.animate(withDuration: 0.5) {
                // Update constraints with animation
                self.containerView.anchor
                    .fillWidthUpdate(of: self.view, inset: 10)
                
                // Tell the view to layout now
                self.view.layoutIfNeeded()
            }
        }
    }
}

#Preview {
    MainViewController()
}
