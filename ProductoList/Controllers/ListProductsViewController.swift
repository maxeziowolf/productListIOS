//
//  ListProductsViewController.swift
//  ProductoList
//
//  Created by Maxeziowolf.
//

import UIKit

//MARK: Protocolos
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
    
    //MARK: Setups
    private func setupUI(){
        
        tableviewListProducts.dataSource = self
        tableviewListProducts.delegate = self
        tableviewListProducts.separatorStyle = .none
        tableviewListProducts.separatorColor = .clear
        tableviewListProducts.register(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductTableViewCell")
        tableviewListProducts.reloadData()
        
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.transform = activityIndicator.transform.scaledBy(x: 2.0, y: 2.0)
        
    }
    
    //MARK: Fecth
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

//MARK: Extension
extension ListProductsViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        genericResponse?.resultado.productos.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath)
            as! ProductTableViewCell
        cell.setupInformation(product: (genericResponse?.resultado.productos[indexPath.row])!)
        
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
