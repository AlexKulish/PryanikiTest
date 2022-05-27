//
//  ViewController.swift
//  PryanikiTest
//
//  Created by Alex Kulish on 26.05.2022.
//

import UIKit

protocol UpdateDelegate: AnyObject {
    func didUpdate(sender: MainViewModel)
}

class ViewController: UIViewController {
    
    private let cellID = "cell"
    private var collectionView: UICollectionView!
    private var viewModel: MainViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MainViewModel()
        configureCollectionView()
        setupConstraints()
        configureUpdateDelegate()
    }
    
    private func showAlert(with name: String){
        let alert = UIAlertController(title: "Объект", message: "\(name)", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(DataViewCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - UpdateDelegate

extension ViewController: UpdateDelegate {
    func didUpdate(sender: MainViewModel) {
        collectionView.reloadData()
    }

    private func configureUpdateDelegate() {
        viewModel.setDelegate(delegate: self)
    }
}

// MARK: - UICollectionView Delegate and DataSource

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numbersOfRows()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? DataViewCell else { return UICollectionViewCell() }
        let view = viewModel.views[indexPath.item]
        let data = viewModel.dictOfData[view]
        let selectedId = data?.data.selectedId
        
        switch view {
        case "selector":
            cell.titleLabel.text = data?.data.variants?[selectedId ?? 0].text
        case "picture":
            cell.titleLabel.text = ""
        default:
            cell.titleLabel.text = data?.data.text
        }
        cell.imageView.setImage(with: data?.data.url ?? "")
        cell.layer.borderWidth = 1
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewData = viewModel.views[indexPath.item]
        let data = viewModel.dictOfData[viewData]
        
        if let name = data?.name {
            let rect = NSString(string: name).boundingRect(
                with: CGSize(width: view.frame.width, height: 1000),
                options: NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin),
                attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)],
                context: nil
            )
            return CGSize(width: view.frame.width, height: rect.height + 50)
        }
        return CGSize(width: view.frame.width, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let views = viewModel.views[indexPath.row]
        let viewData = viewModel.dictOfData[views]
        let name = viewData?.data.text
//        let viewData = viewModel.views[indexPath.item]
        showAlert(with: name ?? "")
    }
}
