//
//  UIImageView+Ext.swift
//  PryanikiTest
//
//  Created by Alex Kulish on 27.05.2022.
//

import Alamofire

extension UIImageView {
    
    func setImage(with url: String) {
        AF.request(url).responseData { [weak self] loadedData in
            let image = UIImage(data: loadedData.data ?? Data())
            DispatchQueue.main.async {
                self?.image = image
            }
        }
    }
}

