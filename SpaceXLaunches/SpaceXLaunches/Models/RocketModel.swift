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
    
}

struct Height: Decodable {
    let meters: Double?
    let feet: Double?
}

struct Diameter: Decodable {
    let meters: Double?
    let feet: Double?
}

struct Mass: Decodable {
    let kg: Double?
    let lb: Double?
}

struct Capacity: Decodable {
    let id: String?
    let kg: Double?
    let lb: Double?
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
