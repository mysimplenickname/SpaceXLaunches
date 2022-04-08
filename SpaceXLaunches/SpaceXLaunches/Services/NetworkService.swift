//
//  NetworkService.swift
//  SpaceXLaunches
//
//  Created by Leo Malikov on 05.04.2022.
//

import UIKit
import Alamofire

final class NetworkService {
    
    static func getRockets(completion: @escaping ([RocketModel]) -> Void) {
        
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
    
    static func getImage(from url: String, completion: @escaping (UIImage?) -> Void) {
        
        AF
            .request(url, method: .get)
            .response { response in
                guard let data = response.data else { return }
                completion(UIImage(data: data))
            }
            .cacheResponse(using: .doNotCache)
        
    }
    
    static func getRocketParameters(for rocketId: String, completion: @escaping (RocketParametersModel?) -> Void) {
        
        let rocketsBaseUrl = "https://api.spacexdata.com/v4/rockets/"
        
        var rocketParameters: RocketParametersModel?
        
        AF
            .request(rocketsBaseUrl + rocketId, method: .get)
            .response { response in
                guard let data = response.data else { return }
                do {
                    rocketParameters = try JSONDecoder().decode(RocketParametersModel.self, from: data)
                    completion(rocketParameters)
                } catch {
                    print(error)
                }
            }
            .cacheResponse(using: .cache)
        
    }
    
    static func getLaunches(for rocketId: String, completion: @escaping ([LaunchModel]) -> Void) {
        
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
                    if let launcesResponse = try JSONDecoder().decode(LaunchesResponse.self, from: data).docs {
                        launches = launcesResponse
                    }
                    completion(launches)
                } catch {
                    print(error)
                }
            }
            .cacheResponse(using: .cache)
        
    }
    
}
