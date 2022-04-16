//
//  RocketParametersCell.swift
//  SpaceXLaunches
//
//  Created by Leo Malikov on 07.04.2022.
//

import UIKit

final class RocketParametersCell: UICollectionViewCell {
 
    static let reuseIdentifier = "RocketParametersCell"
    
    lazy var parameterValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    
    lazy var parameterNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.textColor = .gray
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
        parameterValueLabel.text = value?.description ?? "nil"
        parameterNameLabel.text = name ?? "nil"
    }
    
    private func setupUI() {
        
        contentView.backgroundColor = .darkGray2
        contentView.layer.cornerRadius = contentView.frame.height / 3
        
        let parametersStackView = UIStackView(arrangedSubviews: [parameterValueLabel, parameterNameLabel])
        parametersStackView.translatesAutoresizingMaskIntoConstraints = false
        parametersStackView.axis = .vertical
        parametersStackView.alignment = .center
        parametersStackView.distribution = .equalCentering
        parametersStackView.spacing = 4
        
        contentView.addSubview(parametersStackView)
        
        NSLayoutConstraint.activate([
            parametersStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            parametersStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
    }
    
}
