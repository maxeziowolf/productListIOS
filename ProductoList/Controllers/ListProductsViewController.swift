//
//  ListProductsViewController.swift
//  ProductoList
//
//  Created by Satoritech 15 on 26/05/22.
//

import UIKit

protocol ListProductsDelegate {
    func setInformation(product: Product)
}


class ListProductsViewController: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var tableviewListProducts: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: Variables
    private var genericResponse: GenericResponse? = nil
    private let urlSession = UIUtils()
    public var delegate: ListProductsDelegate?
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        fetchData()
    }
    
    private func setupUI(){
        
        tableviewListProducts.dataSource = self
        tableviewListProducts.delegate = self
        
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
    }
    
    private func fetchData(){
        
        
        urlSession.getInformation(){ [weak self] response, messageError in
            
            
            
            
            DispatchQueue.main.async {
                self!.activityIndicator.stopAnimating()
                
                
                self!.genericResponse = response
                
                self!.tableviewListProducts.reloadData()
            }
           
            
        }
        
    }
    
    
}

extension ListProductsViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        genericResponse?.resultado.productos.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell=UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "mycell")
        
        cell.textLabel?.text  = genericResponse?.resultado.productos[indexPath.row].nombre
        
        cell.imageView!.image = UIImage(named: "image.product.default")
        
        cell.imageView!.downloadedFrom(link: (genericResponse?.resultado.productos[indexPath.row].urlImagenes[0])!, contentMode: .scaleAspectFit)
        
        cell.reloadInputViews()
     
      return cell
    }
    
}

extension ListProductsViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let product = (genericResponse?.resultado.productos[indexPath.row])!
        
        product.category = (genericResponse?.resultado.categoria)!
        
        delegate?.setInformation(product: product)
        
        navigationController?.popViewController(animated: true)
        
    }
    
}
