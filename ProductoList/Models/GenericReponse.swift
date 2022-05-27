//
//  GenericReponse.swift
//  ProductoList
//
//  Created by Satoritech 15 on 26/05/22.
//

import Foundation


class GenericResponse: Codable {
    
    //MARK: Atributes
    var codigo: String!
    var mensaje: String!
    var folio: String!
    var resultado: Response!
    
    enum CodingKeys: String, CodingKey {
        
        case codigo, mensaje, folio, resultado
        
    }
    
}
