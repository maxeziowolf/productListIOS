//
//  Response.swift
//  ProductoList
//
//  Created by Satoritech 15 on 26/05/22.
//

import Foundation


class Response: Codable {
    
    //MARK: Atributes
    var categoria: String!
    var productos: [Product]
    
    enum CodingKeys: String, CodingKey {
        
        case categoria, productos
        
    }
    
}
