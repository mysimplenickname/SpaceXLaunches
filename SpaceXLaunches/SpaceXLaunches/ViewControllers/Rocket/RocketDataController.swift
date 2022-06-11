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
            
            guard
                let sourceImage = image,
                let croppedImage = self?.crop(image: sourceImage)
            else { return }
            
            DispatchQueue.main.async {
                self?.rocketViewController?.activityIndicatorView.stopAnimating()
                self?.rocketViewController?.activityIndicatorView.removeFromSuperview()
                self?.rocketViewController?.setBackgroundImage(with: croppedImage)
            }
        }
        
    }
    
    func showLaunches() {
        
        let launchesViewController = LaunchesViewController()
        launchesViewController.rocketId = rocket?.id
        launchesViewController.title = rocket?.name
        
        configureNavigationBar()
        
        rocketViewController?.navigationController?.pushViewController(launchesViewController, animated: true)
        
    }
    
    func showSettings() {
        
        let settingsViewController = SettingsViewController()
        settingsViewController.rocketViewController = rocketViewController
        rocketViewController?.present(settingsViewController, animated: true)
        
    }
    
    private func configureNavigationBar() {
        
        rocketViewController?.navigationController?.navigationBar.titleTextAttributes = [
            .backgroundColor: UIColor.clear,
            .foregroundColor: UIColor.white
        ]
        
        rocketViewController?.navigationController?.navigationBar.barStyle = .black
        
        let backBarButtonItem = UIBarButtonItem(
            title: "Назад",
            style: .plain,
            target: nil,
            action: nil
        )
        
        backBarButtonItem.tintColor = .white
        
        rocketViewController?.navigationController?.navigationBar.topItem?.backBarButtonItem = backBarButtonItem
        
    }
    
    private func crop(image: UIImage) -> UIImage? {
        
        guard
            let width = rocketViewController?.view.frame.width,
            let height = rocketViewController?.view.frame.height,
            let sourceCGImage = image.cgImage
        else { return nil }
        
        let xOffset = (image.size.width - width) / 2
        let yOffset = (image.size.height - height) / 2
        
        let cropRect = CGRect(
            x: xOffset > 0 ? xOffset : 0,
            y: yOffset > 0 ? yOffset : 0,
            width: width,
            height: height
        )
        
        if let croppedImage = sourceCGImage.cropping(to: cropRect) {
            return UIImage(cgImage: croppedImage)
        }
        
        return nil
        
    }
    
}
