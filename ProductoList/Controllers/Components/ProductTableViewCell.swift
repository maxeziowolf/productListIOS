//
//  ProductTableViewCell.swift
//  ProductoList
//
//  Created by Maxeziowolf
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    //MARK: Outlets
    @IBOutlet weak var imageProduct: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    
    //MARK: Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    //MARK: setups
    private func setupUI(){
        
        imageProduct.layer.cornerRadius = 15
        imageProduct.layer.borderWidth = 0.1
        imageProduct.layer.borderColor = UIColor(named: "PrimaeryColor")?.cgColor
        
    }
    
    public func setupInformation (product: Product){
        
        lblName.text = product.nombre.capitalized
        
        lblPrice.text = product.precioFinal.asMoney()
        
        imageProduct.downloadedFrom(link: product.urlImagenes[0], contentMode: .scaleAspectFit)
        
    }
    
}
