//
//  UIImageExtensions.swift
//  ProductoList
//
//  Created by Maxeziowolf
//

import UIKit


extension UIImageView {
    
    func downloadedFrom(url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit, animated: Bool = false) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                
                if animated {
                    
                    UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveLinear, animations: {
                        
                        self.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                                
                    }) { (success) in
                        UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveLinear, animations: {
                            
                            self.image = image
                            self.transform = .identity
                            
                        }, completion: nil)
                    }
                    
                }else{
                    
                    self.image = image
                    
                }
                
            }
            }.resume()
    }
    
    func downloadedFrom(link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit, animated: Bool = false) {
        
        guard let url = URL(string: link) else { return }
        
        downloadedFrom(url: url, contentMode: mode, animated: animated)
    }
    
}
