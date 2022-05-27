//
//  Response.swift
//  ProductoList
//
//  Created by Maxeziowolf.
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
