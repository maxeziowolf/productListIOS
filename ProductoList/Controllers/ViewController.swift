//
//  ViewController.swift
//  ProductoList
//
//  Created by Maxeziowolf.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblPriceRegular: UILabel!
    @IBOutlet weak var lblPriceFinal: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var imageProduct: UIImageView!
    @IBOutlet weak var imageDescont: UIImageView!
    @IBOutlet weak var btnShowList: UIButton!
    @IBOutlet weak var cardProduct: UIView!
    @IBOutlet weak var containerCard: UIView!
    
    
    //MARK: Variable
    private let timeDelay = 3.0

    //MARK: Lifecycle
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
    
    //MARK: Overrides
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ListProductSegue" {
            
            if let viewController = segue.destination as? ListProductsViewController {
                
                viewController.delegate = self
            }
            
        }
        
    }

}

//MARK: Extensions
extension ViewController: ListProductsDelegate{
    
    func setInformation(product: Product) {
        
        containerCard.isHidden = false
        
        lblDescription.text = "El producto es el siguiente: "
        
        imageProduct.downloadedFrom(link: product.urlImagenes[0], contentMode: .scaleAspectFit, animated: true)
        
        lblName.setTextWithTypeAnimation(typedText: product.nombre.capitalized, characterDelay: timeDelay)
        
        lblCategory.setTextWithTypeAnimation(typedText: "\(product.category.capitalized) (\(product.codigoCategoria!))" , characterDelay: timeDelay)
        
        if product.descuento {
            
            lblPriceRegular.isHidden = false
            lblPriceFinal.isHidden = false
            imageDescont.isHidden = false
            
            UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveLinear, animations: {
                
                self.imageDescont.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                        
            }) { (success) in
                UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveLinear, animations: {
                    
                    self.imageDescont.transform = .identity
                    
                }, completion: nil)
            }
            
            lblPriceRegular.setTextWithTypeAnimation(typedText: product.precioRegular.asMoney(), characterDelay: timeDelay)
            
            lblPriceFinal.setTextWithTypeAnimation(typedText: product.precioFinal.asMoney(), characterDelay: timeDelay)
            
        }else{
            
            lblPriceRegular.isHidden = true
            lblPriceFinal.isHidden = false
            imageDescont.isHidden = true
            
            lblPriceFinal.setTextWithTypeAnimation(typedText: product.precioRegular.asMoney(), characterDelay: timeDelay)
            
        }
        
    }
    
}

