//
//  PageViewController.swift
//  PageControllerDemo
//
//  Created by Mohamed Korany on 3/7/21.
//

import UIKit

// MARK: - PageViewController
//
class PageViewController: UIViewController {
  
  typealias Direction = UIPageViewController.NavigationDirection
  
  // MARK: - IBOutlets
  
  /// Tabs View that hold tabs
  ///
  let tabsView: TabView = {
    let view = TabView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  /// Page controller that hold tabs view controllers
  ///
  let pageController: UIPageViewController = {
    let pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    pageController.view.translatesAutoresizingMaskIntoConstraints = false
    return pageController
  }()
  
  // MARK: - Properties
  
  /// Selected index of tab view
  ///
  private(set) var selectedIndex: Int = .zero {
    didSet { updateSelectedController(oldIndex: oldValue) }
  }
  
  /// View Controllers List
  ///
  var controllers: [UIViewController] = [] {
    didSet { updateControllersAndTabsIfPossible() }
  }
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureViews()
    configureTabView()
    
    updateControllersAndTabsIfPossible()
  }
}

// MARK: - Configurations
//
private extension PageViewController {
  
  /// Configure views
  ///
  func configureViews() {
    let stackView = UIStackView(arrangedSubviews: [tabsView, pageController.view])
    stackView.axis = .vertical
    addChild(pageController)
    addSubviewWithReleativeToGuides(stackView)
    
    NSLayoutConstraint.activate([
      tabsView.heightAnchor.constraint(equalToConstant: 90)
    ])
  }
  
  /// Configure `TabView` on select Tab and list
  ///
  func configureTabView() {
    tabsView.configureOnSelect { [weak self] index in
      self?.selectedIndex = index
    }
  }
  
  /// Add subview with relative to guides
  ///
  func addSubviewWithReleativeToGuides(_ subview: UIView) {
    view.addSubview(subview)
    subview.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      subview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      subview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      subview.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
      subview.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }
}

// MARK: - Private Handlers
//
private extension PageViewController {
  
  /// Update controllers and tabs. Will be implemented only when view is loaded.
  ///
  func updateControllersAndTabsIfPossible() {
    if isViewLoaded {
      controllers.forEach { $0.didMove(toParent: self) }
      updateSelectedController(oldIndex: selectedIndex, animated: false)
      updateVisibleTabs()
    }
  }
  
  /// Update view when needed with main tabs and selected tab
  ///
  func updateVisibleTabs() {
    tabsView.setList(controllers.map { $0.tabBarItem })
    tabsView.selectItem(at: selectedIndex)
  }
  
  /// Set view controllers that used for tabs
  ///
  func updateSelectedController(oldIndex: Int, animated: Bool = true) {
    let direction: Direction = oldIndex < selectedIndex ? .forward : .reverse
    selectViewController(direction: direction, animated: animated)
  }

  func selectViewController(direction: Direction, animated: Bool) {
    pageController.setViewControllers(
      [controllers[selectedIndex]], direction: direction, animated: animated
    )
  }
}

// MARK: - Default Style
//
extension PageViewController {
  
  /// Apply default style
  ///
  func applyDefaultStyle() {
    tabsView.tintColor = .orange
  }
}
