//
//  SettingsCell.swift
//  SpaceXLaunches
//
//  Created by Leo Malikov on 17.04.2022.
//

import UIKit

class SettingsCell: UITableViewCell {

    static let reuseIdentifier = "SettingsCell"
    
    lazy var settingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    lazy var settingSwitch: SettingsSwitch = {
        let settingSwitch = SettingsSwitch()
        settingSwitch.translatesAutoresizingMaskIntoConstraints = false
        settingSwitch.addTarget(self, action: #selector(switchChangedState(_:)), for: .valueChanged)
        return settingSwitch
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    func fillViews(settingLabel: String, settingOn: String, settingOff: String) {
        
        self.settingLabel.text = settingLabel
        
        self.settingSwitch.onLabel.text = settingOn
        self.settingSwitch.offLabel.text = settingOff
        
        guard let parameter = RocketParametersModel.getParameterByParameterRawValue(string: settingLabel) else { return }
        
        let value: Bool
        
        switch parameter {
        case .height:
            value = UserSettings.shared.height == Height.Units.m ? false : true
        case .diameter:
            value = UserSettings.shared.diameter == Diameter.Units.m ? false : true
        case .mass:
            value = UserSettings.shared.mass == Mass.Units.kg ? false : true
        case .capacity:
            value = UserSettings.shared.capacity == Capacity.Units.kg ? false : true
        }
        
        self.settingSwitch.setOn(on: value, animated: false)
        
    }
    
    private func setupUI() {
        
        backgroundColor = .darkGray3
        
        contentView.addSubview(settingLabel)
        contentView.addSubview(settingSwitch)
        
        NSLayoutConstraint.activate([
        
            settingLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            settingLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            
            settingSwitch.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            settingSwitch.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            settingSwitch.heightAnchor.constraint(equalToConstant: 40),
            settingSwitch.widthAnchor.constraint(equalToConstant: 140)
            
        ])
        
    }
    
    @objc func switchChangedState(_ sender: Any?) {
        
        guard let settingsSwitch = sender as? SettingsSwitch else { return }
        
        let state = settingsSwitch.isOn
        
        guard
            let string = settingLabel.text,
            let parameter = RocketParametersModel.getParameterByParameterRawValue(string: string)
        else { return }
        
        switch parameter {
        case .height:
            UserSettings.shared.height = state ? Height.Units.ft : Height.Units.m
        case .diameter:
            UserSettings.shared.diameter = state ? Diameter.Units.ft : Diameter.Units.m
        case .mass:
            UserSettings.shared.mass = state ? Mass.Units.lb : Mass.Units.kg
        case .capacity:
            UserSettings.shared.capacity = state ? Capacity.Units.lb : Capacity.Units.kg
        }
        
    }

}
