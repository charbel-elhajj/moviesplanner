//
//  Utils.swift
//  moviesplanner
//
//  Created by Charbel El Hajj on 15/01/2021.
//


import Foundation
import UIKit

extension UIImageView {
    func load(urlString: String) {
        if let url = URL(string: urlString) {
            DispatchQueue.global().async {
                if let rawData  = try? Data(contentsOf: url) {
                    if let image = UIImage(data: rawData) {
                        DispatchQueue.main.async {
                            self.image = image
                        }
                    }
                }
            }
        }
    }
}