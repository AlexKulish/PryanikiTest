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

//        configureUpdateDelegate()
    }
}

// MARK: - UpdateDelegate

//extension ViewController: UpdateDelegate {
//    func didUpdate(sender: MainViewModel) {
//        collectionView.reloadData()
//    }
//
//    private func configureUpdateDelegate() {
//        viewModel.setDelegate(delegate: self)
//    }
//}


