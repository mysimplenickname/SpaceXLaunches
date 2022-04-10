//
//  RocketNameView.swift
//  SpaceXLaunches
//
//  Created by Leo Malikov on 10.04.2022.
//

import UIKit

class RocketNameView: UIView {
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24)
        label.textColor = .white
        label.textAlignment = .left
        label.text = "nil"
        return label
    }()
    
    lazy var settingsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "gearshape"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        
        self.backgroundColor = .black
        self.layer.cornerRadius = 24
        
        let stackView = UIStackView(arrangedSubviews: [nameLabel, settingsButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.widthAnchor.constraint(equalToConstant: self.frame.width - 32).isActive = true
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        
        self.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
    }
    
}
