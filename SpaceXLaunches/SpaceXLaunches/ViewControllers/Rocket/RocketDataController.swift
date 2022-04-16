//
//  RocketDataController.swift
//  SpaceXLaunches
//
//  Created by Leo Malikov on 16.04.2022.
//

import Foundation

class RocketDataController {
    
    weak var rocketViewController: RocketViewController?
    
    var rocket: RocketModel?
    
    init(for rocket: RocketModel) {
        
        self.rocket = rocket
        
        setBackgroundImage()
        
        DispatchQueue.main.async { [weak self] in
            self?.fillViews()
        }
        
    }
    
    private func setBackgroundImage() {
        
        guard
            let rocket = rocket,
            let imagesLinks = rocket.imagesLinks,
            let imageUrl = imagesLinks.randomElement()
        else { return }
        
        NetworkService.getImage(from: imageUrl) { image in
            DispatchQueue.main.async { [weak self] in
                self?.rocketViewController?.backgroundImageView.image = image
            }
        }
        
    }
    
    private func fillViews() {
        
        guard let rocket = rocket else { return }
        
        rocketViewController?.rocketNameView.fillViews(
            rocketName: rocket.name
        )
        
        rocketViewController?.rocketInfoView.fillViews(
            firstLaunch: rocket.firstLaunch,
            country: rocket.country,
            cost: rocket.launchCost?.description
        )
        
        rocketViewController?.rocketFirstStageInfoView.fillViews(
            label: "Первая ступень".capitalized,
            engines: rocket.firstStage?.engines?.description,
            fuelAmount: rocket.firstStage?.fuelAmount?.description,
            burnTime: rocket.firstStage?.burnTime?.description
        )
        
        rocketViewController?.rocketSecondStageInfoView.fillViews(
            label: "Вторая ступень".capitalized,
            engines: rocket.secondStage?.engines?.description,
            fuelAmount: rocket.secondStage?.fuelAmount?.description,
            burnTime: rocket.secondStage?.burnTime?.description
        )
        
        rocketViewController?.rocketParametersViewController.rocketId = rocket.id
        
    }
    
}
