//
//  LaunchesCell.swift
//  SpaceXLaunches
//
//  Created by Leo Malikov on 16.04.2022.
//

import UIKit

class LaunchesCell: UITableViewCell {

    static let reuseIdentifier = "LaunchesCell"
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18)
        label.textColor = .white
        label.textAlignment = .left
        label.text = nil
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.textColor = .gray
        label.textAlignment = .left
        label.text = nil
        return label
    }()
    
    private lazy var statusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    func fillLaunch(name: String?, date: String?, success: Bool?) {
        
        nameLabel.text = name
        dateLabel.text = date
        
        guard let success = success else { return }
        
        let image = success ? UIImage(systemName: "arrow.up")?.withRenderingMode(.alwaysTemplate) : UIImage(systemName: "arrow.down")?.withRenderingMode(.alwaysTemplate)
        
        statusImageView.image = image
        statusImageView.tintColor = success ? .systemGreen : .systemRed
        
    }
    
    private func setupUI() {
        
        backgroundColor = .black
    
        contentView.backgroundColor = .darkGray2
        
        contentView.layer.cornerRadius = contentView.frame.height / 2
        
        let verticalStackView = UIStackView(arrangedSubviews: [nameLabel, dateLabel])
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .fill
        verticalStackView.distribution = .equalCentering
        
        contentView.addSubview(verticalStackView)
        
        contentView.addSubview(statusImageView)
        
        let spacingBetween = verticalStackView.rightAnchor.constraint(equalTo: statusImageView.leftAnchor, constant: 8)
        spacingBetween.priority = .defaultLow
        
        let spacingAfter = statusImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -32)
        spacingAfter.priority = .defaultHigh
        
        NSLayoutConstraint.activate([
            
            verticalStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32),
            verticalStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 32),
            spacingBetween,
            verticalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32),
            
            statusImageView.centerYAnchor.constraint(equalTo: verticalStackView.centerYAnchor),
            spacingAfter
            
        ])
        
    }

}
