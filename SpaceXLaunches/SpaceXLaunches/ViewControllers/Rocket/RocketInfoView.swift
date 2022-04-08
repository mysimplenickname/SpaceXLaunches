//
//  RocketInfoCell.swift
//  SpaceXLaunches
//
//  Created by Leo Malikov on 08.04.2022.
//

import UIKit

class RocketInfoView: UIView {
    
    lazy var firstLaunchLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.textColor = .gray
        label.text = "Первый запуск"
        label.textAlignment = .left
        return label
    }()
    
    lazy var firstLaunchValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.text = "nil"
        label.textAlignment = .right
        return label
    }()
    
    lazy var countryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.textColor = .gray
        label.text = "Страна"
        label.textAlignment = .left
        return label
    }()
    
    lazy var countryValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.text = "nil"
        label.textAlignment = .right
        return label
    }()
    
    lazy var costLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.textColor = .gray
        label.text = "Стоимость запуска"
        label.textAlignment = .left
        return label
    }()
    
    lazy var costValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.text = "nil"
        label.textAlignment = .right
        return label
    }()
    
    private var layout: [(UIView, UIView)] {
        return [
            (firstLaunchLabel, firstLaunchValueLabel),
            (countryLabel, countryValueLabel),
            (costLabel, costValueLabel)
        ]
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        
        self.backgroundColor = .white
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        
        for line in layout {
            
            let lineStackView = UIStackView(arrangedSubviews: [line.0, line.1])
            lineStackView.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
            lineStackView.translatesAutoresizingMaskIntoConstraints = false
            lineStackView.axis = .horizontal
            lineStackView.alignment = .fill
            lineStackView.distribution = .fill
            
            stackView.addArrangedSubview(lineStackView)
            
        }
        
        self.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            stackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            stackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16)
        ])
        
    }
    
}
