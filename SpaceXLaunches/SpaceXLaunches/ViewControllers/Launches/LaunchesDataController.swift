//
//  LaunchesDataController.swift
//  SpaceXLaunches
//
//  Created by Leo Malikov on 16.04.2022.
//

import Foundation

class LaunchesDataController {
    
    weak var launchesViewController: LaunchesViewController?
    
    var launches: [LaunchModel]?
    
    func getLaunches(for rocketId: String) {
        
        NetworkService.getLaunches(for: rocketId) { launches in
            self.launches = launches.reversed()
            
            DispatchQueue.main.async { [weak self] in
                self?.launchesViewController?.tableView.reloadData()
            }
        }
        
    }
    
    func getNumberOfLaunches() -> Int {
        guard let launches = launches else { return 0 }
        return launches.count
    }
    
    func getLaunchName(for index: Int) -> String? {
        return launches?[index].name
    }
    
    func getLaunchDate(for index: Int) -> String? {
        return DataFormatterService.formatDate(dateString: launches?[index].date ?? "", option: .complex)
    }
    
    func getLaunchStatus(for index: Int) -> Bool? {
        return launches?[index].success
    }
    
}
