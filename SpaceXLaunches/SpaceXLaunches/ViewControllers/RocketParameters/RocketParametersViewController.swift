//
//  RocketParametersViewController.swift
//  SpaceXLaunches
//
//  Created by Leo Malikov on 07.04.2022.
//

import UIKit

final class RocketParametersViewController: UIViewController {

    lazy var collectionView: UICollectionView = {

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
    
    var rocketParameters: [(String, Double?)] = [
        ("Высота", nil),
        ("Диаметр", nil),
        ("Масса", nil),
        ("Нагрузка", nil)
    ] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getRocketParameters()
        setupUI()
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
    
    private func getRocketParameters() {
        NetworkService.getRocketParameters(for: "5e9d0d95eda69955f709d1eb") { [weak self] rocketParameters in
            if let rocketParameters = rocketParameters {
                self?.rocketParameters = [
                    ("Высота, m", rocketParameters.height?.meters ?? 0.0),
                    ("Диаметр, m", rocketParameters.diameter?.meters ?? 0.0),
                    ("Масса, kg", rocketParameters.mass?.kg ?? 0.0),
                    ("Нагрузка, kg", rocketParameters.capacity?[0].kg ?? 0.0)
                ]
            }
        }
    }
    
}

extension RocketParametersViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        rocketParameters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RocketParametersCell.reuseIdentifier, for: indexPath) as? RocketParametersCell else { return UICollectionViewCell() }
        cell.fillParameters(name: rocketParameters[indexPath.row].0, value: rocketParameters[indexPath.row].1)
        return cell
    }
    
}
