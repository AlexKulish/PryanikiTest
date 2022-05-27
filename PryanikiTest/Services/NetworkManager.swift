//
//  NetworkManager.swift
//  PryanikiTest
//
//  Created by Alex Kulish on 26.05.2022.
//

import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let url = "https://pryaniky.com/static/json/sample.json"
    
    private init() {}
    
    func fetchData(completion: @escaping(DataModel) -> Void) {
        guard let url = URL(string: url) else { return }

        AF.request(url).validate().responseDecodable(of: DataModel.self) { response in
            switch response.result {
            case .success(let dataModel):
                completion(dataModel)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
