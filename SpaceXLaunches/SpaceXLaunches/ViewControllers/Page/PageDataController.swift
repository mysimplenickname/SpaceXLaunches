//
//  PageDataController.swift
//  SpaceXLaunches
//
//  Created by Leo Malikov on 16.04.2022.
//

import Foundation

class PageDataController {
    
    weak var pageViewController: PageViewController?
    
    private var rockets: [RocketModel]?
    
    private var rocketsViewControllers: [RocketViewController]?
    
    private(set) var currentIndex: Int = 0
    
    init() {
        
        NetworkService.getRockets { [weak self] (rockets, error) in
            
            if let error = error {
                
                DispatchQueue.main.async {
                    self?.pageViewController?.errorLabel.text = error.localizedDescription
                    self?.pageViewController?.errorLabel.isHidden = false
                }
                
            } else if let rockets = rockets {
                
                if rockets.isEmpty {
                    
                    DispatchQueue.main.async {
                        self?.pageViewController?.errorLabel.text = "There is no rockets yet"
                        self?.pageViewController?.errorLabel.isHidden = false
                    }
                    
                    return
                    
                }
                
                self?.rockets = rockets
                
                self?.rocketsViewControllers = rockets.map { rocket in
                    let rocketViewController = RocketViewController()
                    rocketViewController.rocket = rocket
                    return rocketViewController
                }
                
                guard let firstRocketViewController = self?.rocketsViewControllers?.first else { return }
                
                self?.pageViewController?.pageViewController.setViewControllers(
                    [firstRocketViewController],
                    direction: .forward,
                    animated: true
                )
                
            }
            
        }
        
    }
    
    func numberOfViewControllers() -> Int {
        
        guard let rocketsViewControllers = rocketsViewControllers else { return 0 }

        return rocketsViewControllers.count
        
    }
    
    func viewController(at index: Int) -> RocketViewController? {
        
        guard let rocketsViewControllers = rocketsViewControllers else { return nil }
        
        if index >= 0 && index < rocketsViewControllers.count {
            currentIndex = index
            return rocketsViewControllers[index]
        } else {
            return nil
        }
        
    }
    
    func index(of viewController: RocketViewController) -> Int? {
        
        guard let rocketsViewControllers = rocketsViewControllers else { return nil }

        return rocketsViewControllers.firstIndex(of: viewController)
        
    }
    
}
