//
//  RocketParametersCell.swift
//  SpaceXLaunches
//
//  Created by Leo Malikov on 07.04.2022.
//

import UIKit

final class RocketParametersCell: UICollectionViewCell {
 
    static let reuseIdentifier = "RocketParametersCell"
    
    private lazy var parameterNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private lazy var parameterValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    func fillParameters(name: String?, value: Double?) {
        print(name, value)
        parameterNameLabel.text = name ?? "nil"
        parameterValueLabel.text = value?.description ?? "nil"
    }
    
    private func setupUI() {
        
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.borderWidth = 2
        
        let parametersStackView = UIStackView(arrangedSubviews: [parameterNameLabel, parameterValueLabel])
        parametersStackView.translatesAutoresizingMaskIntoConstraints = false
        parametersStackView.axis = .vertical
        parametersStackView.alignment = .center
        parametersStackView.distribution = .equalCentering
        
        contentView.addSubview(parametersStackView)
        
        NSLayoutConstraint.activate([
            parametersStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            parametersStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
    }
    
}
