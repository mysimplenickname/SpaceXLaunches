//
//  RocketsPageViewController.swift
//  SpaceXLaunches
//
//  Created by Leo Malikov on 08.04.2022.
//

import UIKit

final class RocketViewController: UIViewController {
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: view.frame.width, height: view.frame.height))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .black
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.style = .medium
        activityIndicator.color = .white
        return activityIndicator
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: CGRect(x: 0.0, y: 0.0, width: view.frame.width, height: view.frame.height))
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var blackView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.layer.cornerRadius = 24
        return view
    }()
    
    private lazy var rocketNameView: RocketNameView = {
        
        let rocketNameView = RocketNameView(frame: CGRect(x: 0.0, y: 0.0, width: view.frame.width, height: view.frame.width / 3))
        rocketNameView.translatesAutoresizingMaskIntoConstraints = false
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(settingsButtonPressed(_:)))
        rocketNameView.settingsImageView.addGestureRecognizer(tapGestureRecognizer)
        
        return rocketNameView
        
    }()
    
    private lazy var rocketInfoView: RocketInfoView = {
        let rocketInfoView = RocketInfoView(frame: CGRect(x: 0.0, y: 0.0, width: view.frame.width, height: view.frame.width / 3))
        rocketInfoView.translatesAutoresizingMaskIntoConstraints = false
        return rocketInfoView
    }()
    
    private lazy var rocketFirstStageInfoView: RocketStagesInfoView = {
        let rocketFirstStageInfoView = RocketStagesInfoView(frame: CGRect(x: 0.0, y: 0.0, width: view.frame.width, height: view.frame.width / 9 * 4))
        rocketFirstStageInfoView.translatesAutoresizingMaskIntoConstraints = false
        return rocketFirstStageInfoView
    }()
    
    private lazy var rocketSecondStageInfoView: RocketStagesInfoView = {
        let rocketSecondStageInfoView = RocketStagesInfoView(frame: CGRect(x: 0.0, y: 0.0, width: view.frame.width, height: view.frame.width / 9 * 4))
        rocketSecondStageInfoView.translatesAutoresizingMaskIntoConstraints = false
        return rocketSecondStageInfoView
    }()
    
    private lazy var showLaunchesView: ShowLaunchesView = {
        let showLaunchesView = ShowLaunchesView(frame: CGRect(x: 0.0, y: 0.0, width: view.frame.width - 32, height: view.frame.width / 6))
        showLaunchesView.translatesAutoresizingMaskIntoConstraints = false
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showLaunchesButtonPressed(_:)))
        showLaunchesView.addGestureRecognizer(tapGestureRecognizer)
        return showLaunchesView
    }()
    
    lazy var rocketParametersViewController: RocketParametersViewController = {
        return RocketParametersViewController()
    }()
    
    private var rocketDataController: RocketDataController?
    
    var rocket: RocketModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupDataController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let rocket = rocket else { return }
        
        DispatchQueue.main.async { [weak self] in
            self?.rocketDataController?.getData(for: rocket)
        }
        
    }
    
    func setBackgroundImage(with image: UIImage?) {
        backgroundImageView.image = image
    }
    
    func fillRocketName(rocketName: String?) {
        rocketNameView.fillViews(rocketName: rocketName)
    }
    
    func fillRocketInfoView(firstLaunch: String?, country: String?, launchCost: String?) {
        rocketInfoView.fillViews(
            firstLaunch: firstLaunch,
            country: country,
            cost: launchCost
        )
    }
    
    func fillRocketFirstStageInfoView(text: String = "Первая ступень".uppercased(), engines: String?, fuelAmount: String?, burnTime: String?) {
        rocketFirstStageInfoView.fillViews(
            label: text,
            engines: engines,
            fuelAmount: fuelAmount,
            burnTime: burnTime
        )
    }
    
    func fillRocketSecondStageInfoView(text: String = "Вторая ступень".uppercased(), engines: String?, fuelAmount: String?, burnTime: String?) {
        rocketSecondStageInfoView.fillViews(
            label: text,
            engines: engines,
            fuelAmount: fuelAmount,
            burnTime: burnTime
        )
    }
    
    private func setupDataController() {
        rocketDataController = RocketDataController()
        rocketDataController?.rocketViewController = self
    }
    
    private func setupUI() {
        
        view.backgroundColor = .black
        
        view.addSubview(backgroundImageView)
        
        view.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
        
        view.addSubview(scrollView)
        
        scrollView.addSubview(blackView)
        
        scrollView.addSubview(rocketNameView)
        
        addChild(rocketParametersViewController)
        let rocketParametersView = rocketParametersViewController.view!
        rocketParametersView.translatesAutoresizingMaskIntoConstraints = false
        rocketParametersViewController.didMove(toParent: self)
        scrollView.addSubview(rocketParametersView)

        scrollView.addSubview(rocketInfoView)

        scrollView.addSubview(rocketFirstStageInfoView)

        scrollView.addSubview(rocketSecondStageInfoView)

        scrollView.addSubview(showLaunchesView)
        
        NSLayoutConstraint.activate([
            
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            backgroundImageView.widthAnchor.constraint(equalToConstant: view.frame.width),
            backgroundImageView.heightAnchor.constraint(equalToConstant: view.frame.height),
            
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -64),
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            rocketNameView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: scrollView.frame.height / 2 - 64),
            rocketNameView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            rocketNameView.widthAnchor.constraint(equalToConstant: scrollView.frame.width),
            rocketNameView.heightAnchor.constraint(equalToConstant: scrollView.frame.width / 3),

            rocketParametersView.topAnchor.constraint(equalTo: rocketNameView.bottomAnchor),
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

            blackView.topAnchor.constraint(equalTo: rocketNameView.topAnchor),
            blackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            blackView.widthAnchor.constraint(equalToConstant: scrollView.frame.width),
            blackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 256)
            
        ])
        
    }
    
    @objc private func showLaunchesButtonPressed(_ sender: Any?) {
        rocketDataController?.showLaunches()
    }
    
    @objc private func settingsButtonPressed(_ sender: Any?) {
        rocketDataController?.showSettings()
    }

}
