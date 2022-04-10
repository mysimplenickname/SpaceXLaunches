//
//  RocketsPageViewController.swift
//  SpaceXLaunches
//
//  Created by Leo Malikov on 08.04.2022.
//

import UIKit

final class RocketViewController: UIViewController {

    lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .blue
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    var rocket: RocketModel? {
        didSet {
            setBackgroundImage()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkService.getRockets { [weak self] rockets in
            if rockets.count != 0 {
                self?.rocket = rockets[2]
            }
        }
        
        setupUI()
    }
    
    private func setBackgroundImage() {
        
        guard
            let rocket = rocket,
            let imagesLinks = rocket.imagesLinks,
            let imageUrl = imagesLinks.randomElement()
        else { return }
        
        NetworkService.getImage(from: imageUrl) { image in
            DispatchQueue.main.async { [weak self] in
                self?.backgroundImageView.image = image
            }
        }
        
    }
    
    private func setupUI() {
        
        view.addSubview(backgroundImageView)
        
        let rocketName = RocketNameView()
        rocketName.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rocketName)
        
        let rocketParametersViewController = RocketParametersViewController()
        self.addChild(rocketParametersViewController)
        let rocketParametersView = rocketParametersViewController.view!
        rocketParametersView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rocketParametersView)
        
        let rocketInfoView = RocketInfoView()
        rocketInfoView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rocketInfoView)
        
        let rocketStagesInfoView = RocketStagesInfoView()
        rocketStagesInfoView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rocketStagesInfoView)
        
        NSLayoutConstraint.activate([
            
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            backgroundImageView.rightAnchor.constraint(equalTo: view.rightAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            rocketName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            rocketName.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            rocketName.widthAnchor.constraint(equalToConstant: view.frame.width),
            rocketName.heightAnchor.constraint(equalToConstant: view.frame.width / 3),
            
            rocketParametersView.topAnchor.constraint(equalTo: rocketName.bottomAnchor),
            rocketParametersView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            rocketParametersView.widthAnchor.constraint(equalToConstant: view.frame.width),
            rocketParametersView.heightAnchor.constraint(equalToConstant: view.frame.width / 3),
            
            rocketInfoView.topAnchor.constraint(equalTo: rocketParametersView.bottomAnchor, constant: 16),
            rocketInfoView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            rocketInfoView.widthAnchor.constraint(equalToConstant: view.frame.width),
            rocketInfoView.heightAnchor.constraint(equalToConstant: view.frame.width / 3),
            
            rocketStagesInfoView.topAnchor.constraint(equalTo: rocketInfoView.bottomAnchor, constant: 16),
            rocketStagesInfoView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            rocketStagesInfoView.widthAnchor.constraint(equalToConstant: view.frame.width),
            rocketStagesInfoView.heightAnchor.constraint(equalToConstant: view.frame.width / 9 * 4)
            
        ])
        
        rocketName.layoutIfNeeded()
        rocketParametersViewController.setupUI()
        rocketInfoView.layoutIfNeeded()
        rocketStagesInfoView.layoutIfNeeded()
        
    }

}
