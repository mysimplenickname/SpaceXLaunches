//
//  RocketStagesInfoView.swift
//  SpaceXLaunches
//
//  Created by Leo Malikov on 09.04.2022.
//

import UIKit

class RocketStagesInfoView: UIView {

    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .left
        label.text = "Ступень".capitalized
        return label
    }()
    
    private lazy var enginesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.textColor = .lightGray
        label.textAlignment = .left
        label.text = "Количество двигателей"
        return label
    }()
    
    private lazy var enginesValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.textAlignment = .right
        label.text = "nil"
        return label
    }()
    
    private lazy var fuelAmountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.textColor = .lightGray
        label.textAlignment = .left
        label.text = "Количество топлива"
        return label
    }()
    
    private lazy var fuelAmountValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.textAlignment = .right
        label.text = "nil"
        return label
    }()
    
    private lazy var fuelAmountUnitsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .gray
        label.textAlignment = .center
        label.text = "ton"
        return label
    }()
    
    private lazy var burnTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.textColor = .lightGray
        label.textAlignment = .left
        label.text = "Время сгорания"
        return label
    }()
    
    private lazy var burnTimeValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.textAlignment = .right
        label.text = "nil"
        return label
    }()
    
    private lazy var burnTimeUnitsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .gray
        label.textAlignment = .center
        label.text = "sec"
        return label
    }()
    
    private var layout: [(UIView, UIView, UIView?)] {
        return [
            (enginesLabel, enginesValueLabel, nil),
            (fuelAmountLabel, fuelAmountValueLabel, fuelAmountUnitsLabel),
            (burnTimeLabel, burnTimeValueLabel, burnTimeUnitsLabel)
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
    
    func fillViews(label: String?, engines: String?, fuelAmount: String?, burnTime: String?) {
        mainLabel.text = label
        enginesValueLabel.text = engines
        fuelAmountValueLabel.text = fuelAmount
        burnTimeValueLabel.text = burnTime
    }
    
    private func setupUI() {
        
        self.backgroundColor = .black
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalCentering
        
        stackView.addArrangedSubview(mainLabel)
        
        for line in layout {
            
            let lineStackView = UIStackView()
            lineStackView.translatesAutoresizingMaskIntoConstraints = false
            lineStackView.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
            lineStackView.axis = .horizontal
            lineStackView.alignment = .fill
            lineStackView.distribution = .fill
            lineStackView.spacing = 4
            
            let subLineStackView = UIStackView(arrangedSubviews: [line.0, line.1])
            subLineStackView.translatesAutoresizingMaskIntoConstraints = false
            subLineStackView.widthAnchor.constraint(equalToConstant: self.frame.width - 80).isActive = true
            subLineStackView.axis = .horizontal
            subLineStackView.alignment = .fill
            subLineStackView.distribution = .fill
            
            lineStackView.addArrangedSubview(subLineStackView)
            
            if let units = line.2 {
                lineStackView.addArrangedSubview(units)
            } else {
                let view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 80, height: 30))
                view.translatesAutoresizingMaskIntoConstraints = false
                lineStackView.addArrangedSubview(view)
            }
            
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
