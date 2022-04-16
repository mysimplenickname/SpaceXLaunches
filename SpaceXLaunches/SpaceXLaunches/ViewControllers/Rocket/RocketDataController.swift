//
//  RocketDataController.swift
//  SpaceXLaunches
//
//  Created by Leo Malikov on 16.04.2022.
//

import UIKit

class RocketDataController {
    
    weak var rocketViewController: RocketViewController?
    
    var rocket: RocketModel?
    
    func getData(for rocket: RocketModel) {
        
        self.rocket = rocket
        
        self.rocketViewController?.rocketParametersViewController.rocketId = rocket.id
        
        self.rocketViewController?.fillRocketName(
            rocketName: rocket.name
        )
        
        self.rocketViewController?.fillRocketInfoView(
            firstLaunch: DataFormatterService.formatDate(dateString: rocket.firstLaunch ?? "", option: .simple),
            country: DataFormatterService.formatCountry(country: rocket.country ?? ""),
            launchCost: DataFormatterService.formatCost(cost: rocket.launchCost ?? 0.0)
        )
        
        self.rocketViewController?.fillRocketFirstStageInfoView(
            engines: rocket.firstStage?.engines?.description,
            fuelAmount: rocket.firstStage?.fuelAmount?.description,
            burnTime: rocket.firstStage?.burnTime?.description
        )
        
        self.rocketViewController?.fillRocketSecondStageInfoView(
            engines: rocket.secondStage?.engines?.description,
            fuelAmount: rocket.secondStage?.fuelAmount?.description,
            burnTime: rocket.secondStage?.burnTime?.description
        )
        
        guard
            let imagesLinks = rocket.imagesLinks,
            let imageUrl = imagesLinks.randomElement()
        else { return }
        
        NetworkService.getImage(from: imageUrl) { [weak self] image in
            DispatchQueue.main.async {
                self?.rocketViewController?.activityIndicatorView.stopAnimating()
                self?.rocketViewController?.activityIndicatorView.removeFromSuperview()
                self?.rocketViewController?.setBackgroundImage(with: image)
            }
        }
        
    }
    
    func showLaunches() {
        
        let launchesViewController = LaunchesViewController()
        launchesViewController.rocketId = rocket?.id
        launchesViewController.title = rocket?.name
        
        rocketViewController?.navigationController?.navigationBar.titleTextAttributes = [
            .backgroundColor: UIColor.clear,
            .foregroundColor: UIColor.white
        ]
        rocketViewController?.navigationController?.navigationBar.barStyle = .black
        rocketViewController?.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(
            title: "Назад",
            style: .plain,
            target: nil,
            action: nil
        )
        
        rocketViewController?.navigationController?.pushViewController(launchesViewController, animated: true)
        
    }
    
}
