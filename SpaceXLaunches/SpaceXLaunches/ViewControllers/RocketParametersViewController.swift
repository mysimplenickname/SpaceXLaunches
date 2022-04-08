//
//  RocketParametersViewController.swift
//  SpaceXLaunches
//
//  Created by Leo Malikov on 07.04.2022.
//

import UIKit

final class RocketParametersViewController: UIViewController {

    private lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 128.0, height: 128.0)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(RocketParametersCell.self, forCellWithReuseIdentifier: RocketParametersCell.reuseIdentifier)
        collectionView.allowsSelection = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
        
    }()
    
    var rocketParameters: [(String, Double?)] = [
        ("Height", nil),
        ("Diameter", nil),
        ("Mass", nil),
        ("Capacity", nil)
    ] {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkService.getRocketParameters(for: "5e9d0d95eda69955f709d1eb") { rocketParameters in
            if let rocketParameters = rocketParameters {
                self.rocketParameters = [
                    ("Height", rocketParameters.height?.meters ?? 0.0),
                    ("Diameter", rocketParameters.diameter?.meters ?? 0.0),
                    ("Mass", rocketParameters.mass?.kg ?? 0.0),
                    ("Capacity", rocketParameters.capacity[0]?.kg ?? 0.0)
                ]
            }
        }
        setupUI()
    }

    private func setupUI() {
        
        view.backgroundColor = .white
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 128),
            collectionView.widthAnchor.constraint(equalToConstant: view.frame.width - 8)
            
        ])
        
    }
    
}

extension RocketParametersViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        rocketParameters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RocketParametersCell.reuseIdentifier, for: indexPath) as? RocketParametersCell else { return UICollectionViewCell() }
        cell.fillParameters(name: rocketParameters[indexPath.row].0, value: rocketParameters[indexPath.row].1)
        return cell
    }
    
}
