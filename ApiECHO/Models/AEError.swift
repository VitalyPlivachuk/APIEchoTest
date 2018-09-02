//
//  AEError.swift
//  ApiECHO
//
//  Created by Vitaly Plivachuk on 8/30/18.
//  Copyright © 2018 Vitaly Plivachuk. All rights reserved.
//

import Foundation

class AEError: Error, LocalizedError, Codable{
    let name:String?
    let field:String?
    let message:String
    let code:Int?
    let status:Int?
    
    @available(*, deprecated, message: "Do not use.")
    init() {
        fatalError("Swift 4.1")
    }
    
    var errorDescription: String?{
        return message
    }
}
