//
//  File.swift
//  AnchorKit
//
//  Created by Muhammadjon Tohirov on 30/04/25.
//

import Foundation
import UIKit

class ExampleViewController: UIViewController {
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemGray5
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .label
        label.text = "John Appleseed"
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        label.text = "iOS Developer"
        label.numberOfLines = 0
        return label
    }()
    
    private let followButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Follow", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let contentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .leading
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        // Add subviews
        view.addSubview(profileImageView)
        view.addSubview(contentStack)
        view.addSubview(followButton)
        
        contentStack.addArrangedSubview(nameLabel)
        contentStack.addArrangedSubview(descriptionLabel)
        
        // Setup constraints using AnchorKit
        
        // Profile image - circular with fixed size
        profileImageView.anchor
            .top(to: view.safeAreaLayoutGuide.topAnchor, constant: 20)
            .leading(to: view.leadingAnchor, constant: 20)
            .size(60)
            
        // Make the image view circular in viewDidLayoutSubviews
        
        // Content stack - next to profile image
        contentStack.anchor
            .top(to: profileImageView.topAnchor)
            .leading(to: profileImageView.trailingAnchor, constant: 12)
            .trailing(to: view.trailingAnchor, constant: 20)
            .prepareForStackView()
        
        // Follow button - below profile content
        followButton.anchor
            .top(to: profileImageView.bottomAnchor, constant: 20)
            .leading(to: view.leadingAnchor, constant: 20)
            .trailing(to: view.trailingAnchor, constant: 20)
            .height(44)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
    }
}

// Example 2: Complex layout with dynamic sizing
class CardViewController: UIViewController {
    
    private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 12
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowRadius = 8
        return view
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemGray5
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .label
        label.text = "Card Title"
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        label.text = "Card subtitle with some additional information"
        label.numberOfLines = 0
        return label
    }()
    
    private let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Take Action", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemGroupedBackground
        
        // Add subviews
        view.addSubview(cardView)
        cardView.addSubview(imageView)
        cardView.addSubview(titleLabel)
        cardView.addSubview(subtitleLabel)
        cardView.addSubview(actionButton)
        
        // Setup constraints
        
        // Card view - centered with max width
        cardView.anchor
            .centerInSuperview()
            .width(max: 400)
            .fillWidth(of: view, inset: 20)
            .top(min: view.safeAreaLayoutGuide.topAnchor, constant: 20)
            .bottom(max: view.safeAreaLayoutGuide.bottomAnchor, constant: 20)
        
        // Image view - top of card with aspect ratio
        imageView.anchor
            .top(to: cardView.topAnchor)
            .fillWidth(of: cardView)
            .height(equalTo: imageView.widthAnchor, multiplier: 0.6)
        
        // Title - below image
        titleLabel.anchor
            .top(to: imageView.bottomAnchor, constant: 16)
            .fillWidth(of: cardView, inset: 16)
        
        // Subtitle - below title
        subtitleLabel.anchor
            .top(to: titleLabel.bottomAnchor, constant: 8)
            .fillWidth(of: cardView, inset: 16)
        
        // Action button - bottom of card
        actionButton.anchor
            .top(to: subtitleLabel.bottomAnchor, constant: 16)
            .fillWidth(of: cardView, inset: 16)
            .height(44)
            .bottom(to: cardView.bottomAnchor, constant: 16)
    }
}

// Example 3: Safe area handling
class SafeAreaExampleController: UIViewController {
    
    private let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        return view
    }()
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Header"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private let contentScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .systemBackground
        return scrollView
    }()
    
    private let contentContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    private let footerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        return view
    }()
    
    private let footerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Continue", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        generateDummyContent()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        // Add subviews
        view.addSubview(headerView)
        headerView.addSubview(headerLabel)
        view.addSubview(contentScrollView)
        contentScrollView.addSubview(contentContainer)
        view.addSubview(footerView)
        footerView.addSubview(footerButton)
        
        // Header - sticks to top safe area
        headerView.anchor
            .top(to: view.topAnchor)
            .fillWidth(of: view)
            .height(120)
        
        // Header label - centered in header
        headerLabel.anchor
            .centerY(to: view.safeAreaLayoutGuide.topAnchor, constant: 30)
            .centerX(in: headerView)
        
        // Scroll view - between header and footer
        contentScrollView.anchor
            .top(to: headerView.bottomAnchor)
            .fillWidth(of: view)
            .bottom(to: footerView.topAnchor)
        
        // Content container - full width of scroll view
        contentContainer.anchor
            .edges(to: contentScrollView, insets: .zero)
            .width(equalTo: view.widthAnchor) // Important for proper scrolling
        
        // Footer - sticks to bottom of screen
        footerView.anchor
            .bottom(to: view.bottomAnchor)
            .fillWidth(of: view)
            .height(100)
        
        // Footer button - inside footer with safe area consideration
        footerButton.anchor
            .fillWidth(of: footerView, inset: 20)
            .height(50)
            .bottom(to: view.safeAreaLayoutGuide.bottomAnchor, constant: 20)
    }
    
    private func generateDummyContent() {
        // Add some dummy content to demonstrate scrolling
        var lastView: UIView?
        
        for i in 1...15 {
            let itemView = UIView()
            itemView.backgroundColor = i % 2 == 0 ? .systemGray6 : .systemGray5
            contentContainer.addSubview(itemView)
            
            itemView.anchor
                .fillWidth(of: contentContainer)
                .height(80)
            
            if let lastView = lastView {
                itemView.anchor.top(to: lastView.bottomAnchor, constant: 1)
            } else {
                itemView.anchor.top(to: contentContainer.topAnchor)
            }
            
            let label = UILabel()
            label.text = "Item \(i)"
            itemView.addSubview(label)
            
            label.anchor.centerInSuperview()
            
            lastView = itemView
        }
        
        lastView?.anchor.bottom(to: contentContainer.bottomAnchor)
    }
}

// Example 4: Complex form with dynamic sizing
class FormViewController: UIViewController {
    
    private let formContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .fill
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Registration Form"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private let nameField: UITextField = {
        let field = UITextField()
        field.placeholder = "Full Name"
        field.borderStyle = .roundedRect
        return field
    }()
    
    private let emailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Email Address"
        field.borderStyle = .roundedRect
        field.keyboardType = .emailAddress
        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.placeholder = "Password"
        field.borderStyle = .roundedRect
        field.isSecureTextEntry = true
        return field
    }()
    
    private let termsSwitch = UISwitch()
    
    private let termsLabel: UILabel = {
        let label = UILabel()
        label.text = "I agree to the Terms & Conditions"
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let termsContainer = UIView()
    
    private let submitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Create Account", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        // Add views
        view.addSubview(formContainer)
        
        // Configure form container
        formContainer.addArrangedSubview(titleLabel)
        formContainer.addArrangedSubview(nameField)
        formContainer.addArrangedSubview(emailField)
        formContainer.addArrangedSubview(passwordField)
        formContainer.addArrangedSubview(termsContainer)
        formContainer.addArrangedSubview(submitButton)
        
        // Configure terms container
        termsContainer.addSubview(termsSwitch)
        termsContainer.addSubview(termsLabel)
        
        // Set constraints
        formContainer.anchor
            .fillWidth(of: view, inset: 20)
            .centerY(in: view)
            .top(min: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        
        termsSwitch.anchor
            .leading(to: termsContainer.leadingAnchor)
            .centerY(in: termsContainer)
        
        termsLabel.anchor
            .leading(to: termsSwitch.trailingAnchor, constant: 8)
            .trailing(to: termsContainer.trailingAnchor)
            .centerY(to: termsSwitch.centerYAnchor)
        
        // Height for terms container
        termsContainer.anchor
            .height(44)
        
        // Height for buttons
        submitButton.anchor
            .height(50)
            
        // Prepare fields for stack view layout
        [nameField, emailField, passwordField].forEach { field in
            field.anchor
                .height(44)
                .prepareForStackView()
        }
    }
}

// Example 5: Tab Bar with custom layout
class CustomTabViewController: UIViewController {
    
    private let contentView = UIView()
    
    private let tabBar: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: -2)
        view.layer.shadowRadius = 4
        return view
    }()
    
    private let homeButton = CustomTabButton(title: "Home", systemName: "house.fill")
    private let searchButton = CustomTabButton(title: "Search", systemName: "magnifyingglass")
    private let profileButton = CustomTabButton(title: "Profile", systemName: "person.fill")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        // Add views
        view.addSubview(contentView)
        view.addSubview(tabBar)
        
        // Add tab buttons
        tabBar.addSubview(homeButton)
        tabBar.addSubview(searchButton)
        tabBar.addSubview(profileButton)
        
        // Set constraints for main views
        contentView.anchor
            .top(to: view.topAnchor)
            .fillWidth(of: view)
            .bottom(to: tabBar.topAnchor)
        
        tabBar.anchor
            .bottom(to: view.bottomAnchor)
            .fillWidth(of: view)
            .height(90) // Includes safe area
        
        // Set constraints for tab buttons
        let tabButtons = [homeButton, searchButton, profileButton]
        let buttonWidth = 1.0 / CGFloat(tabButtons.count)
        
        // Create button layout
        for (index, button) in tabButtons.enumerated() {
            button.anchor
                .top(to: tabBar.topAnchor)
                .bottom(to: view.safeAreaLayoutGuide.bottomAnchor)
                .width(equalTo: tabBar.widthAnchor, multiplier: buttonWidth)
            
            if index == 0 {
                button.anchor.leading(to: tabBar.leadingAnchor)
            } else {
                button.anchor.leading(to: tabButtons[index - 1].trailingAnchor)
            }
        }
        
        // Activate the first button
        homeButton.setActive(true)
    }
}

// Helper for the tab example
class CustomTabButton: UIView {
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemGray
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .systemGray
        label.textAlignment = .center
        return label
    }()
    
    init(title: String, systemName: String) {
        super.init(frame: .zero)
        
        titleLabel.text = title
        iconImageView.image = UIImage(systemName: systemName)
        
        addSubview(iconImageView)
        addSubview(titleLabel)
        
        iconImageView.anchor
            .top(to: topAnchor, constant: 8)
            .centerX(in: self)
            .size(24)
        
        titleLabel.anchor
            .top(to: iconImageView.bottomAnchor, constant: 4)
            .fillWidth(of: self)
            .bottom(to: bottomAnchor, constant: 8)
        
        // Add tap gesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setActive(_ isActive: Bool) {
        iconImageView.tintColor = isActive ? .systemBlue : .systemGray
        titleLabel.textColor = isActive ? .systemBlue : .systemGray
    }
    
    @objc private func handleTap() {
        // Implement tab selection logic
        setActive(true)
    }
}

#Preview {
    CardViewController()
}
