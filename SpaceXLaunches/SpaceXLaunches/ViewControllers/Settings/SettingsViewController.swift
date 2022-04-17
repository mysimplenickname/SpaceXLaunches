//
//  SettingsViewController.swift
//  SpaceXLaunches
//
//  Created by Leo Malikov on 17.04.2022.
//

import UIKit

class SettingsViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
        tableView.backgroundColor = .darkGray3
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        
        view.backgroundColor = .darkGray3
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
        
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
            
        ])
        
    }

}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RocketParametersModel.Parameters.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.reuseIdentifier, for: indexPath) as? SettingsCell else { return UITableViewCell() }
        
        var settingLabel: String = ""
        var settingOn: String = ""
        var settingOff: String = ""
        
        let parameter = RocketParametersModel.Parameters.allCases[indexPath.row]
        
        switch parameter {
        case .height:
            settingLabel = parameter.rawValue
            settingOn = Height.Units.m.rawValue
            settingOff = Height.Units.ft.rawValue
        case .diameter:
            settingLabel = parameter.rawValue
            settingOn = Diameter.Units.m.rawValue
            settingOff = Diameter.Units.ft.rawValue
        case .mass:
            settingLabel = parameter.rawValue
            settingOn = Mass.Units.kg.rawValue
            settingOff = Mass.Units.lb.rawValue
        case .capacity:
            settingLabel = parameter.rawValue
            settingOn = Capacity.Units.kg.rawValue
            settingOff = Capacity.Units.lb.rawValue
        }
        
        cell.fillViews(settingLabel: settingLabel, settingOn: settingOn, settingOff: settingOff)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60.0
    }
    
}
