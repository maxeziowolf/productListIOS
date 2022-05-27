//
//  ViewController.swift
//  ProductoList
//
//  Created by Satoritech 15 on 26/05/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imageProduct: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ListProductSegue" {
            
            if let viewController = segue.destination as? ListProductsViewController {
                
                viewController.delegate = self
            }
            
        }
        
    }

}

extension ViewController: ListProductsDelegate{
    
    func setInformation(product: Product) {
        lblName.text = product.nombre
        
        imageProduct.downloadedFrom(link: product.urlImagenes[0], contentMode: .scaleToFill)
    }
    
    
    
    
}


extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}

