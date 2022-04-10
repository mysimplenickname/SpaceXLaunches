//
//  ShowLaunchesView.swift
//  SpaceXLaunches
//
//  Created by Leo Malikov on 10.04.2022.
//

import UIKit

class ShowLaunchesView: UIView {

    lazy var showLaunchesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Посмотреть запуски"
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
    
    private func setupUI() {
        
        self.backgroundColor = .darkGray2
        self.layer.cornerRadius = 16
        
        self.addSubview(showLaunchesLabel)
        
        NSLayoutConstraint.activate([
            showLaunchesLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            showLaunchesLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
    }
    
}
