//
//  PageViewController.swift
//  SpaceXLaunches
//
//  Created by Leo Malikov on 14.04.2022.
//

import UIKit

class PageViewController: UIViewController {
    
    lazy var pageViewController: UIPageViewController = {
        let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController.view.frame = CGRect(x: 0.0, y: 0.0, width: view.frame.width, height: view.frame.height)
        pageViewController.dataSource = self
        pageViewController.isDoubleSided = true
        return pageViewController
    }()
    
    lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18)
        label.textColor = .gray
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = nil
        label.isHidden = true
        return label
    }()
    
    private var pageDataController: PageDataController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDataController()
        setupUI()
    }
    
    private func setupDataController() {
        pageDataController = PageDataController()
        pageDataController?.pageViewController = self
    }
    
    private func setupUI() {
        
        view.addSubview(errorLabel)
        
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        
        NSLayoutConstraint.activate([
        
            errorLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            errorLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -32)
            
        ])
        
    }

}

extension PageViewController: UIPageViewControllerDataSource {
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pageDataController?.numberOfViewControllers() ?? 0
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return pageDataController?.currentIndex ?? 0
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if let index = pageDataController?.index(of: viewController as! RocketViewController) {
            return pageDataController?.viewController(at: index - 1)
        }
        
        return nil
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if let index = pageDataController?.index(of: viewController as! RocketViewController) {
            return pageDataController?.viewController(at: index + 1)
        }
        
        return nil
        
    }
    
}
