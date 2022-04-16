//
//  RocketParametersDataController.swift
//  SpaceXLaunches
//
//  Created by Leo Malikov on 15.04.2022.
//

import Foundation

class RocketParametersDataController {
    
    weak var rocketParametersViewController: RocketParametersViewController?
    
    private var rocketParameters: RocketParametersModel? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.rocketParametersViewController?.collectionView.reloadData()
            }
        }
    }
    
    func getRocketParameters(for rocketId: String) {
        
        NetworkService.getRocketParameters(for: rocketId) { [weak self] rocketParameters in
            if let rocketParameters = rocketParameters {
                self?.rocketParameters = rocketParameters
            }
        }
        
    }
    
    func getParameterValue(for parameterIndex: Int) -> Double? {
        
        guard let rocketParameters = rocketParameters else { return nil }
        
        let mirror = Mirror(reflecting: rocketParameters)
        let value = mirror.children.enumerated().first { $0.offset == parameterIndex }?.element.value
        
        switch parameterIndex {
        case 0:
            return (value as? Height)?.meters
        case 1:
            return (value as? Diameter)?.meters
        case 2:
            return (value as? Mass)?.kg
        case 3:
            return (value as? [Capacity])?.first { $0.id == "leo" }?.kg
        default:
            return nil
        }
        
    }
    
}
