//
//  LaunchModel.swift
//  SpaceXLaunches
//
//  Created by Leo Malikov on 05.04.2022.
//

import Foundation

struct LaunchesResponse: Decodable {
    
    let docs: [LaunchModel?]
    
}

struct LaunchModel: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case name
        case date = "date_utc"
        case success
    }
    
    let name: String?
    let date: String?
    let success: Bool?
    
}
