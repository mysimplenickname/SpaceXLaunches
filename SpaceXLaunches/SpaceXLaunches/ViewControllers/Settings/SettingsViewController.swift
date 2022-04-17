//
//  SettingsViewController.swift
//  SpaceXLaunches
//
//  Created by Leo Malikov on 17.04.2022.
//

import UIKit

protocol Delegate {
    func updateData()
}

class SettingsViewController: UIViewController {
    
    weak var rocketViewController: RocketViewController?
    
    lazy var navigationView: UIView = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .darkGray3
        
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .systemFont(ofSize: 16)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.text = "Настройки"
        
        let closeLabel = UILabel()
        closeLabel.translatesAutoresizingMaskIntoConstraints = false
        closeLabel.font = .boldSystemFont(ofSize: 16)
        closeLabel.textColor = .white
        closeLabel.textAlignment = .center
        closeLabel.text = "Закрыть"
        
        closeLabel.isUserInteractionEnabled = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeLabelTapped(_:)))
        closeLabel.addGestureRecognizer(tapGestureRecognizer)
        
        view.addSubview(titleLabel)
        view.addSubview(closeLabel)
        
        NSLayoutConstraint.activate([
        
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            closeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            closeLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32)
            
        ])
        
        return view
        
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .darkGray3
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        guard let rocketViewController = rocketViewController else { return }
        rocketViewController.updateData()
        
    }
    
    private func setupUI() {
        
        view.backgroundColor = .darkGray3
        
        view.addSubview(tableView)
        
        view.addSubview(navigationView)
        
        NSLayoutConstraint.activate([
        
            navigationView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            navigationView.leftAnchor.constraint(equalTo: view.leftAnchor),
            navigationView.heightAnchor.constraint(equalToConstant: 40),
            navigationView.widthAnchor.constraint(equalToConstant: view.frame.width),
            
            tableView.topAnchor.constraint(equalTo: navigationView.bottomAnchor, constant: 16),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16)
            
        ])
        
    }
    
    @objc private func closeLabelTapped(_ sender: Any?) {
        
        guard let rocketViewController = rocketViewController else { return }
        rocketViewController.updateData()
        
        dismiss(animated: true)
        
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
