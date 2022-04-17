//
//  RocketParametersViewController.swift
//  SpaceXLaunches
//
//  Created by Leo Malikov on 07.04.2022.
//

import UIKit

final class RocketParametersViewController: UIViewController {
    
    private(set) lazy var collectionView: UICollectionView = {

        let itemSize = view.frame.width / 3 - 20
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(RocketParametersCell.self, forCellWithReuseIdentifier: RocketParametersCell.reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .black
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.allowsSelection = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
        
    }()
    
    private var rocketParametersDataController: RocketParametersDataController?
    
    var rocketId: String? {
        didSet {
            guard let rocketId = rocketId else { return }
            rocketParametersDataController?.getRocketParameters(for: rocketId)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDataController()
        setupUI()
    }
    
    private func setupDataController() {
        rocketParametersDataController = RocketParametersDataController()
        rocketParametersDataController?.rocketParametersViewController = self
    }
        
    private func setupUI() {
        
        view.backgroundColor = .black
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: view.frame.width / 3),
            collectionView.widthAnchor.constraint(equalToConstant: view.frame.width)
        ])
        
    }
    
}

extension RocketParametersViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rocketParametersDataController?.getParametersCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RocketParametersCell.reuseIdentifier,
            for: indexPath
        ) as? RocketParametersCell else { return UICollectionViewCell() }
        
        cell.fillParameters(
            name: rocketParametersDataController?.getParameterName(for: indexPath.row),
            value: rocketParametersDataController?.getParameterValue(for: indexPath.row)
        )
        
        return cell
        
    }
    
}
