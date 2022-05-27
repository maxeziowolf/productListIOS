//
//  GenericReponse.swift
//  ProductoList
//
//  Created by Maxeziowolf.
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
