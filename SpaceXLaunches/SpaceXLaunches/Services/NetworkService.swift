//
//  NetworkService.swift
//  SpaceXLaunches
//
//  Created by Leo Malikov on 05.04.2022.
//

import UIKit

enum NetworkError: Error {
    case invalidStatusCode(statusCode: Int)
}

extension NetworkError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .invalidStatusCode(let statusCode):
            return NSLocalizedString("Invalid response code: \(statusCode)", comment: "Comment?")
        }
    }
    
}

final class NetworkService {
    
    static func getRockets(completion: @escaping ([RocketModel]?, Error?) -> Void) {
        
        let rocketsBaseUrl: URL = URL(string: "https://api.spacexdata.com/v4/rockets")!
        
        var rockets: [RocketModel] = []
        
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.timeoutIntervalForRequest = 10
        sessionConfiguration.timeoutIntervalForResource = 30
        
        let session = URLSession(configuration: sessionConfiguration)
        
        session.dataTask(with: rocketsBaseUrl) { (data, response, error) in
            
            guard
                let data = data,
                let response = response as? HTTPURLResponse,
                error == nil
            else {
                completion(nil, error)
                return
            }
            
            guard (200..<300) ~= response.statusCode else {
                completion(nil, NetworkError.invalidStatusCode(statusCode: response.statusCode))
                return
            }
            
            do {
                rockets = try JSONDecoder().decode([RocketModel].self, from: data)
            } catch let error {
                completion(nil, error)
                return
            }
            
            DispatchQueue.main.async {
                completion(rockets, nil)
            }
            
        }.resume()
        
    }
    
    static func getImage(from url: String, completion: @escaping (UIImage?) -> Void) {
        
        let url: URL = URL(string: url)!
        let request = URLRequest(url: url)
        
        let MB: Int = 1024 * 1024
        let urlCache = URLCache(memoryCapacity: 50 * MB, diskCapacity: 50 * MB, diskPath: "./images")
        
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.timeoutIntervalForRequest = 10
        sessionConfiguration.timeoutIntervalForResource = 30
        sessionConfiguration.urlCache = urlCache
        
        let session = URLSession(configuration: sessionConfiguration)
        
        session.dataTask(with: request) { (data, response, error) in
            
            guard
                let data = data,
                let response = response as? HTTPURLResponse,
                (200..<300) ~= response.statusCode,
                error == nil
            else {
                return
            }
                        
            DispatchQueue.main.async {
                completion(UIImage(data: data))
            }
            
        }.resume()
        
    }
    
    static func getRocketParameters(for rocketId: String, completion: @escaping (RocketParametersModel?) -> Void) {
        
        let rocketsBaseUrl: URL = URL(string: "https://api.spacexdata.com/v4/rockets/\(rocketId)")!
        
        var rocketParameters: RocketParametersModel?
        
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.timeoutIntervalForRequest = 10
        sessionConfiguration.timeoutIntervalForResource = 30
        
        let session = URLSession(configuration: sessionConfiguration)
        
        session.dataTask(with: rocketsBaseUrl) { (data, response, error) in
            
            guard
                let data = data,
                let response = response as? HTTPURLResponse,
                (200..<300) ~= response.statusCode,
                error == nil
            else {
                return
            }
            
            do {
                rocketParameters = try JSONDecoder().decode(RocketParametersModel.self, from: data)
            } catch {
                return
            }
            
            DispatchQueue.main.async {
                completion(rocketParameters)
            }
            
        }.resume()
        
    }
    
    static func getLaunches(for rocketId: String, completion: @escaping ([LaunchModel]?, Error?) -> Void) {
        
        let launchesBaseUrl: URL = URL(string: "https://api.spacexdata.com/v4/launches/query")!
        
        var request = URLRequest(url: launchesBaseUrl)
        request.httpMethod = "POST"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let parameters: [String: Any] =
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
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            completion(nil, error)
            return
        }
        
        var launches: [LaunchModel] = []
        
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.timeoutIntervalForRequest = 10
        sessionConfiguration.timeoutIntervalForResource = 30
        
        let session = URLSession(configuration: sessionConfiguration)
        
        session.dataTask(with: request) { (data, response, error) in
            
            guard
                let data = data,
                let response = response as? HTTPURLResponse,
                error == nil
            else {
                completion(nil, error)
                return
            }
            
            guard (200..<300) ~= response.statusCode else {
                completion(nil, NetworkError.invalidStatusCode(statusCode: response.statusCode))
                return
            }
            
            do {
                if let launcesResponse = try JSONDecoder().decode(LaunchesResponse.self, from: data).docs {
                    launches = launcesResponse
                }
            } catch let error {
                completion(nil, error)
                return
            }
            
            DispatchQueue.main.async {
                completion(launches, nil)
            }
            
        }.resume()
        
    }
    
}
