//
//  TabCollectionViewCell.swift
//  PageControllerDemo
//
//  Created by Mohamed Korany on 3/8/21.
//

import UIKit

// MARK: - TabCollectionViewCell
//
class TabCollectionViewCell: UICollectionViewCell {
    
  // MARK: - IBOutlets
  
  @IBOutlet private weak var button: UIButton!
  @IBOutlet private weak var lineView: UIView!
  
  // MARK: - Lifecycle
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    updateView()
  }
  
  // MARK: - Interface Properties
  
  /// Color  indicates Tab footer view color
  ///
  var rippleColor: UIColor? = .orange {
    didSet { updateView() }
  }
  
  /// Color indicates Tab title color
  ///
  var selectedColor: UIColor? = .orange {
    didSet { updateView() }
  }

  /// Color indicates Tab title color
  ///
  var normalColor: UIColor? = .gray {
    didSet { updateView() }
  }

  // MARK: - Override Properties
  
  override var isSelected: Bool {
    get {
      return super.isSelected
    }
    set {
      super.isSelected = newValue
      updateViewAnimated()
    }
  }
  
  // MARK: - Override Touches
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
    showOnPressAnimation()
  }
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesMoved(touches, with: event)
    showOnPressAnimation()
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesEnded(touches, with: event)
    hideOnPressAnimations()
  }
  
  override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesCancelled(touches, with: event)
    hideOnPressAnimations()
  }
}

// MARK: - Handlers
//
private extension TabCollectionViewCell {
  
  /// Update view with animation; Mostly upon selection
  ///
  func updateViewAnimated() {
    UIView.animate(withDuration: 0.3) {
      self.updateView()
    }
  }
  
  /// Update view
  ///
  func updateView() {
    button.setTitleColor(isSelected ? selectedColor : normalColor, for: .normal)
    lineView.backgroundColor = isSelected ? rippleColor : .clear
  }
}

// MARK: - Computed Properties
//
extension TabCollectionViewCell {
  
  /// Title label which indicates Tab title
  ///
  var title: String? {
    get { button.titleLabel?.text }
    set { button.setTitle(newValue, for: .normal) }
  }
  
  /// Icon Image
  ///
  var icon: UIImage? {
    get { button.imageView?.image }
    set { button.setImage(newValue, for: .normal) }
  }
}

// MARK: - Touches Handlers
//
private extension TabCollectionViewCell {

  /// Show animations when touches starts
  ///
  func showOnPressAnimation() {
    UIView.animate(withDuration: 0.3) {
      self.button.transform = CGAffineTransform(scaleX: 0.9,y: 0.9)
    }
  }
  
  /// Hide animations when touches ends/ cancelled
  ///
  func hideOnPressAnimations() {
    UIView.animate(withDuration: 0.3) {
      self.button.transform = CGAffineTransform.identity
    }
  }
}
