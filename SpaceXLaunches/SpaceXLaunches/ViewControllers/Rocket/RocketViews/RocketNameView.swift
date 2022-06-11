//
//  RocketNameView.swift
//  SpaceXLaunches
//
//  Created by Leo Malikov on 10.04.2022.
//

import UIKit

class RocketNameView: UIView {
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = .white
        label.textAlignment = .left
        label.text = "-"
        return label
    }()
    
    private(set) lazy var settingsImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let image = UIImage(systemName: "gearshape")?.withRenderingMode(.alwaysTemplate)
        imageView.image = image
        imageView.tintColor = .white
        
        imageView.isUserInteractionEnabled = true

        return imageView
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
    }
    
    func fillViews(rocketName: String?) {
        nameLabel.text = rocketName
    }
    
    private func setupUI() {
        
        backgroundColor = .black
        
        layer.cornerRadius = 24
        
        addSubview(nameLabel)
        addSubview(settingsImageView)
        
        NSLayoutConstraint.activate([
        
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            nameLabel.rightAnchor.constraint(equalTo: settingsImageView.leftAnchor),
            
            settingsImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            settingsImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            settingsImageView.heightAnchor.constraint(equalToConstant: 32),
            settingsImageView.widthAnchor.constraint(equalToConstant: 32)
            
        ])
        
    }
    
}
