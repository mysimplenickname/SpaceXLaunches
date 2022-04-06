//
//  NetworkService.swift
//  SpaceXLaunches
//
//  Created by Leo Malikov on 05.04.2022.
//

import Foundation
import Alamofire

final class NetworkService {
    
    func getRockets(completion: @escaping ([RocketModel]) -> Void) {
        
        let rocketsBaseUrl = "https://api.spacexdata.com/v4/rockets"
        
        var rockets: [RocketModel] = []
        
        AF
            .request(rocketsBaseUrl, method: .get)
            .response { response in
                guard let data = response.data else { return }
                do {
                    rockets = try JSONDecoder().decode([RocketModel].self, from: data)
                    completion(rockets)
                } catch {
                    print(error)
                }
            }
            .cacheResponse(using: .cache)
        
    }
    
    func getLaunches(for rocketId: String, completion: @escaping ([LaunchModel]) -> Void) {
        
        let launchesBaseUrl = "https://api.spacexdata.com/v4/launches" + "/query"
        
        let parameters: Parameters =
        [
            "query": [
                "rocket": rocketId
            ],
            "options": [
                "select": [
                    "name",
                    "date_utc",
                    "success"
                ]
            ]
        ]
        
        var launches: [LaunchModel] = []
        
        AF
            .request(launchesBaseUrl, method: .post, parameters: parameters)
            .response { response in
                guard let data = response.data else { return }
                do {
                    let launcesResponse = try JSONDecoder().decode(LaunchesResponse.self, from: data).docs
                    launcesResponse.forEach {
                        if let launch = $0 {
                            launches.append(launch)
                        }
                    }
                    completion(launches)
                } catch {
                    print(error)
                }
            }
            .cacheResponse(using: .cache)
        
    }
    
}
