//
//  AELoginRequestModel.swift
//  ApiECHO
//
//  Created by Vitaly Plivachuk on 8/30/18.
//  Copyright © 2018 Vitaly Plivachuk. All rights reserved.
//

public class AELoginRequestModel: Codable, AERequestModel{
    
    public init(email:String, password:String) {
        self.email = email
        self.password = password
    }
    
    public let email:String
    public let password:String
}
