//
//  AERequestModel.swift
//  ApiECHO
//
//  Created by Vitaly Plivachuk on 8/30/18.
//  Copyright © 2018 Vitaly Plivachuk. All rights reserved.
//

public protocol AERequestModel: Codable {
    var email:String {get}
    var password:String {get}
}
