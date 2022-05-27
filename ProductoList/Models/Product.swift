//
//  Product.swift
//  ProductoList
//
//  Created by Satoritech 15 on 26/05/22.
//

import Foundation

//
// MARK: - Track
//

/// Query service creates Track objects
class Product: Codable {
    
    var id: String!
    var nombre: String!
    var precioRegular: Double!
    var urlImagenes: [String]!
//    "idLinea":5,
//    "codigoCategoria":"C",
//    "idModalidad":21,
//    "relevancia":0,
//    "lineaCredito":"",
//    "pagoSemanalPrincipal":119,
//    "plazoPrincipal":96,
//    "disponibleCredito":true,
//    "abonosSemanales":[
//        {
//            "plazo":156,
//            "montoAbono":156,
//            "montoDescuentoAbono":119,
//            "montoUltimoAbono":187,
//            "montoFinalCredito":13530,
//            "idPromocion":1,
//            "montoDescuentoElektra":10,
//            "montoDescuentoBanco":10,
//            "precio":6999,
//            "montoAbonoDigital":187
//        }
//    ],
//    "sku":"1009286",
//    "nombre":"Pantalla LED HKPro 32'' HD Smart TV HKP32SM8",
//    "urlImagenes":[
//    "https://elektraqa.vteximg.com.br/arquivos/ids/1141189/1009286.jpg?v=637691369840400000",
//    "https://elektraqa.vteximg.com.br/arquivos/ids/1141190/1009286-d1.jpg?v=637691370447900000"
//    ],
//    "precioRegular":6000,
//    "precioFinal":5000,
//    "porcentajeDescuento":16.666666666666657,
//    "descuento":true,
//    "precioCredito":5000,
//    "montoDescuento":1000
    
    enum CodingKeys: String, CodingKey {
        
        case id, nombre, precioRegular, urlImagenes
        
    }
}
