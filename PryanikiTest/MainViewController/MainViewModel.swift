//
//  MainViewModel.swift
//  PryanikiTest
//
//  Created by Alex Kulish on 26.05.2022.
//

import Foundation

protocol MainViewModelProtocol {
    var dataBlock: [DataBlock] { get }
    var views: [String] { get }
    var dictOfData: [String: DataBlock] { get }
    var updateDelegate: UpdateDelegate? { get }
    
    func fetchData(completion: @escaping () -> Void)
    func numbersOfRows() -> Int
    func fillTheDict()
    func setDelegate(delegate: UpdateDelegate)
}



class MainViewModel: MainViewModelProtocol {
    
    internal var dataBlock: [DataBlock] = []
    internal var views: [String] = []
    internal var dictOfData: [String : DataBlock] = [:]
    internal weak var updateDelegate: UpdateDelegate?
    
    init() {
        fetchData { [unowned self] in
            self.updateDelegate?.didUpdate(sender: self)
            fillTheDict()
        }
    }
    
    func fetchData(completion: @escaping () -> Void) {
        
        DispatchQueue.main.async {
            NetworkManager.shared.fetchData { dataModel in
                self.dataBlock = dataModel.data
                self.views = dataModel.view
                completion()
            }
        }
    }
    
    func numbersOfRows() -> Int {
        views.count
    }
    
    func fillTheDict() {
        for data in dataBlock {
            dictOfData[data.name] = data
        }
    }
    
    func setDelegate(delegate: UpdateDelegate) {
        self.updateDelegate = delegate
    }
    
}
