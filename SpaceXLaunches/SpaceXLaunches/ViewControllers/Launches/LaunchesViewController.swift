//
//  LaunchesViewController.swift
//  SpaceXLaunches
//
//  Created by Leo Malikov on 16.04.2022.
//

import UIKit

class LaunchesViewController: UIViewController {

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(LaunchesCell.self, forCellReuseIdentifier: LaunchesCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .black
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
        tableView.sectionFooterHeight = 0
        return tableView
    }()

    private var launchesDataController: LaunchesDataController?
    
    var rocketId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupDataController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let rocketId = rocketId else { return }
        launchesDataController?.getLaunches(for: rocketId)
    }
    
    private func setupDataController() {
        launchesDataController = LaunchesDataController()
        launchesDataController?.launchesViewController = self
    }
    
    private func setupUI() {
        
        view.backgroundColor = .black
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
        
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
        ])
        
    }
    
}

extension LaunchesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        launchesDataController?.getNumberOfLaunches() ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LaunchesCell.reuseIdentifier, for: indexPath) as? LaunchesCell else { return UITableViewCell() }
        cell.fillLaunch(name: launchesDataController?.getLaunchName(for: indexPath.section), date: launchesDataController?.getLaunchDate(for: indexPath.section), success: launchesDataController?.getLaunchStatus(for: indexPath.section))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        view.frame.width / 3 - 20
    }
    
}
