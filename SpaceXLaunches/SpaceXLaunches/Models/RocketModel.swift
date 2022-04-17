//
//  RocketModel.swift
//  SpaceXLaunches
//
//  Created by Leo Malikov on 05.04.2022.
//

import Foundation

struct RocketModel: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case name
        
        case firstLaunch = "first_flight"
        case country
        case launchCost = "cost_per_launch"
        
        case firstStage = "first_stage"
        case secondStage = "second_stage"
        
        case imagesLinks = "flickr_images"
        
        case id
    }
    
    let name: String?
    
    let firstLaunch: String?
    let country: String?
    let launchCost: Double?
    
    let firstStage: StageModel?
    let secondStage: StageModel?
    
    let imagesLinks: [String]?
    
    let id: String?
    
}

struct RocketParametersModel: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case height
        case diameter
        case mass
        case capacity = "payload_weights"
    }
    
    let height: Height?
    let diameter: Diameter?
    let mass: Mass?
    let capacity: [Capacity]?
    
    enum Parameters: String, CaseIterable {
        case height = "Высота"
        case diameter = "Диаметр"
        case mass = "Масса"
        case capacity = "Нагрузка"
    }
    
    func getParameterByParameterName(parameter: Parameters) -> Any? {
        
        switch parameter {
        case .height:
            return height
        case .diameter:
            return diameter
        case .mass:
            return mass
        case .capacity:
            return capacity
        }
        
    }
    
    static func getParameterByParameterRawValue(string: String) -> Parameters? {
        
        for parameter in Parameters.allCases {
            
            if parameter.rawValue == string {
                return parameter
            }
            
        }
        
        return nil
        
    }
    
}

struct Height: Decodable {
    
    let meters: Double?
    let feet: Double?
    
    enum Units: String, CaseIterable {
        case m = "m"
        case ft = "ft"
    }
    
    func getValueByUnit(unit: Units) -> Double? {
        switch unit {
        case .m:
            return meters
        case .ft:
            return feet
        }
    }
    
    static func getUnitByString(string: String) -> Units {
        for unit in Units.allCases {
            if unit.rawValue == string {
                return unit
            }
        }
        return .m
    }
    
}

struct Diameter: Decodable {
    
    let meters: Double?
    let feet: Double?
    
    enum Units: String, CaseIterable {
        case m = "m"
        case ft = "ft"
    }
    
    func getValueByUnit(unit: Units) -> Double? {
        switch unit {
        case .m:
            return meters
        case .ft:
            return feet
        }
    }
    
    static func getUnitByString(string: String) -> Units {
        for unit in Units.allCases {
            if unit.rawValue == string {
                return unit
            }
        }
        return .m
    }
    
}

struct Mass: Decodable {
    
    let kg: Double?
    let lb: Double?
    
    enum Units: String, CaseIterable {
        case kg = "kg"
        case lb = "lb"
    }
    
    func getValueByUnit(unit: Units) -> Double? {
        switch unit {
        case .kg:
            return kg
        case .lb:
            return lb
        }
    }
    
    static func getUnitByString(string: String) -> Units {
        for unit in Units.allCases {
            if unit.rawValue == string {
                return unit
            }
        }
        return .kg
    }
    
}

struct Capacity: Decodable {
    
    let id: String?
    let kg: Double?
    let lb: Double?
    
    enum Units: String, CaseIterable {
        case kg = "kg"
        case lb = "lb"
    }
    
    func getValueByUnit(unit: Units) -> Double? {
        switch unit {
        case .kg:
            return kg
        case .lb:
            return lb
        }
    }
    
    static func getUnitByString(string: String) -> Units {
        for unit in Units.allCases {
            if unit.rawValue == string {
                return unit
            }
        }
        return .kg
    }
    
}

struct StageModel: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case engines
        case fuelAmount = "fuel_amount_tons"
        case burnTime = "burn_time_sec"
    }
    
    let engines: Int?
    let fuelAmount: Double?
    let burnTime: Int?
    
}
