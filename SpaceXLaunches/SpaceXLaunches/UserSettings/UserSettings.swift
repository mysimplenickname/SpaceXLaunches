//
//  UserSettings.swift
//  SpaceXLaunches
//
//  Created by Leo Malikov on 17.04.2022.
//

import Foundation
import UIKit

class UserSettings {
    
    static let shared = UserSettings()
    
    private let userDefaults = UserDefaults.standard
    
    var height: Height.Units = .m {
        didSet {
            userDefaults.set(height.rawValue, forKey: RocketParametersModel.Parameters.height.rawValue)
        }
    }
    
    var diameter: Diameter.Units = .m {
        didSet {
            userDefaults.set(diameter.rawValue, forKey: RocketParametersModel.Parameters.diameter.rawValue)
        }
    }
    
    var mass: Mass.Units = .kg {
        didSet {
            userDefaults.set(mass.rawValue, forKey: RocketParametersModel.Parameters.mass.rawValue)
        }
    }
    
    var capacity: Capacity.Units = .kg {
        didSet {
            userDefaults.set(capacity.rawValue, forKey: RocketParametersModel.Parameters.capacity.rawValue)
        }
    }
    
    private init() {
        
        for parameter in RocketParametersModel.Parameters.allCases {
            
            if let stringValue = userDefaults.string(forKey: parameter.rawValue) {

                switch parameter {
                case .height:
                    self.height = Height.getUnitByString(string: stringValue)
                case .diameter:
                    self.diameter = Diameter.getUnitByString(string: stringValue)
                case .mass:
                    self.mass = Mass.getUnitByString(string: stringValue)
                case .capacity:
                    self.capacity = Capacity.getUnitByString(string: stringValue)
                }
                
            }
            
        }
        
    }
    
}
