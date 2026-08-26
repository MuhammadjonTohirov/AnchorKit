import AnchorKit
import UIKit

final class CardViewController: UIViewController {
  private let cardView = UIView()
  private let titleLabel = UILabel()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .systemBackground
    cardView.backgroundColor = .secondarySystemBackground
    cardView.layer.cornerRadius = 16
    titleLabel.text = "Built with AnchorKit"
    titleLabel.textAlignment = .center

    view.addSubview(cardView)
    cardView.addSubview(titleLabel)

    cardView.anchor
      .fillWidth(of: view.safeAreaLayoutGuide, inset: 20)
      .centerY(in: view.safeAreaLayoutGuide)
      .height(min: 180)

    titleLabel.anchor
      .fill(cardView, insets: .init(top: 20, leading: 20, bottom: 20, trailing: 20))
  }

  func expandCard() {
    cardView.anchor.heightUpdate(min: 260)

    UIView.animate(withDuration: 0.3) {
      self.view.layoutIfNeeded()
    }
  }
}
