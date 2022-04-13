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
        imageView.backgroundColor = .black
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
        
        let scrollView = UIScrollView(frame: CGRect(x: 0.0, y: 0.0, width: view.frame.width, height: view.frame.height))
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        view.addSubview(scrollView)
        
        let blackView = UIView()
        blackView.translatesAutoresizingMaskIntoConstraints = false
        blackView.backgroundColor = .black
        blackView.layer.cornerRadius = 24
        scrollView.addSubview(blackView)
        
        let rocketName = RocketNameView(frame: CGRect(x: 0.0, y: 0.0, width: view.frame.width, height: view.frame.width / 3))
        rocketName.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(rocketName)
        
        let rocketParametersViewController = RocketParametersViewController()
        self.addChild(rocketParametersViewController)
        let rocketParametersView = rocketParametersViewController.view!
        rocketParametersView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(rocketParametersView)

        let rocketInfoView = RocketInfoView(frame: CGRect(x: 0.0, y: 0.0, width: view.frame.width, height: view.frame.width / 3))
        rocketInfoView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(rocketInfoView)

        let rocketFirstStageInfoView = RocketStagesInfoView(frame: CGRect(x: 0.0, y: 0.0, width: view.frame.width, height: view.frame.width / 9 * 4))
        rocketFirstStageInfoView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(rocketFirstStageInfoView)

        let rocketSecondStageInfoView = RocketStagesInfoView(frame: CGRect(x: 0.0, y: 0.0, width: view.frame.width, height: view.frame.width / 9 * 4))
        rocketSecondStageInfoView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(rocketSecondStageInfoView)

        let showLaunchesView = ShowLaunchesView(frame: CGRect(x: 0.0, y: 0.0, width: view.frame.width - 32, height: view.frame.width / 6))
        showLaunchesView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(showLaunchesView)
        
        NSLayoutConstraint.activate([
            
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            backgroundImageView.widthAnchor.constraint(equalToConstant: view.frame.width),
            backgroundImageView.heightAnchor.constraint(equalToConstant: view.frame.height),
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            rocketName.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: scrollView.frame.height / 2 - 64),
            rocketName.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            rocketName.widthAnchor.constraint(equalToConstant: scrollView.frame.width),
            rocketName.heightAnchor.constraint(equalToConstant: scrollView.frame.width / 3),

            rocketParametersView.topAnchor.constraint(equalTo: rocketName.bottomAnchor),
            rocketParametersView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            rocketParametersView.widthAnchor.constraint(equalToConstant: scrollView.frame.width),
            rocketParametersView.heightAnchor.constraint(equalToConstant: scrollView.frame.width / 3),

            rocketInfoView.topAnchor.constraint(equalTo: rocketParametersView.bottomAnchor, constant: 16),
            rocketInfoView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            rocketInfoView.widthAnchor.constraint(equalToConstant: scrollView.frame.width),
            rocketInfoView.heightAnchor.constraint(equalToConstant: scrollView.frame.width / 3),

            rocketFirstStageInfoView.topAnchor.constraint(equalTo: rocketInfoView.bottomAnchor, constant: 16),
            rocketFirstStageInfoView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            rocketFirstStageInfoView.widthAnchor.constraint(equalToConstant: scrollView.frame.width),
            rocketFirstStageInfoView.heightAnchor.constraint(equalToConstant: scrollView.frame.width / 9 * 4),

            rocketSecondStageInfoView.topAnchor.constraint(equalTo: rocketFirstStageInfoView.bottomAnchor, constant: 16),
            rocketSecondStageInfoView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            rocketSecondStageInfoView.widthAnchor.constraint(equalToConstant: scrollView.frame.width),
            rocketSecondStageInfoView.heightAnchor.constraint(equalToConstant: scrollView.frame.width / 9 * 4),

            showLaunchesView.topAnchor.constraint(equalTo: rocketSecondStageInfoView.bottomAnchor, constant: 16),
            showLaunchesView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 16),
            showLaunchesView.widthAnchor.constraint(equalToConstant: scrollView.frame.width - 32),
            showLaunchesView.heightAnchor.constraint(equalToConstant: scrollView.frame.width / 6),
            showLaunchesView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

            blackView.topAnchor.constraint(equalTo: rocketName.topAnchor),
            blackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            blackView.widthAnchor.constraint(equalToConstant: scrollView.frame.width),
            blackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 256)
            
        ])
        
    }

}
