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
    
    func getParametersCount() -> Int? {
        return RocketParametersModel.Parameters.allCases.count
    }
    
    func getParameterName(for parameterIndex: Int) -> String? {
        
        let parameter = RocketParametersModel.Parameters.allCases[parameterIndex]
        
        var units: String = ""
        
        switch parameter {
        case .height:
            units = UserSettings.shared.height.rawValue
        case .diameter:
            units = UserSettings.shared.diameter.rawValue
        case .mass:
            units = UserSettings.shared.mass.rawValue
        case .capacity:
            units = UserSettings.shared.capacity.rawValue
        }
        
        return parameter.rawValue + ", " + units
    }
    
    func getParameterValue(for parameterIndex: Int) -> String? {
        
        guard let rocketParameters = rocketParameters else { return nil }
        
        let parameterType = RocketParametersModel.Parameters.allCases[parameterIndex]
        let rocketParameter = rocketParameters.getParameterByParameterName(parameter: parameterType)
        
        var parameterValue: Double? = 0.0
        
        switch parameterType {
        case .height:
            parameterValue = (rocketParameter as? Height)?.getValueByUnit(unit: UserSettings.shared.height)
        case .diameter:
            parameterValue = (rocketParameter as? Diameter)?.getValueByUnit(unit: UserSettings.shared.diameter)
        case .mass:
            parameterValue = (rocketParameter as? Mass)?.getValueByUnit(unit: UserSettings.shared.mass)
        case .capacity:
            parameterValue = ((rocketParameter as? [Capacity])?.first { $0.id == "leo" })?.getValueByUnit(unit: UserSettings.shared.capacity)
        }
        
        return parameterValue?.description
        
    }
    
}
