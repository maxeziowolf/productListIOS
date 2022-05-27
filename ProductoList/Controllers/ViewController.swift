//
//  ViewController.swift
//  ProductoList
//
//  Created by Satoritech 15 on 26/05/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblPriceRegular: UILabel!
    @IBOutlet weak var lblPriceFinal: UILabel!
    @IBOutlet weak var imageProduct: UIImageView!
    @IBOutlet weak var btnShowList: UIButton!
    @IBOutlet weak var cardProduct: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    //MARK: setup
    private func setupUI() {
        
        btnShowList.layer.cornerRadius = 25
        btnShowList.layer.borderColor = UIColor.blue.cgColor
        btnShowList.layer.borderWidth = 0.2
        
        cardProduct.layer.cornerRadius = 25
        cardProduct.layer.borderColor = UIColor.black.cgColor
        cardProduct.layer.borderWidth = 0.1
        cardProduct.layer.shadowRadius = 3
        cardProduct.layer.shadowOffset = CGSize(width: 8, height: 6)
        cardProduct.layer.shadowOpacity = 0.3
        cardProduct.layer.shadowColor = UIColor.black.cgColor
        
        imageProduct.layer.cornerRadius = 25
        imageProduct.layer.borderWidth = 0.1
        imageProduct.layer.borderColor = UIColor(named: "PrimaeryColor")?.cgColor
        
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
        
        
        imageProduct.downloadedFrom(link: product.urlImagenes[0], contentMode: .scaleAspectFit, animated: true)
        
        lblName.text = product.nombre.capitalized
        
        lblCategory.text = "\(product.category.capitalized) (\(product.codigoCategoria!))"
        
        if product.descuento {
            
            lblPriceRegular.isHidden = false
            lblPriceFinal.isHidden = false
            
            lblPriceRegular.text = product.precioRegular.asMoney()
            lblPriceFinal.text = product.precioFinal.asMoney()
            
        }else{
            
            lblPriceRegular.isHidden = true
            lblPriceFinal.isHidden = false
            
            lblPriceFinal.text = product.precioRegular.asMoney()
            
        }
    }
    
    
    
    
}


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

extension Double{
    func asMoney() -> String{
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "es_MX")
        formatter.numberStyle = .currency
        if let formattedTipAmount = formatter.string(from: self as NSNumber) {
            return formattedTipAmount
        }
        else{
            return "\(self)"
        }
    }
}

